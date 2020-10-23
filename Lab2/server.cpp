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
#define FILLED 0
#define Ready 1
#define NotReady -1

struct memory{
char buff[100000];
int status, pid1, pid2;
};
struct memory* shmptr;

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

/*void* create_shared_memory(size_t size) {
    int protection = PROT_READ | PROT_WRITE;
    int visibility = MAP_SHARED | MAP_ANONYMOUS;
    return mmap(NULL, size, protection, visibility, -1, 0);
}
*/
int main() {
    //void *shmem = create_shared_memory(SHSIZE);

    daemonize();
    int server = Socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in adr = {0};
    adr.sin_family = AF_INET;
    adr.sin_port = htons(34535);
    Bind(server, (struct sockaddr *) &adr, sizeof adr);
    Listen(server, 1);
    socklen_t adrlen = sizeof adr;
    int fd = Accept(server, (struct sockaddr *) &adr, &adrlen);

    const char* name = "/shmem";
    int shmfd = shm_open(name, O_CREAT | O_RDWR, 0666);
    ftruncate(shmfd, 400000);
    shmptr = (struct memory*)mmap(0, 400000, PROT_WRITE | PROT_READ, MAP_SHARED, shmfd, 0);

    //int key = 12345;
    //int shmid = shmget(key, sizeof(struct memory), IPC_CREAT | 0666);
    //shmptr = (struct memory*)shmat(shmid, NULL, 0);
    //int f = open("/usr/home/student/Downloads/log1.txt", O_WRONLY | O_APPEND);


    char test[10000];
    memset(test, 0, sizeof(test));
    char buf[256];
    char** amd;
    char* bin = (char*)"/bin/";
    char* first;
    pid_t kkk;
    pid_t loggerPid = fork();
    if (loggerPid == 0) {
            setsid();
            execl("/usr/home/student/Downloads/log", "/usr/home/student/Downloads/log", (char*)NULL);
    } else if (loggerPid < 0) {
        exit(EXIT_FAILURE);
    } else {
        sleep(2);
        //std::string s = std::to_string(shmptr->pid2);
        //write(f,s.c_str(),s.length());
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
                //first = concat(bin, amd[0]);
                //memcpy((char*)ptr, buf, sizeof(buf));
                sprintf(shmptr->buff, "%s", buf);
                kill(shmptr->pid2, SIGUSR1);

                if(strcmp(buf,"sysinfo\n") == 0){
                    execl("/usr/home/student/Downloads/sysinfo", "/usr/home/student/Downloads/sysinfo", (char*)NULL);
                } else if (strcmp(buf,"ps\n") == 0){
                    execl("/usr/home/student/Downloads/ps", "/usr/home/student/Downloads/ps", (char*)NULL);
                } else if (strcmp(buf,"procChange\n") == 0){
                    if(fork() == 0){
                        setsid();
                        execl("/usr/home/student/Downloads/change", "/usr/home/student/Downloads/change", (char*)NULL);
                    }
                } else {
                    execvp(amd[0], (char**)amd);
                }
                //write(fileno(stdout),(char*)shmptr->pid2, sizeof(shmptr->pid2));
                write(fileno(stdout),strerror(errno),sizeof(strerror(errno)));
                exit(-1);

            } else {
                wait(NULL);
                read(link[0], test, sizeof(test));
                sprintf(shmptr->buff, "%s", test);
                //memcpy((char*)ptr, test, sizeof(test));
                kill(shmptr->pid2, SIGUSR1);
                write(fd, test, sizeof(test));
            }
        }
        return 0;

    }
}
