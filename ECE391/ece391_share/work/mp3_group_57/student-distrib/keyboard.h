#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "types.h"
#include "x86_desc.h"
#include "idt.h"
#include "i8259.h"
#include "lib.h"
#include "RTC.h"
#include "terminal.h"
#include "Paging_asm.h"
#include "interrupt_calls.h"

#ifndef ASM

//This port is used for reading data and writing to keyboard
#define KBD_DATA_PORT 0x60
//read the status of the keyboard port
#define KBD_STATUS_PORT  0x64
//sends commands to the keyboard controller
#define KBD_COMMAND_PORT  0x64

//KEYBOARD COMMANDS
#define KBD_DIS_1   0xAD
#define KBD_DIS_2   0xA7
#define KBD_ENABLE  0xAE
#define KBD_RESET 0xFF
#define KBD_GET_CONFIG_BYTE 0x20
#define KBD_SET_CONFIG_BYTE 0x60
#define KBD_TEST  0xAA
#define KBD_TEST_RESPONSE 0x55
#define KBD_TEST_PORT1 0xAB
#define KBD_TEST_PORT1_PASS 0x00;
#define KBD_ENABLE_PORT1 0xAE
#define KBD_RESET_SUCCESS 0xFA
#define BACKSPACE 0x0E

#define NUM_CHAR 70
#define BUFFER_SIZE 127

//this holds if the command moved to new line


/* Initializes the keyboard */
void keyboard_init();
/* Handle the Keyboard */
void handle_keyboard_sig();
/* decode the keycode */
void decode(uint8_t keycode);
/*handle when enter is pressed, i.e. read command and
reset the buffer*/
void handle_enter();

//struct that holds all kbd data
struct kbd_buffer_struct {
  //holds the characters entered, the size is given
  char kbd_buffer[BUFFER_SIZE];
  //the next valid
  int index;
  //is 1 if shift is being pressed
  int shift;
  //1 if control is being pressed
  int control;
  //1 if alt is being pressed
  int alt;
  //1 if capslock is being pressed
  int capslock;
  //total chars in the buffer
  int buffer_occupancy;
};

struct kbd_buffer_struct kbd_keyread[3];

#endif /* ASM END */

#endif  /* IDT_H */
