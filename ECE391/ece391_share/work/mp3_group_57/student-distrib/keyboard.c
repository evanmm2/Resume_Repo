#include "keyboard.h"



#define F1  0x3B
#define F2  0x3C
#define F3  0x3D

/*
This table contains keycode values
Any 0x00 means the character is either not presernt or a commands
*/
char kbd_characters[NUM_CHAR] = {
  0x00, 0x1B, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 0x08, 0x09,
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 0x5B, 0x5D, 0x0A, 0x00, 'a', 's',
  'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', 0x27, 0x60, 0x00, 0x5C, 'z', 'x', 'c', 'v',
  'b', 'n', 'm', ',', '.', '/', 0x00, 0x00, 0x00, ' '
};

/*
This table contains keycode values for uppercase, or shifted keys
Any 0x00 means the character is either not presernt or a commands
*/
char kbd_characters_shift[NUM_CHAR] = {
  0x00, 0x1B, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', 0x08, 0x09,
  'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 0x7B, 0x7D, 0x0A, 0x00, 'A', 'S',
  'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', 0x22, 0x7E, 0x00, 0x7C, 'Z', 'X', 'C', 'V',
  'B', 'N', 'M', '<', '>', '?', 0x00, 0x00, 0x00, ' '
};

/*
This table contains keycode values when capslock is on
Any 0x00 means the character is either not presernt or a commands
*/
char kbd_characters_capslock[NUM_CHAR] = {
  0x00, 0x1B, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 0x08, 0x09,
  'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 0x5B, 0x5D, 0x0A, 0x00, 'A', 'S',
  'D', 'F', 'G', 'H', 'J', 'K', 'L', ';', 0x27, 0x60, 0x00, 0x5C, 'Z', 'X', 'C', 'V',
  'B', 'N', 'M', ',', '.', '/', 0x00, 0x00, 0x00, ' '
};

/*
This table contains keycode values for lowercase letters but shifted special chars
Any 0x00 means the character is either not presernt or a commands
*/
char kbd_characters_shift_capslock[NUM_CHAR] = {
  0x00, 0x1B, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', 0x08, 0x09,
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 0x7B, 0x7D, 0x0A, 0x00, 'a', 's',
  'd', 'f', 'g', 'h', 'j', 'k', 'l', ':', 0x22, 0x7E, 0x00, 0x7C, 'z', 'x', 'c', 'v',
  'b', 'n', 'm', '<', '>', '?', 0x00, 0x00, 0x00, ' '
};

/*
 keyboard_init
 DESCRIPTION:   Enables the keyboard device, i.e. enables it and creates its gate and PIC
 INPUTS: none
 OUTPUTS: none
 SIDE EFFECTS: Initilizes the keyboard, updates the IDT, and sets up the PIC
 */
void keyboard_init() {

    //enable the keyboard now
    outb(KBD_ENABLE_PORT1, KBD_DATA_PORT);

    //set the interrupt gate in the table for the keyboard
    set_trap_gate(SIG_KBD, (uint32_t)handle_SIG_KBD);

    //enable interrupts on master 1 because keyboard is high priority
    enable_irq(MASTER_IRQ1);

      int i;
    //initialize kbd buffer struct
    kbd_keyread[cur_terminal].shift = 0;
    kbd_keyread[cur_terminal].control = 0;
    kbd_keyread[cur_terminal].alt = 0;
    kbd_keyread[cur_terminal].capslock = 0;
    //set all chars in buffer to space
    for(i = 0; i < BUFFER_SIZE; i++)
        kbd_keyread[cur_terminal].kbd_buffer[i] = 0x00;
    //init index and buffer_occupancy
    kbd_keyread[cur_terminal].index = 0;
    kbd_keyread[cur_terminal].buffer_occupancy = 0;

    enter_key = 0;

}

/*
 handle_SIG_KBD
 DESCRIPTIONS: What the IDT calls when it recieves a keyboard interrupt. This function gets the encoded
               character and calls decode to print it to the screen
 INPUTS: none
 OUTPUTS: none
 SIDE EFFECTS: calls decode to print the char to the screen, and sends EOI to the PIC
 */
void handle_keyboard_sig() {
    //get the key pressed out of the data port
    uint8_t keycode = inb(KBD_DATA_PORT);
    //call decode function to print the character to the screen
    cli();
    decode(keycode);
    //send the eoi to tell the PIC we're done with the interrupt
    send_eoi(MASTER_IRQ1);

    return;
}

/*
 decode
 DESCRIPTIONS: Use the kbd_characters array to decode the pressed key and echo it to the screen
 INPUTS: keycode - The 8 bit code for the key pressed
 OUTPUTS: none
 SIDE EFFECTS: Prints decoded keycode to the screen
 */
void decode(uint8_t keycode) {
    //check if backspace was pressed
    //its 14 on my mac for some reaseon
    if(keycode == 0x66 || keycode == 0x71 || keycode == 14) {
        //nothing to backspace
        if(kbd_keyread[cur_terminal].index < 0) {
          return;
        }
		//can't backspace past the end
		  if(kbd_keyread[cur_terminal].index == 0) {
			     return;
      }
      //this handles the backspace, get it!?

      if(cur_shell != cur_terminal) {
          save_screen_location(cur_shell);
          reset_vid();
          purge_tlb();
          update_screen(cur_terminal);
        }
      handle_backspace();
      if(cur_shell != cur_terminal) {
          save_screen_location(cur_terminal);
          vid_swap();
          purge_tlb();
          update_screen(cur_shell);
        }
      return;
    }
    //check if left arrow was pressed
    if(keycode == 0x4B) {
      //if we are at end of the buffer do nothing
        if(kbd_keyread[cur_terminal].index <= 0)
            return;
        //want the change to appear on screen, save change mapping to physical video mem if necessary
        if(cur_shell != cur_terminal) {
            save_screen_location(cur_shell);
            reset_vid();
            purge_tlb();
            update_screen(cur_terminal);
          }
          handle_left_key();
          move_cursor();
          //now change it back
          if(cur_shell != cur_terminal) {
            save_screen_location(cur_terminal);
            vid_swap();
            purge_tlb();
            update_screen(cur_shell);
          }
        kbd_keyread[cur_terminal].index--;
        return;
    }
    //check if right arrow was pressed
    if(keycode == 0x4D) {
        //if we are at end of index return
        if(kbd_keyread[cur_terminal].index >= BUFFER_SIZE - 1 || kbd_keyread[cur_terminal].kbd_buffer[kbd_keyread[cur_terminal].index] == 0x00)
            return;

        //want the change to appear on screen, save change mapping to physical video mem if necessary
        if(cur_shell != cur_terminal) {
            save_screen_location(cur_shell);
            reset_vid();
            purge_tlb();
            update_screen(cur_terminal);
          }
        handle_right_key();
        move_cursor();
        if(cur_shell != cur_terminal) {
            save_screen_location(cur_terminal);
            vid_swap();
            purge_tlb();
            update_screen(cur_shell);
          }
        kbd_keyread[cur_terminal].index++;
        return;
    }

    //check if enter was pressed
    if(keycode == 0x1C) {
      //put newline at end of string, not where the cursor is
      kbd_keyread[cur_terminal].kbd_buffer[kbd_keyread[cur_terminal].buffer_occupancy] = '\n';
      kbd_keyread[cur_terminal].buffer_occupancy++;
      kbd_keyread[cur_terminal].index = kbd_keyread[cur_terminal].buffer_occupancy;

      //want the change to appear on screen, save change mapping to physical video mem if necessary
      if(cur_shell != cur_terminal) {
          save_screen_location(cur_shell);
          reset_vid();
          purge_tlb();
          update_screen(cur_terminal);
        }
      putc('\n');
      move_cursor();
      //change the mapping back
      if(cur_shell != cur_terminal) {
          save_screen_location(cur_terminal);
          vid_swap();
          purge_tlb();
          update_screen(cur_shell);
        }
      handle_enter();
      return;
    }
    //check if the shift key has been pressed(left or right)
    if(keycode == 0x2A || keycode == 0x36) {
      kbd_keyread[cur_terminal].shift = 1;
      return;
    }
    //check if the shift key has been released(left or right)
    if(keycode == 0xAA || keycode == 0xB6) {
      kbd_keyread[cur_terminal].shift = 0;
      return;
    }
    //check if the control key has been pressed(left)
    if(keycode == 0x1D) {
      kbd_keyread[cur_terminal].control = 1;
      return;
    }
    //check if the control key has been released(left)
    if(keycode == 0x9D) {
      kbd_keyread[cur_terminal].control = 0;
      return;
    }
    //check if capslock has been pressed
    if(keycode == 0x3A) {
      //if capslock was already pressed, turn it off
      if(kbd_keyread[cur_terminal].capslock)
        kbd_keyread[cur_terminal].capslock = 0;
      //capslock wasnt pressed so enable it
      else
        kbd_keyread[cur_terminal].capslock = 1;
      return;
    }

    //check if the alt key has been pressed
    if(keycode == 0x38) {
      kbd_keyread[cur_terminal].alt = 1;
      return;
    }
    //check if the alt key has been released
    if(keycode == 0xB8) {
      kbd_keyread[cur_terminal].alt = 0;
      return;
    }
    //check if any of the 3 function keys have been pressed with alt
    /*
    For all the terminal switches:
        -disable interrutps and then send eoi so we do not recieve interrupts while task swapping
        -when we iret out of task swap, eflags is updated with saved flags value which has interrupts enabled
        -then call task swap based on the function key that was pressed
    */
    if(keycode == F1 && kbd_keyread[cur_terminal].alt) {
        if(cur_terminal == 0)
            return;
        cli();
        send_eoi(MASTER_IRQ1);
        task_swap(0);
        return;
    }

    if(keycode == F2 && kbd_keyread[cur_terminal].alt) {
      if(cur_terminal == 1)
          return;
      if(shell_present[1] == 0) {
        cli();
        send_eoi(MASTER_IRQ1);
        shell_setup(1);
      }
      else {
        cli();
        send_eoi(MASTER_IRQ1);
        task_swap(1);
      }
        return;
    }

    if(keycode == F3 && kbd_keyread[cur_terminal].alt) {
      if(cur_terminal == 2)
          return;
      if(shell_present[2] == 0) {
        cli();
        send_eoi(MASTER_IRQ1);
        shell_setup(2);
      }
      else {
        cli();
        send_eoi(MASTER_IRQ1);
        task_swap(2);
      }
        return;
    }

    if(keycode >= NUM_CHAR) {
      return;
    }

    //hold the char from keycode
    char my_char;
    //If shift and capslock are both on we want lowercase chars
    if(kbd_keyread[cur_terminal].shift && kbd_keyread[cur_terminal].capslock) {
      my_char = kbd_characters_shift_capslock[keycode];
    }
    //Use the shift array, which is uppervase chars and upercase special chars
    else if(kbd_keyread[cur_terminal].shift) {
      my_char = kbd_characters_shift[keycode];
    }
    //Use capslock array, which is only uppercase letters and normal special chars
    else if(kbd_keyread[cur_terminal].capslock) {
      my_char = kbd_characters_capslock[keycode];
    }
    //neither capslock nor shift, so normal chars
    else {
      my_char = kbd_characters[keycode];
    }

    //buffer is full
    if(kbd_keyread[cur_terminal].index >= BUFFER_SIZE)
        return;
    //insert the char into buffer
    kbd_keyread[cur_terminal].kbd_buffer[kbd_keyread[cur_terminal].index] = my_char;
    if(my_char == 'l' && kbd_keyread[cur_terminal].control) {
      //want the change to appear on screen, save change mapping to physical video mem if necessary
      if(cur_shell != cur_terminal) {
          save_screen_location(cur_shell);
          reset_vid();
          purge_tlb();
          update_screen(cur_terminal);
        }
        reset_screen();
        //change the mapping back
        if(cur_shell != cur_terminal) {
            save_screen_location(cur_terminal);
            vid_swap();
            purge_tlb();
            update_screen(cur_shell);
          }
        kbd_keyread[cur_terminal].index = 0;
        //need to clear buffer as well
        return;
    }
    //only if we add chars to the end do we update the occupancy
    if(kbd_keyread[cur_terminal].index == kbd_keyread[cur_terminal].buffer_occupancy)
        kbd_keyread[cur_terminal].buffer_occupancy++;
    //no matter what increase index since we shifted right by adding char
    kbd_keyread[cur_terminal].index++;

    //want the change to appear on screen, save change mapping to physical video mem if necessary
    if(cur_shell != cur_terminal) {
        save_screen_location(cur_shell);
        reset_vid();
        purge_tlb();
        update_screen(cur_terminal);
      }
    putc(my_char);
    move_cursor();
    //change the mapping back
    if(cur_shell != cur_terminal) {
        save_screen_location(cur_terminal);
        vid_swap();
        purge_tlb();
        update_screen(cur_shell);
      }
}

/*
DESCRIPTION: handles the enter key. Calls terminal_read to read the command in the buffer, then clears the buffer
INPUTS: none
OUTPUTS: none
SIDE EFFECTS: reads the command from the keyboard, and clears the buffer
*/
void handle_enter() {
    //set volatile int to break while loop in read
    enter_key = 1;
}


/*File created by the one and only Brian Butcher*/
