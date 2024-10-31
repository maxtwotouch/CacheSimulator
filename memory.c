/** @file memory.c
 *  @brief Implements starting point for a memory hierarchy with caching and RAM.
 *  @see memory.h
 */

#include "memory.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define L1_INSTRUCTION_CACHE_SIZE (32 * 1024) // 32 KB
#define L1_DATA_CACHE_SIZE (32 * 1024) // 32 KB
#define L2_CACHE_SIZE (256  * 1024) // 256 KB
#define CACHE_LINE_SIZE 512 // bytes per cache line
#define L1_ASSOCIATIVITY 4 // 4-way set associative for L1 instruction
#define L1_DATA_ASSOCIATIVITY 8 // 8-way set associative for L1 data
#define L2_ASSOCIATIVITY 8 // 8-way set associative for L2


typedef struct block {
    data_t *data; // Pointer to data, which can be dynamically allocated if necessary.
    unsigned int tag;
    int valid;
    int dirty;
    int age; // For implementing LRU or other replacement policies.
} block_t;

typedef struct set {
    block_t* blocks; // Array of blocks within a set.
} set_t;

typedef struct cache {
    set_t* sets; // Array of sets within a cache.
    int blocksize; // Size of a single block of data.
    int cachesize; // Total size of the cache.
    int numsets; // Number of sets within the cache.
    int writeback; // Writeback policy flag.
    int associativity; // Number of blocks within a set.
    int hit; // Hit count.
    int miss; // Miss count.
    int read_hit; // Read hit count.
    int read_miss; // Read miss count.
    int write_hit; // Write hit count.
    int write_miss; // Write miss count.
} cache_t;

cache_t l1_instruction_cache;
cache_t l1_data_cache;
cache_t l2_cache;

// Function prototypes
void cache_init(cache_t* cache, int cachesize, int blocksize, int associativity, int writeback);
void cache_access(cache_t* cache, unsigned int address, int is_write);
void cache_finish(cache_t* cache);
void set_init(set_t* set, int associativity, int blocksize);
void block_init(block_t* block, int blocksize);
void cache_deallocate(cache_t* cache);
void update_cache_statistics(cache_t* cache, int hit_flag);
static unsigned long instr_count;


// Global hit/miss counters for demonstration purposes
static int l1i_hit = 0, l1i_miss = 0, l1d_hit = 0, l1d_miss = 0, l2_hit = 0, l2_miss = 0;


// Function to calculate the hit ratio for a cache
double calculate_combined_hit_ratio(cache_t* cache) {
    int total_hits = cache->read_hit + cache->write_hit;
    int total_accesses = total_hits + cache->read_miss + cache->write_miss;
    if (total_accesses == 0) {
        return 0.0; // No accesses to calculate ratio
    }
    return (double)total_hits / (double)total_accesses;
}
double calculate_read_hit_ratio(cache_t* cache) {
    int total_read_accesses = cache->read_hit + cache->read_miss;
    if (total_read_accesses == 0) {
        return 0.0; // No read accesses to calculate ratio
    }
    return (double)cache->read_hit / (double)total_read_accesses;
}
double calculate_write_hit_ratio(cache_t* cache) {
    int total_write_accesses = cache->write_hit + cache->write_miss;
    if (total_write_accesses == 0) {
        return 0.0; // No write accesses to calculate ratio
    }
    return (double)cache->write_hit / (double)total_write_accesses;
}


// Initialize the cache
void cache_init(cache_t* cache, int cachesize, int blocksize, int associativity, int writeback) {
    cache->numsets = cachesize / (associativity * blocksize); // Calculate the number of sets
    cache->blocksize = blocksize;
    cache->cachesize = cachesize;
    cache->associativity = associativity;
    cache->writeback = writeback;
    cache->hit = 0;
    cache->miss = 0;
    cache->read_hit = 0;
    cache->read_miss = 0;
    cache->write_hit = 0;
    cache->write_miss = 0;

    // Allocate memory for the sets within the cache
    cache->sets = (set_t*)malloc(cache->numsets * sizeof(set_t));
    if (cache->sets == NULL) {
        fprintf(stderr, "Error allocating memory for cache sets\n");
        exit(EXIT_FAILURE);
    }

    // Initialize each set within the cache
    for (int i = 0; i < cache->numsets; i++) {
        set_init(&cache->sets[i], associativity, blocksize);
    }
}

// Initialize a set
void set_init(set_t* set, int associativity, int blocksize) {
    set->blocks = (block_t*)malloc(associativity * sizeof(block_t));
    if (set->blocks == NULL) {
        fprintf(stderr, "Error allocating memory for cache blocks\n");
        exit(EXIT_FAILURE);
    }

    // Initialize each block within the set
    for (int j = 0; j < associativity; j++) {
        block_init(&set->blocks[j], blocksize);
    }
}

// Initialize a block
void block_init(block_t* block, int blocksize) {
    // For simplicity, we are not actually storing data in this simulation
    block->data = (data_t*)malloc(blocksize * sizeof(data_t));
    if (block->data == NULL) {
        fprintf(stderr, "Error allocating memory for block data\n");
        exit(EXIT_FAILURE);
    }
    block->tag = 0;
    block->valid = 0;
    block->dirty = 0;
    block->age = -1; // Initialize to -1 to indicate it's not been used yet
    
}
void write_back_if_dirty(cache_t* l2_cache, unsigned int index, block_t* block) {
    if (block->dirty) {
        // Calculate log2 of the number of sets in L2 cache, which is log2(256 * 1024 / (8 * 64)) = log2(512) = 9
        int log2_numsets_l2 = 9; // Since L2 cache has 512 sets (based on the given configuration)
        int log2_blocksize = 6; // Since block size is 64 bytes, log2(64) = 6

        // Calculate the write back address using tag and index
        // The tag stored in the block is shifted left by the sum of log2 of number of sets and block size to get the upper bits
        // The index is shifted left by log2 of block size to position it correctly in the lower bits
        unsigned int write_back_address = (block->tag << (log2_numsets_l2 + log2_blocksize)) | (index << log2_blocksize);
        
        // Simulate the write back to L2 cache by accessing the L2 cache with the calculated address
        cache_access(l2_cache, write_back_address, 1); // Writing to L2 cache

        // After writing back, mark the block as non-dirty
        block->dirty = 0;
    }
}



// Function to handle block eviction based on LRU policy
int evict_lru_block(set_t* set, int associativity) {
    // This function needs to return the index of the block to evict
    // Implement LRU logic to find the least recently used block
    int lru_block_index = 0; // Placeholder for the actual LRU block index
    return lru_block_index;
}

void write_back_to_l2(cache_t* l2_cache, unsigned int index, block_t* block) {
    // The log2(numsets) for L2 cache is given as per its size and configuration, which is 9 bits
    unsigned int tag_shift = 9 + 6; // log2(L2 numsets) + log2(blocksize)
    unsigned int index_shift = 6; // log2(blocksize)

    unsigned int full_address = (block->tag << tag_shift) | (index << index_shift);

    // Now simulate the write to the L2 cache by calling 'cache_access' on L2 without hit/miss pointers
    cache_access(l2_cache, full_address, 1);
}

// Function to find the LRU block index in a set
int find_lru_block_index(set_t* set, int associativity) {
    int lru_index = 0;
    int max_age = set->blocks[0].age; // Start with the age of the first block

    // Loop through blocks to find the least recently used
    for (int i = 1; i < associativity; i++) {
        if (set->blocks[i].age > max_age) { // Higher age means less recently used
            max_age = set->blocks[i].age;
            lru_index = i;
        }
    }
    return lru_index;
}

// Function to update ages of blocks in a set after access
void update_block_ages(set_t* set, int associativity, int accessed_index) {
    // Increment age of all blocks since they've gotten "older" relative to the accessed block
    for (int i = 0; i < associativity; i++) {
        if (set->blocks[i].valid) {
            set->blocks[i].age++;
        }
    }
    // Reset the age of the accessed block to 0 since it's the most recently used
    set->blocks[accessed_index].age = 0;
}


void cache_cleanup(cache_t* cache) {
    for (int i = 0; i < cache->numsets; ++i) {
        free(cache->sets[i].blocks);
    }
    free(cache->sets);
    cache->sets = NULL;
}

void cache_access(cache_t* cache, unsigned int address, int is_write) {
    unsigned int block_offset = address & (cache->blocksize - 1);
    unsigned int index = (address / cache->blocksize) % cache->numsets;
    unsigned int tag = address / (cache->blocksize * cache->numsets);
    int found = 0;
    int found_index = -1;

    // printf("Debug: Access - Address: 0x%08x, Write: %d, Index: %u, Tag: %u, Offset: %u\n", address, is_write, index, tag, block_offset);

    set_t* set = &cache->sets[index];
    for (int i = 0; i < cache->associativity; i++) {
        block_t* block = &set->blocks[i];
        if (block->valid && block->tag == tag) {
            // It's a hit
            if (is_write) {
                cache->write_hit++;
                block->dirty = 1;
            } else {
                cache->read_hit++;
            }
            update_block_ages(set, cache->associativity, i);
            return; // Exit function after handling hit
        }
    }
    // It's a miss
    if (is_write) {
        cache->write_miss++;
    } else {
        cache->read_miss++;
    }
    if (!found) {
        // printf("Debug: Miss - No matching tag in Set: %d\n", index);
        cache->miss++;
        // printf("Miss counter incremented to %d.\n", cache->miss); // Debug statement for miss increment
        int lru_index = find_lru_block_index(set, cache->associativity);
        if (set->blocks[lru_index].dirty && cache->writeback) {
            // printf("Debug: Write Back - Evicting dirty block in Set: %d, Block: %d\n", index, lru_index);
            write_back_to_l2(&l2_cache, index, &set->blocks[lru_index]);
        }
        set->blocks[lru_index].tag = tag;
        set->blocks[lru_index].valid = 1;
        set->blocks[lru_index].dirty = is_write;
        if (is_write) {
            // printf("Debug: Write Allocate - New block in Set: %d, Block: %d marked dirty\n", index, lru_index);
        }
        update_block_ages(set, cache->associativity, lru_index);
    }
}




// Function to clean up cache at the end of simulation
void cache_finish(cache_t* cache) {
    // Proper cleanup of cache sets and blocks
    if (cache->sets) {
        for (int i = 0; i < cache->numsets; i++) {
            free(cache->sets[i].blocks); // Free each blocks array within the sets
        }
        free(cache->sets); // Free the sets array itself
        cache->sets = NULL;
    }
    cache->numsets = 0; // Correct this to numsets, which is the actual member name
    cache->associativity = 0;
}

void memory_init(void) {
    // Initialize the L1 instruction cache with no writeback (write-through)
    cache_init(&l1_instruction_cache, L1_INSTRUCTION_CACHE_SIZE, CACHE_LINE_SIZE, L1_ASSOCIATIVITY, 0);

    // Initialize the L1 data cache with writeback enabled
    cache_init(&l1_data_cache, L1_DATA_CACHE_SIZE, CACHE_LINE_SIZE, L1_DATA_ASSOCIATIVITY, 1);

    // Initialize the L2 cache with writeback enabled
    cache_init(&l2_cache, L2_CACHE_SIZE, CACHE_LINE_SIZE, L2_ASSOCIATIVITY, 1);

    // Reset instruction count
    instr_count = 0;
}

void memory_fetch(unsigned int address, data_t *data) {
    printf("memory: fetch 0x%08x\n", address);
    cache_access(&l1_instruction_cache, address, 0); // Direct cache access without hit/miss pointers
    // If miss in L1 instruction, access L2 cache
    if (l1_instruction_cache.miss > l1i_miss) {
        l1i_miss = l1_instruction_cache.miss; // Update the static miss counter to keep track
        cache_access(&l2_cache, address, 0); // Access L2 cache directly without hit/miss pointers
    }
    if (data)
        *data = (data_t)0; // In a real simulator, here you would fetch the actual data

    instr_count++;
}

void memory_read(unsigned int address, data_t *data) {
    printf("memory: read 0x%08x\n", address);
    // Attempt to read from L1 data cache
    cache_access(&l1_data_cache, address, 0); // is_write is 0 for read

    // If miss in L1 data cache, attempt to read from L2 cache
    if (l1_data_cache.miss > l1d_miss) {
        l1d_miss = l1_data_cache.miss; // Update the static miss counter for L1 data cache
        cache_access(&l2_cache, address, 0); // Access L2 cache
        // Check if there was also a miss in L2 cache to handle accordingly
        if (l2_cache.miss > l2_miss) {
            l2_miss = l2_cache.miss; // Update the static miss counter for L2 cache
        }
    }
    if (data) {
        *data = (data_t)0; // Replace with actual data retrieval logic
    }
    instr_count++;
}


void memory_write(unsigned int address, data_t *data) {
    printf("memory: write 0x%08x\n", address);
    cache_access(&l1_data_cache, address, 1); // Direct cache access without hit/miss pointers
    // If miss in L1 data, access L2 cache
    if (l1_data_cache.miss - l1_data_cache.hit == 1) { // Check miss count directly from the cache structure
        cache_access(&l2_cache, address, 1); // Access L2 cache directly without hit/miss pointers
    }

    instr_count++;
}

void memory_finish(void) {
    // Calculate read and write hit ratios
    double l1i_read_hit_ratio = calculate_read_hit_ratio(&l1_instruction_cache);
    // double l1i_write_hit_ratio = calculate_write_hit_ratio(&l1_instruction_cache);
    double l1d_read_hit_ratio = calculate_read_hit_ratio(&l1_data_cache);
    double l1d_write_hit_ratio = calculate_write_hit_ratio(&l1_data_cache);
    double l2_read_hit_ratio = calculate_read_hit_ratio(&l2_cache);
    double l2_write_hit_ratio = calculate_write_hit_ratio(&l2_cache);
    double l1i_overall_hit_ratio = calculate_combined_hit_ratio(&l1_instruction_cache);
    double l1d_overall_hit_ratio = calculate_combined_hit_ratio(&l1_data_cache);
    double l2_overall_hit_ratio = calculate_combined_hit_ratio(&l2_cache);

    // Print cache statistics for instruction cache
    fprintf(stdout, "L1 Instruction Cache: %d read hits, %d read misses, Read Hit Ratio: %.2f%%\n",
        l1_instruction_cache.read_hit, l1_instruction_cache.read_miss, l1i_read_hit_ratio * 100);

    // Print cache statistics for data cache
    fprintf(stdout, "L1 Data Cache: %d read hits, %d read misses, Read Hit Ratio: %.2f%%\n",
        l1_data_cache.read_hit, l1_data_cache.read_miss, l1d_read_hit_ratio * 100);
    fprintf(stdout, "L1 Data Cache: %d write hits, %d write misses, Write Hit Ratio: %.2f%%\n",
        l1_data_cache.write_hit, l1_data_cache.write_miss, l1d_write_hit_ratio * 100);
    fprintf(stdout, "L1 Data Cache: Overall Hit Ratio: %.2f%%\n", l1d_overall_hit_ratio * 100);

    // Print cache statistics for L2 cache
    fprintf(stdout, "L2 Cache: %d read hits, %d read misses, Read Hit Ratio: %.2f%%\n",
        l2_cache.read_hit, l2_cache.read_miss, l2_read_hit_ratio * 100);
    fprintf(stdout, "L2 Cache: %d write hits, %d write misses, Write Hit Ratio: %.2f%%\n",
        l2_cache.write_hit, l2_cache.write_miss, l2_write_hit_ratio * 100);
    fprintf(stdout, "L2 Cache: Overall Hit Ratio: %.2f%%\n", l2_overall_hit_ratio * 100);

    // Print total executed instructions
    fprintf(stdout, "Executed %lu instructions.\n", instr_count);

    // Clean up cache resources
    cache_finish(&l1_instruction_cache);
    cache_finish(&l1_data_cache);
    cache_finish(&l2_cache);
}
