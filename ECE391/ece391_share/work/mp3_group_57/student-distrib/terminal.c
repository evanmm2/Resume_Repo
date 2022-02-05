#include "terminal.h"

/*
DESCRIPTION: sets all terminals in the array to not present
INPUTS: none
OUTPUS: none
SIDE EFFECTS: inits the terminal array
*/
void terminal_init() {
    int i;
    //set all screen_x and screen_y to -1 so I know they are unused
    for(i = 0; i < NUM_TERMINALS; i++) {
        terminal_array[i].screen_x = -1;
        terminal_array[i].screen_y = -1;
    }
    cur_terminal = -1;
}

/*
DESCRIPTION: tries to open a new terminal, and sets that terminal as current terminal
INPUTS: none
OUTPUS: 0 for success and -1 for failure
SIDE EFFECTS: changes the current terminal if there is one avaliable
*/
int terminal_open(const uint8_t* filename) {
    int i;
    //look for an unused terminal space, return fail if they are all used
    //terminal_array[i].kbd_struct = kbd_keyread[cur_terminal];
    for(i = 0; i < NUM_TERMINALS; i++) {
        if(terminal_array[i].screen_x == -1 && terminal_array[i].screen_y == -1) {
            //init the struct
            terminal_array[i].screen_x = 0;
            terminal_array[i].screen_y = 0;
            terminal_array[i].terminal_id = i;
            terminal_array[i].active_process_number = 0;    // OSS: means no process is running
            cur_terminal = 0;
            return SUCCESS;
        }
    }

    return FAILURE;
}

/*
DESCRIPTION: closes the terminal
INPUTS: none
OUTPUS: none
SIDE EFFECTS: none
*/
int32_t terminal_close(int32_t fd){
      return 0;
}

/*
DESCRIPTION: outputs the given string to the terminal
INPUTS: 	string - the string to be printed to the screen
OUTPUS: returns success always
SIDE EFFECTS: prints the string to the screen
*/
int terminal_write(int32_t fd, const void* buf, int32_t nbytes) {
    int i;
    //print the buf out to the screen
    for(i = 0; i < nbytes; i++) {
        putc(((unsigned char*)buf)[i]);
    }

	return SUCCESS;
}

/*
DESCRIPTION: reads the input from the keyboard
INPUTS: none
OUTPUS: none
SIDE EFFECTS: performs a command or returns the buffer to the screen
*/
int terminal_read(int32_t fd, void* buf, int nbytes) {
    int i;
    int flags;
    //wait for enter key and when we are on the right process to return buffer back to user
    while(!enter_key || thread_position[cur_terminal] != cur_process);
    cli_and_save(flags);
    int size = kbd_keyread[cur_terminal].buffer_occupancy;
    //copy buffer to the user
    for(i = 0; i < kbd_keyread[cur_terminal].buffer_occupancy; i++) {
        ((unsigned char *)buf)[i] = kbd_keyread[cur_terminal].kbd_buffer[i];
    }
    //clear enter key
    enter_key = 0;
    //remove stuff in keyboard buffer
    for(i = 0; i < BUFFER_SIZE; i++) {
        kbd_keyread[cur_terminal].kbd_buffer[i] = 0x00;
    }
    //reset the keyboard struct
    kbd_keyread[cur_terminal].index = 0;
    kbd_keyread[cur_terminal].buffer_occupancy = 0;
    restore_flags(flags);
    //return how many bytes were written
    return size;
}

/*
DESCRIPTION: Compares the buffer with an expected command
INPUTS: 	buf - The keyboard buffer
			cmd - The command string expected
OUTPUS: 0 if they are not the same
		1 if they are the same
SIDE EFFECTS: none
*/
int cmd_checker( char* buf,  char * cmd)
{
    int cmd_length = strlen((unsigned char*)cmd);
    int buf_length = strlen((unsigned char*)buf);
    if(cmd_length != buf_length)
    {
        return 0;
    }
    int i;
    for(i = 0; i < cmd_length; i++)
    {
        if(cmd[i] != buf[i])
        {
            return 0;
        }
    }
    return 1;
}
