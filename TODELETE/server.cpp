#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <unistd.h>
#include "erproc.h"
#include <sys/wait.h>
#include <string.h>
#include <sys/stat.h>
#include <cerrno>
#include <iostream>
#include <fcntl.h>
#include <sys/shm.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <signal.h>
#include <fstream>
#include <sys/types.h>
#include <sys/ipc.h>
#define SHSIZE 10000

void daemonize() {
    pid_t pid;

    switch(pid = fork()) {
        case 0:
            setsid();
            chdir("/");
            break;
        case -1:
            perror("Failed to fork daemon\n");
            exit(1);
        default:
            exit(0);
    }
}

void* create_shared_memory(size_t size) {
    int protection = PROT_READ | PROT_WRITE;
    int visibility = MAP_SHARED | MAP_ANONYMOUS;
    return mmap(NULL, size, protection, visibility, -1, 0);
}

int main() {
    void *shmem = create_shared_memory(SHSIZE);
    daemonize();
    int server = Socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in adr = {0};
    adr.sin_family = AF_INET;
    adr.sin_port = htons(34581);
    Bind(server, (struct sockaddr *) &adr, sizeof adr);
    Listen(server, 1);

    socklen_t adrlen = sizeof adr;
    int fd = Accept(server, (struct sockaddr *) &adr, &adrlen);

    char test[10000];
    char testError[10000];
    memset(test, 0, sizeof(test));
    char buf[256];
    char** amd;
    char* bin = (char*)"/bin/";
    char* first;
    int f = open("/home/stepan/CLionProjects/Laba10/out.txt", O_WRONLY);
    pid_t loggerPid = fork();
    if (loggerPid == 0) {
        setsid();
        int signo;
        sigset_t newmask;
        sigemptyset(&newmask);
        sigaddset(&newmask, SIGUSR1);
        pthread_sigmask(SIG_BLOCK, &newmask, NULL);
        while(true) {
            sigwait(&newmask, &signo);
            if (signo == SIGUSR1) {
                write(f, shmem, strlen((char*)shmem));
                memcpy(shmem, "\0", 1);
            }
        }
    } else if (loggerPid < 0) {
        exit(EXIT_FAILURE);
    } else {
        while(1) {
            int link[2];
            pipe(link);
            memset(test, 0, sizeof(test));
            memset(buf, '\0', sizeof(buf));
            ssize_t nread;
            nread = read(fd, buf, 256);
            if (nread == -1) {
                perror("read failed");
                exit(EXIT_FAILURE);
            }
            if (nread == 0) {
                Listen(server, 1);
                fd = Accept(server, (struct sockaddr *) &adr, &adrlen);
                continue;
            }
            pid_t pid = fork();
            if (pid == 0) {
                char* asd = trim(buf);
                dup2(link[1], fileno(stdout));
                dup2(link[1], fileno(stderr));
                amd = split(asd);
                first = concat(bin, amd[0]);
                memcpy(shmem, buf, sizeof(buf));
                kill(loggerPid, SIGUSR1);
                execv(first, (char**)amd);
                write(fileno(stdout),strerror(errno),sizeof(strerror(errno)));
                exit(-1);

            } else {
                wait(NULL);
                read(link[0], test, sizeof(test));
                memcpy(shmem, test, sizeof(test));
                kill(loggerPid, SIGUSR1);
                write(fd, test, sizeof(test));
            }
        }
        return 0;

    }
}