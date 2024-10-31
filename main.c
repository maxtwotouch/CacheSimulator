#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#define SIZE 10000  // Define a constant SIZE to be used as the size of the array

extern void asm_function(int *arr, int n);

// Define a bubble_sort function in C
void bubble_sort(int *arr, int n) {
    int i, j, temp;
    for (i = 0; i < n-1; i++) {  
        for (j = 0; j < n-i-1; j++) { 
            if (arr[j] > arr[j+1]) {  // If current element is greater than next element, then swap them
                temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

// The main function
int main(int argc, char **argv) {
    int arr[SIZE], arr2[SIZE];  // Define two arrays of size SIZE
    srand(time(0));  // Initialize random number generator with current time as seed

    // Fill both arrays with the same set of random numbers
    for(int i = 0; i < SIZE; i++) {
        arr[i] = rand() % 1000; // Generate a random number between 0 and 999 and assign it to arr[i]
        arr2[i] = arr[i]; // Duplicate the array so that we can sort it with both methods
    }

    // Record the start time, execute the C version of bubble sort, and then record the end time
    clock_t start = clock();
    bubble_sort(arr, SIZE);
    clock_t end = clock();

    // Calculate and print the time taken for C version of bubble sort
    double time_taken = ((double)end - start) / CLOCKS_PER_SEC;
    printf("C Bubble sort took %f seconds to execute \n", time_taken);

    // Record the start time, execute the assembly version of bubble sort, and then record the end time
    start = clock();
    asm_function(arr2, SIZE);
    end = clock();

    // Calculate and print the time taken for assembly version of bubble sort
    time_taken = ((double)end - start) / CLOCKS_PER_SEC;
    printf("Assembly Bubble sort took %f seconds to execute \n", time_taken);

    return 0;  // Return 0 to indicate successful execution
}
