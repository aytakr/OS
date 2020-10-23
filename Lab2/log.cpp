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
#include <cstring>

#define SHSIZE 10000
#define FILLED 0
#define Ready 1
#define NotReady -1

struct memory{
char buff[100000];
int status, pid1, pid2;
};
struct memory* shmptr;
int f = open("/usr/home/student/Downloads/log.txt", O_WRONLY | O_APPEND);
void handler(int sig){

write(f,shmptr->buff,strlen(shmptr->buff));
}

int main() {


    int pid = getpid();
    //shmptr->pid2 = pid;

    const char* name = "/shmem";
    int shmfd = shm_open(name, O_CREAT | O_RDWR, 0666);
    ftruncate(shmfd, 400000);
    shmptr = (struct memory*)mmap(0, 400000, PROT_WRITE | PROT_READ, MAP_SHARED, shmfd, 0);

    shmptr->pid2 = pid;
    //int a = 5000;
    //std::string s = std::to_string(shmptr->pid2);
    //write(f,s.c_str(),s.length());
    //write(f,(char*)'\n',1);

    int signo;
    signal(SIGUSR1, handler);
    while(true) {}



    /*char* str;
    const char* name = "/shmem";
    int shmfd = shm_open(name, O_RDONLY, 0666);
    ftruncate(shmfd, 4096);
    char* ptr = (char*)mmap(0, 4096, PROT_READ, MAP_SHARED, shmfd, 0);
    char line[256];
    std::string s(strcpy(line,ptr));
    int f = open("/usr/home/student/Downloads/log.txt", O_WRONLY | O_APPEND);
    write(f, s.c_str(), s.size());
    //shm_unlink(name);*/



}
