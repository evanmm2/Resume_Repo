#ifndef SYSTEM_CALLS_H
#define SYSTEM_CALLS_H

#define EIGHT_MB  0x800000
#define EIGHT_KB  0x2000
#define TWO_KB   0x800
#define NUM_PROCESS_FILES 8
#define BACK_TO_FUTURE 1985
#define FOURBYTES 4
#define PCB_OFFSET 600
#define EIP_ADDR  0x8048018
#define LOAD_USER_ADDR 0x008048000
#define MAX_PROCESSES  6
#define FOUR_KB   4092

#ifndef ASM

#include "file_system.h"
#include "types.h"
#include "lib.h"
#include "system_calls_asm.h"
#include "x86_desc.h"
#include "terminal.h"
#include "RTC.h"
#include "paging.h"
#include "directory.h"
#include "interrupt_calls.h"

//the current process running
int cur_process;
//current running shell
int cur_shell;

/* set up the drivers */
void init_all_drivers ();

/* initialize data processing */
int init_process_data ();

/* initialize standard driver */
void init_std_driver();

/* rtc driver */
void init_RTC_driver();

/* directory driver  */
void init_dir_driver();

/* text driver */
void init_txt_driver();

/* stdio */
void init_STD();

/* halt a process  */
int halt(unsigned char status);


/* execute a process */
int execute(const unsigned char* command);

/* read a number of bytes */
int read(int fd, void* buf, int nbytes);

/* write a number of bytes */
int write(int fd, const void* buf, int nbytes);

/* open a file */
int open(const unsigned char* filename);

/* close a file */
int close(int fd);
//to do!!!!!
int32_t set_files_for_process();

void zero_file_data(int i);

int32_t getargs(unsigned char* buf, int32_t nbytes);

int vidmap(uint8_t** screen_start);

int set_handler();

int sigreturn();

void task_swap(int shell_number);

void shell_setup(int shell_number);

typedef struct file_op_ptr_t {
  int32_t (* spec_read)(int32_t fd, void * buf, int32_t nbytes); //interpretation function
  int32_t (* spec_write)(int32_t fd, const void* buf, int32_t nbytes);
  int32_t (* spec_open)(const uint8_t* filename);
  int32_t (* spec_close)(int32_t fd);
} file_op_ptr_t;


//the documented struct in appendix c
//contains data for system calls to interface with
typedef struct file_data {
  file_op_ptr_t file_op_ptr;
  int32_t inode;
  int32_t file_position;
  int32_t flags;
  int file_type;
} file_data_t;

/* pcb struct */
typedef struct pcb {
    //process ID number
    int PID;
    //this processes parent process ID
    int parent_PID;
    //RTC frequency
    int RTC_freq;
    //the arguments passed in with execute, if there are any
	  unsigned char argument[127];
    //the esp to change to when preforming a task swap
    int esp;
    //the ebp to change to when preforming a task swap
    int ebp;
    //the esp0 that is saved from the tss when task swappin'
    int esp0;
    //the active process files for this process
    file_data_t process_files[NUM_PROCESS_FILES];

    //for the PIT, save registers here rather than on the stack
    int eax;
    int ebx;
    int ecx;
    int edx;
    int esi;
    int edi;
} pcb_t;

//the active array of files for the current process
file_data_t cur_process_files[NUM_PROCESS_FILES];

//0 if the page is not in use, 1 if the page is in use
int user_page_array[6];

//this says which of the three shells are init
unsigned char shell_present[3];
//which process number per thread
unsigned char thread_position[3];
//which process number each shell is
unsigned char shell_position[3];

#endif
#endif
