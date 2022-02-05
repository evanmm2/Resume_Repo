#ifndef TERMINAL_H
#define TERMINAL_H

#include "lib.h"
#include "keyboard.h"
#include "file_system.h"
#include "system_calls.h"


#ifndef ASM

#define NUM_TERMINALS 3
#define SUCCESS 0
#define FAILURE -1

void terminal_init();

int terminal_open(const uint8_t* filename);

int terminal_close(int32_t fd);

int terminal_read(int32_t fd, void* buf, int nbytes);

int terminal_write(int32_t fd, const void* buf, int32_t nbytes);

int cmd_checker( char* buf,  char * cmd);

int setup_multiple_terminals();     //OSS handler for setting up multiple terminals

struct terminal_struct {
    //struct kbd_buffer_struct* kbd_struct;
    int screen_x;
    int screen_y;
    int terminal_id;                    //OSS: need this for s
    int active_process_number;  //OSS: process number for context switching
};

struct terminal_struct terminal_array[NUM_TERMINALS];

int cur_terminal;

volatile int enter_key;


#endif /* ASM END */

#endif  /* TERMINAL_H */
