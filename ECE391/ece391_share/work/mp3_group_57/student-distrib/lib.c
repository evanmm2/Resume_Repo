/* lib.c - Some basic library functions (printf, strlen, etc.)
 * vim:ts=4 noexpandtab */

#include "lib.h"

#define NUM_COLS    80
#define NUM_ROWS    25
#define ATTRIB      0x7
#define USER_BUF_SIZE 126

static int screen_x;
static int screen_y;
static char* video_mem = (char *)VIDEO;


/* void clear(void);
 * Inputs: void
 * Return Value: none
 * Function: Clears video memory */
void clear(void) {
    int32_t i;
    for (i = 0; i < NUM_ROWS * NUM_COLS; i++) {
        *(uint8_t *)(video_mem + (i << 1)) = ' ';
        *(uint8_t *)(video_mem + (i << 1) + 1) = ATTRIB;
    }
}

/*
void reset_screen()
Description: clears the screen and resets x and y
Inputs: none
Outputs: none
Side_effects: clears the screen and sets screen_x and screen_y to 0
*/
void reset_screen() {
    clear();
    screen_x = 0;
    screen_y = 0;
    if(cur_shell == cur_terminal)
        move_cursor();
}

/*
void save_screen_location(int terminal_number)
Description: saves screen_x and screen_y in cur terminal array
Inputs: terminal_number - which terminal to save x and y to
Outputs: none
Side_effects: changes cur terminal array
*/
void save_screen_location(int terminal_number) {
    terminal_array[terminal_number].screen_x = screen_x;
    terminal_array[terminal_number].screen_y = screen_y;

}

/*
void update_screen()
Description: sets screen_x and screen_y to value saved in cur terminal
Inputs: terminal_number - which terminal to get x and y from
Outputs: none
Side_effects: changes screen_x and screen_y 
*/
void update_screen(int terminal_number) {
    screen_x = terminal_array[terminal_number].screen_x;
    screen_y = terminal_array[terminal_number].screen_y;
}

/* Standard printf().
 * Only supports the following format strings:
 * %%  - print a literal '%' character
 * %x  - print a number in hexadecimal
 * %u  - print a number as an unsigned integer
 * %d  - print a number as a signed integer
 * %c  - print a character
 * %s  - print a string
 * %#x - print a number in 32-bit aligned hexadecimal, i.e.
 *       print 8 hexadecimal digits, zero-padded on the left.
 *       For example, the hex number "E" would be printed as
 *       "0000000E".
 *       Note: This is slightly different than the libc specification
 *       for the "#" modifier (this implementation doesn't add a "0x" at
 *       the beginning), but I think it's more flexible this way.
 *       Also note: %x is the only conversion specifier that can use
 *       the "#" modifier to alter output. */
int32_t printf(int8_t *format, ...) {

    /* Pointer to the format string */
    int8_t* buf = format;

    /* Stack pointer for the other parameters */
    int32_t* esp = (void *)&format;
    esp++;

    while (*buf != '\0') {
        switch (*buf) {
            case '%':
                {
                    int32_t alternate = 0;
                    buf++;

format_char_switch:
                    /* Conversion specifiers */
                    switch (*buf) {
                        /* Print a literal '%' character */
                        case '%':
                            putc('%');
                            break;

                        /* Use alternate formatting */
                        case '#':
                            alternate = 1;
                            buf++;
                            /* Yes, I know gotos are bad.  This is the
                             * most elegant and general way to do this,
                             * IMHO. */
                            goto format_char_switch;

                        /* Print a number in hexadecimal form */
                        case 'x':
                            {
                                int8_t conv_buf[64];
                                if (alternate == 0) {
                                    itoa(*((uint32_t *)esp), conv_buf, 16);
                                    puts(conv_buf);
                                } else {
                                    int32_t starting_index;
                                    int32_t i;
                                    itoa(*((uint32_t *)esp), &conv_buf[8], 16);
                                    i = starting_index = strlen((unsigned char*)&conv_buf[8]);
                                    while(i < 8) {
                                        conv_buf[i] = '0';
                                        i++;
                                    }
                                    puts(&conv_buf[starting_index]);
                                }
                                esp++;
                            }
                            break;

                        /* Print a number in unsigned int form */
                        case 'u':
                            {
                                int8_t conv_buf[36];
                                itoa(*((uint32_t *)esp), conv_buf, 10);
                                puts(conv_buf);
                                esp++;
                            }
                            break;

                        /* Print a number in signed int form */
                        case 'd':
                            {
                                int8_t conv_buf[36];
                                int32_t value = *((int32_t *)esp);
                                if(value < 0) {
                                    conv_buf[0] = '-';
                                    itoa(-value, &conv_buf[1], 10);
                                } else {
                                    itoa(value, conv_buf, 10);
                                }
                                puts(conv_buf);
                                esp++;
                            }
                            break;

                        /* Print a single character */
                        case 'c':
                            putc((uint8_t) *((int32_t *)esp));
                            esp++;
                            break;

                        /* Print a NULL-terminated string */
                        case 's':
                            puts(*((int8_t **)esp));
                            esp++;
                            break;

                        default:
                            break;
                    }

                }
                break;

            default:
                putc(*buf);
                break;
        }
        buf++;
    }
    if(cur_shell == cur_terminal)
        move_cursor();
    return (buf - format);
}

/* int32_t puts(int8_t* s);
 *   Inputs: int_8* s = pointer to a string of characters
 *   Return Value: Number of bytes written
 *    Function: Output a string to the console */
int32_t puts(int8_t* s) {
    register int32_t index = 0;
    while (s[index] != '\0') {
        putc(s[index]);
        index++;
    }
    if(cur_shell == cur_terminal)
        move_cursor();
    return index;
}

/* void putc(uint8_t c);
 * Inputs: uint_8* c = character to print
 * Return Value: void
 *  Function: Output a character to the console */
void putc(uint8_t c) {
    if(c == '\n' || c == '\r') {
        screen_y++;
        if(screen_y >= NUM_ROWS) {
            scroll_screen();
            screen_y = NUM_ROWS - 1;
        }

        screen_x = 0;
        //if the kbd buffer is on next line move down
      /*  if((terminal_array[cur_terminal].kbd_struct->buffer_occupancy >= NUM_COLS) && (screen_x < BUFFER_SIZE-NUM_COLS)) {
            screen_y++;
          }*/
    } else {
        *(uint8_t *)(video_mem + ((NUM_COLS * screen_y + screen_x) << 1)) = c;
        *(uint8_t *)(video_mem + ((NUM_COLS * screen_y + screen_x) << 1) + 1) = ATTRIB;
        screen_x++;
        //IF THE X IS AT END OF SCREEN, MOVE DOWN
        if(screen_x >= NUM_COLS) {
              screen_y++;
              screen_x = 0;
            }
        if(screen_y >= NUM_ROWS) {
            scroll_screen();
            screen_y = NUM_ROWS - 1;
        }
        screen_x %= NUM_COLS;
        screen_y = (screen_y + (screen_x / NUM_COLS)) % NUM_ROWS;
    }
    if(cur_shell == cur_terminal)
        move_cursor();

}
/*
DESCRIPTION: This scrolls the screen vertically when the text hits the bottom of screen
INPUTS: none
OUTPUTS: none
SIDE EFFECTS: moves video memoory up one row, and clears the last row
*/
void scroll_screen() {
  //holds the next row in the buffer
    /*if(video_mem == (char*)VIDEO_END)
        video_mem = (char*)VIDEO;*/

    char next_row[NUM_COLS];
    //indexes for the for loops
    int i, j;
    //grab the 2nd row, as that will be new first row
    for(i = 0; i < NUM_COLS; i++) {
        next_row[i] = *(uint8_t *)(video_mem + ((NUM_COLS * 1 + i) << 1));
    }

    for(i = 0; i < NUM_ROWS - 2; i++) {
        for(j = 0; j < NUM_COLS; j++) {
            //we scrolled whole thing, now clear the last row
            if(i >= NUM_ROWS - 1) {
              *(uint8_t *)(video_mem + ((NUM_COLS * i + j) << 1)) = ' ';
              *(uint8_t *)(video_mem + ((NUM_COLS * i + j) << 1) + 1) = ATTRIB;
            }
            else {
            *(uint8_t *)(video_mem + ((NUM_COLS * i + j) << 1)) = next_row[j];
            *(uint8_t *)(video_mem + ((NUM_COLS * i + j) << 1) + 1) = ATTRIB;
            next_row[j] = *(uint8_t *)(video_mem + ((NUM_COLS * (i+2) + j) << 1));
          }
      }
    }
    //i = NUM_ROWS - 2;
    for(j = 0; j < NUM_COLS; j++) {
      *(uint8_t *)(video_mem + ((NUM_COLS * i + j) << 1)) = next_row[j];
      *(uint8_t *)(video_mem + ((NUM_COLS * i + j) << 1) + 1) = ATTRIB;
      //next_row[j] = *(uint8_t *)(video_mem + ((NUM_COLS * (i+2) + j) << 1));
    }
    i++;
    for(j = 0; j < NUM_COLS; j++) {
      *(uint8_t *)(video_mem + ((NUM_COLS * i + j) << 1)) = ' ';
      *(uint8_t *)(video_mem + ((NUM_COLS * i + j) << 1) + 1) = ATTRIB;
    }
}

/*
DESCRIPTION: Clears the character on the screen at location (screen_x, screen_y)
INPUTS: none
OUTPUTS: none
SIDE EFFECTS: Removes a character from the screen
*/
void handle_backspace() {
  //get the current values of the screen
  int x = screen_x - kbd_keyread[cur_terminal].index;
  int y = screen_y;
  //update if we have to change lines
  if(x < 0) {
      y--;
      x += NUM_COLS;
  }
  //remove the backspaced char from the buffer and shift all trailing chars down one
  int i;
  for(i = kbd_keyread[cur_terminal].index - 1; i < kbd_keyread[cur_terminal].buffer_occupancy; i++) {
      kbd_keyread[cur_terminal].kbd_buffer[i] = kbd_keyread[cur_terminal].kbd_buffer[i+1];
  }
  //set last entry to null
  kbd_keyread[cur_terminal].kbd_buffer[i+1] = 0x00;
  //decrease the buffer and index since we shifted left one
  kbd_keyread[cur_terminal].buffer_occupancy--;
  kbd_keyread[cur_terminal].index--;

  //reprint the updated buffer
  for(i = 0; i < kbd_keyread[cur_terminal].buffer_occupancy; i++) {
    *(uint8_t *)(video_mem + ((NUM_COLS * y + x) << 1)) = kbd_keyread[cur_terminal].kbd_buffer[i];
    *(uint8_t *)(video_mem + ((NUM_COLS * y + x) << 1) + 1) = ATTRIB;
    x++;
    //if x hits far right side move down a line
    if(x >= NUM_COLS) {
      x = 0;
      y++;
    }
  }
  //the last char is still there so remove it
  *(uint8_t *)(video_mem + ((NUM_COLS * screen_y + x) << 1)) = ' ';
  *(uint8_t *)(video_mem + ((NUM_COLS * screen_y + x) << 1) + 1) = ATTRIB;
  //update the screen x and screen y by decrementing x, shifting rows as necessary
  if(screen_x == 0) {
    screen_x = NUM_COLS;
    screen_y--;
  }
  else
    screen_x--;
  //update the cursor position
  move_cursor();
}

/*
DESCRIPTION: Updates the location of the cursore, this is called when we change the screen
INPUTS: none
OUTPUS: none
SIDE EFFECTS: Changes the location of the cursor
*/
void move_cursor() {
  /*if(cur_shell != cur_terminal)
      return;*/
    uint32_t pos = screen_y*NUM_COLS + screen_x;
    uint8_t s_pos = pos & 0xFF;
    outb(0x0F, 0x3D4);
    outb(s_pos, 0x3D5);
    outb(0x0E, 0x3D4);
    outb((uint8_t)((pos >> 8) & 0xFF), 0x3D5);
}

/*
DESCRIPTION: Moves the cursore left, if it hits screenx = 0 move up and far right
INPUTS: none
OUTPUTS: none
SIDE EFFECTS: changes the location of cursor
*/
void handle_left_key() {
    if(screen_x == 0) {
        screen_x = NUM_COLS - 1;
        screen_y--;
    }
    else {
        screen_x--;
    }
    move_cursor();
}

/*
DESCRIPTION: Moves the cursor right, if it hits right side of screen move down and left side of screen
INPUTS: none
OUTPUTS: none
SIDE EFFECTS: changes the location of cursor
*/
void handle_right_key() {
    if(screen_x == NUM_COLS - 1) {
        screen_x = 0;
        screen_y++;
    }
    else
        screen_x++;

    move_cursor();
}

/* int8_t* itoa(uint32_t value, int8_t* buf, int32_t radix);
 * Inputs: uint32_t value = number to convert
 *            int8_t* buf = allocated buffer to place string in
 *          int32_t radix = base system. hex, oct, dec, etc.
 * Return Value: number of bytes written
 * Function: Convert a number to its ASCII representation, with base "radix" */
int8_t* itoa(uint32_t value, int8_t* buf, int32_t radix) {
    static int8_t lookup[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int8_t *newbuf = buf;
    int32_t i;
    uint32_t newval = value;

    /* Special case for zero */
    if (value == 0) {
        buf[0] = '0';
        buf[1] = '\0';
        return buf;
    }

    /* Go through the number one place value at a time, and add the
     * correct digit to "newbuf".  We actually add characters to the
     * ASCII string from lowest place value to highest, which is the
     * opposite of how the number should be printed.  We'll reverse the
     * characters later. */
    while (newval > 0) {
        i = newval % radix;
        *newbuf = lookup[i];
        newbuf++;
        newval /= radix;
    }

    /* Add a terminating NULL */
    *newbuf = '\0';

    /* Reverse the string and return */
    return strrev(buf);
}

/* int8_t* strrev(int8_t* s);
 * Inputs: int8_t* s = string to reverse
 * Return Value: reversed string
 * Function: reverses a string s */
int8_t* strrev(int8_t* s) {
    register int8_t tmp;
    register int32_t beg = 0;
    register int32_t end = strlen((unsigned char*)s) - 1;

    while (beg < end) {
        tmp = s[end];
        s[end] = s[beg];
        s[beg] = tmp;
        beg++;
        end--;
    }
    return s;
}

/* uint32_t strlen(const int8_t* s);
 * Inputs: const int8_t* s = string to take length of
 * Return Value: length of string s
 * Function: return length of string s */
uint32_t strlen(const uint8_t* s) {
    register uint32_t len = 0;
    while (s[len] != '\0')
        len++;
    return len;
}
/* int32_t cmp_string(const char* a, const char* b)
*     DESCRIPTION: Compares to strings.
*     INPUTS: const char* a : string 1
*             const char* b : string 2
*     OUTPUTS: -1 for not the same. 0 for equals
*     SIDE EFFECTS: None
*/
int32_t cmp_string(const unsigned char* a, const unsigned char* b){

  int x = strlen((uint8_t *) a);
  int y = strlen((uint8_t *) b);
  int i;
  if (x!=y){
    return -1;
  }

  for(i = 0; i < x; i++){
    if(a[i] != b[i]){
      return -1;
    }
  }
  return 0;
}

/*
DESCRIPTION: Copies string b to string a
INPUTS:  	a - string to copy to
			b - string to copy from
OUTPUS: none
SIDE EFFECTS: string a gets the contents of string b
*/
void cpy_string(unsigned char* a, const unsigned char* b){
  int i;
  int x = strlen((uint8_t *) b);
  for(i = 0; i <= x; i++){
    a[i] = b[i];
  }
}
/* int32_t cpy_to_space(unsigned char* a, const unsigned char* b)
*      description: Copies the file name before the space in a string
*      input: a - string to copy to
*             b - string to copy from
*      output: 0 for success, -1 for failure
*      side effects: changes the a string to be the argument
*/
int32_t cpy_to_space(unsigned char* a, const unsigned char* b){
	int i;
	i = 0;
	int x = strlen(b);
	while(b[i] != ' ' &&  b[i] != '\0')			// While b != a space or a null
	{
		a[i] = b[i];
		if(i > x){
			return -1;							// Invalid string
		}
		i++;
	}
	a[i] = '\0';
	return 0;									// Valid string to copy over
}
/* int32_t cpy_after_space(unsigned char* a, const unsigned char* b)
*      description: Copies the argument after the space in a string
*      input: a - string to copy to
*             b - string to copy from
*      output: 0 for success, -1 for failure
*      side effects: changes the a string to be the argument
*/
int32_t cpy_after_space(unsigned char* a, const unsigned char* b){
	int y;
	for(y = 0; y < USER_BUF_SIZE; y++){    // Clears out the a string
		a[y] = '\0';
	}


	int i;
	i = 0;
	int z;
	int x = strlen(b);
	while(b[i] != ' ' &&  b[i] != '\0')			// While b != a space or a null
	{	i++;									// We use this to find the total number of i that is necessary before we get to our argument
	if(i > x || b[i] == '\0'){					// If we have somehow counted over or it has reached a null character, then this is an invalid string
			return -1; }
	}
  while(b[i] == ' ' && b[i] != '\0'){
    i++;
  }
	z = 0;
	if(i > x){return -1;}
	while(b[i] != '\0' && z != USER_BUF_SIZE && b[i] != ' '){	// The size of the buffer we are using this for is only 20 characters long
	a[z] = b[i];
	if(i > x){
	return -1;}			// If it has somehow gone over the alotted strings, just yeet it}
	i++;
	z++;
	}
	a[z] = '\0'; 				// Fill out the Null character into it's specific location
	return 0;					// A potentially valid string is copied over
}



/* void* memset(void* s, int32_t c, uint32_t n);
 * Inputs:    void* s = pointer to memory
 *          int32_t c = value to set memory to
 *         uint32_t n = number of bytes to set
 * Return Value: new string
 * Function: set n consecutive bytes of pointer s to value c */
void* memset(void* s, int32_t c, uint32_t n) {
    c &= 0xFF;
    asm volatile ("                 \n\
            .memset_top:            \n\
            testl   %%ecx, %%ecx    \n\
            jz      .memset_done    \n\
            testl   $0x3, %%edi     \n\
            jz      .memset_aligned \n\
            movb    %%al, (%%edi)   \n\
            addl    $1, %%edi       \n\
            subl    $1, %%ecx       \n\
            jmp     .memset_top     \n\
            .memset_aligned:        \n\
            movw    %%ds, %%dx      \n\
            movw    %%dx, %%es      \n\
            movl    %%ecx, %%edx    \n\
            shrl    $2, %%ecx       \n\
            andl    $0x3, %%edx     \n\
            cld                     \n\
            rep     stosl           \n\
            .memset_bottom:         \n\
            testl   %%edx, %%edx    \n\
            jz      .memset_done    \n\
            movb    %%al, (%%edi)   \n\
            addl    $1, %%edi       \n\
            subl    $1, %%edx       \n\
            jmp     .memset_bottom  \n\
            .memset_done:           \n\
            "
            :
            : "a"(c << 24 | c << 16 | c << 8 | c), "D"(s), "c"(n)
            : "edx", "memory", "cc"
    );
    return s;
}

/* void* memset_word(void* s, int32_t c, uint32_t n);
 * Description: Optimized memset_word
 * Inputs:    void* s = pointer to memory
 *          int32_t c = value to set memory to
 *         uint32_t n = number of bytes to set
 * Return Value: new string
 * Function: set lower 16 bits of n consecutive memory locations of pointer s to value c */
void* memset_word(void* s, int32_t c, uint32_t n) {
    asm volatile ("                 \n\
            movw    %%ds, %%dx      \n\
            movw    %%dx, %%es      \n\
            cld                     \n\
            rep     stosw           \n\
            "
            :
            : "a"(c), "D"(s), "c"(n)
            : "edx", "memory", "cc"
    );
    return s;
}

/* void* memset_dword(void* s, int32_t c, uint32_t n);
 * Inputs:    void* s = pointer to memory
 *          int32_t c = value to set memory to
 *         uint32_t n = number of bytes to set
 * Return Value: new string
 * Function: set n consecutive memory locations of pointer s to value c */
void* memset_dword(void* s, int32_t c, uint32_t n) {
    asm volatile ("                 \n\
            movw    %%ds, %%dx      \n\
            movw    %%dx, %%es      \n\
            cld                     \n\
            rep     stosl           \n\
            "
            :
            : "a"(c), "D"(s), "c"(n)
            : "edx", "memory", "cc"
    );
    return s;
}

/* void* memcpy(void* dest, const void* src, uint32_t n);
 * Inputs:      void* dest = destination of copy
 *         const void* src = source of copy
 *              uint32_t n = number of byets to copy
 * Return Value: pointer to dest
 * Function: copy n bytes of src to dest */
void* memcpy(void* dest, const void* src, uint32_t n) {
    asm volatile ("                 \n\
            .memcpy_top:            \n\
            testl   %%ecx, %%ecx    \n\
            jz      .memcpy_done    \n\
            testl   $0x3, %%edi     \n\
            jz      .memcpy_aligned \n\
            movb    (%%esi), %%al   \n\
            movb    %%al, (%%edi)   \n\
            addl    $1, %%edi       \n\
            addl    $1, %%esi       \n\
            subl    $1, %%ecx       \n\
            jmp     .memcpy_top     \n\
            .memcpy_aligned:        \n\
            movw    %%ds, %%dx      \n\
            movw    %%dx, %%es      \n\
            movl    %%ecx, %%edx    \n\
            shrl    $2, %%ecx       \n\
            andl    $0x3, %%edx     \n\
            cld                     \n\
            rep     movsl           \n\
            .memcpy_bottom:         \n\
            testl   %%edx, %%edx    \n\
            jz      .memcpy_done    \n\
            movb    (%%esi), %%al   \n\
            movb    %%al, (%%edi)   \n\
            addl    $1, %%edi       \n\
            addl    $1, %%esi       \n\
            subl    $1, %%edx       \n\
            jmp     .memcpy_bottom  \n\
            .memcpy_done:           \n\
            "
            :
            : "S"(src), "D"(dest), "c"(n)
            : "eax", "edx", "memory", "cc"
    );
    return dest;
}

/* void* memmove(void* dest, const void* src, uint32_t n);
 * Description: Optimized memmove (used for overlapping memory areas)
 * Inputs:      void* dest = destination of move
 *         const void* src = source of move
 *              uint32_t n = number of byets to move
 * Return Value: pointer to dest
 * Function: move n bytes of src to dest */
void* memmove(void* dest, const void* src, uint32_t n) {
    asm volatile ("                             \n\
            movw    %%ds, %%dx                  \n\
            movw    %%dx, %%es                  \n\
            cld                                 \n\
            cmp     %%edi, %%esi                \n\
            jae     .memmove_go                 \n\
            leal    -1(%%esi, %%ecx), %%esi     \n\
            leal    -1(%%edi, %%ecx), %%edi     \n\
            std                                 \n\
            .memmove_go:                        \n\
            rep     movsb                       \n\
            "
            :
            : "D"(dest), "S"(src), "c"(n)
            : "edx", "memory", "cc"
    );
    return dest;
}

/* int32_t strncmp(const int8_t* s1, const int8_t* s2, uint32_t n)
 * Inputs: const int8_t* s1 = first string to compare
 *         const int8_t* s2 = second string to compare
 *               uint32_t n = number of bytes to compare
 * Return Value: A zero value indicates that the characters compared
 *               in both strings form the same string.
 *               A value greater than zero indicates that the first
 *               character that does not match has a greater value
 *               in str1 than in str2; And a value less than zero
 *               indicates the opposite.
 * Function: compares string 1 and string 2 for equality */
int32_t strncmp(const int8_t* s1, const int8_t* s2, uint32_t n) {
    int32_t i;
    for (i = 0; i < n; i++) {
        if ((s1[i] != s2[i]) || (s1[i] == '\0') /* || s2[i] == '\0' */) {

            /* The s2[i] == '\0' is unnecessary because of the short-circuit
             * semantics of 'if' expressions in C.  If the first expression
             * (s1[i] != s2[i]) evaluates to false, that is, if s1[i] ==
             * s2[i], then we only need to test either s1[i] or s2[i] for
             * '\0', since we know they are equal. */
            return s1[i] - s2[i];
        }
    }
    return 0;
}

/* int8_t* strcpy(int8_t* dest, const int8_t* src)
 * Inputs:      int8_t* dest = destination string of copy
 *         const int8_t* src = source string of copy
 * Return Value: pointer to dest
 * Function: copy the source string into the destination string */
int8_t* strcpy(int8_t* dest, const int8_t* src) {
    int32_t i = 0;
    while (src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0';
    return dest;
}

/* int8_t* strcpy(int8_t* dest, const int8_t* src, uint32_t n)
 * Inputs:      int8_t* dest = destination string of copy
 *         const int8_t* src = source string of copy
 *                uint32_t n = number of bytes to copy
 * Return Value: pointer to dest
 * Function: copy n bytes of the source string into the destination string */
int8_t* strncpy(int8_t* dest, const int8_t* src, uint32_t n) {
    int32_t i = 0;
    while (src[i] != '\0' && i < n) {
        dest[i] = src[i];
        i++;
    }
    while (i < n) {
        dest[i] = '\0';
        i++;
    }
    return dest;
}

/* void test_interrupts(void)
 * Inputs: void
 * Return Value: void
 * Function: increments video memory. To be used to test rtc */
void test_interrupts(void) {
    int32_t i;
    for (i = 0; i < NUM_ROWS * NUM_COLS; i++) {
        video_mem[i << 1]++;
    }
}
