# Authors: Øyvind Nohr

CC = gcc
CFLAGS = -Wall -Werror -Wno-unused -g -O2 -I.
OBJDIR = obj
PROGRAM = cachesim

OBJS = cpu.o memory.o
HEADERS = byutr.h memory.h
DOCKER_COMPOSE=.docker/docker-compose.yml
DOCKERFILE=.docker/Dockerfile

all: $(PROGRAM) $(HEADERS) Makefile

docker: $(DOCKERFILE) $(DOCKER_COMPOSE)
	docker compose -f $(DOCKER_COMPOSE) build
	docker compose -f $(DOCKER_COMPOSE) up -d
	docker exec -it assembly_x86_64 bash ; docker compose -f $(DOCKER_COMPOSE) down	
.PHONY: clean 

dirs:
	@mkdir -p $(OBJDIR)

$(PROGRAM): $(patsubst %, $(OBJDIR)/%, $(OBJS))
	$(CC) $(CFLAGS) $^ -o $@

$(OBJDIR)/%.o: %.c dirs
	$(CC) $(CFLAGS) -c $< -o $@
	

clean:
	rm -rf *.o *~ $(PROGRAM) $(OBJDIR)
