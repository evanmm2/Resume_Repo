#include "RTC.h"
#include "lib.h"
#include "i8259.h"
#include "idt.h"
#include "interrupt_calls.h"
#include "terminal.h"

#define REGISTER_NUMBER 0x70    // Register port to specify which register to Read/write to
#define DATA_BUS		0x71    // Data port to read/write from RTC



// These are used to access the different registers on outb commands
#define REGISTER_A 		0x8A        // These hex codes give registers offset A->D
#define REGISTER_B 		0x8B
#define REGISTER_C 		0x0C
#define REGISTER_D 		0x0D

#define INIT_A			0x20	// Initializes it to start the ocillator and set it to zero speed
#define INIT_B			0x0D	// Initializes it so that it does normal counting no alarm enable no update enable. Square wave yes. Binary yes. Daylight savings adjustment yes.

#define PIE_ON			0x40    // Or this with the previous value from the RTC to set the bit


#define BYTES_WRITTEN   0x01    // Number of bytes written to in RTC_write
#define Clear_Speed     0xF0    // Used to clear the previous speed in frequency_RTC


void RTC_PIE_ON();              // Helper function to set the PIE on. There will be many more according standard inplementation of RTC


static int total_interrupts;    // Was used to keep track of total interrupts for debugging
volatile int cur_interrupts;    // This is used to keep track of if there is a current interrupt or not

/*  RTC_PIE_ON
*       DESCRIPTION: Used to turn on the PIE bit in RTC
*       INPUTS: NONE
*       OUTPUTS: NONE
*       RETURNS: NONE
*       SIDE EFFECTS: Sets the PIE bit in the RTC to be on
*/

void RTC_PIE_ON(){
	int flags;
	int8_t val;
	// Stop interrupts and save flags before we mess with the PIC
	cli_and_save(flags);
	// Gets the value from register b
	outb(REGISTER_B,REGISTER_NUMBER);
	val = inb(DATA_BUS);
	// ors it the 0x40 to set the PIE
	val = val | PIE_ON;
	// put the PIE back in to the PIC
	outb(REGISTER_B, REGISTER_NUMBER);
	outb(val,DATA_BUS);
	// Restores the flags and interrupts
	restore_flags(flags);

}

/*---------------------------------------------------------------------*/
/*              Set up the space above with helper functions           */
/*                                                                     */
/*---------------------------------------------------------------------*/


/*  init_RTC
*       DESCRIPTION: Used to initialize the RTC
*       INPUTS: NONE
*       OUTPUTS: NONE
*       RETURNS: NONE
*       SIDE EFFECTS: Sends two bytes to ports A and B in the RTC to initialize it, sets the interrupts gate for IDT, enables the PIC port
*/

void init_RTC(){
	int flags;  // Variable for saving flags
	cli_and_save(flags);
	//Do the commands to set it up. Should send the right command into location A. Look at RTC documentation on site for info on what this number does.
	outb(REGISTER_A, REGISTER_NUMBER);
	outb(INIT_A, DATA_BUS);

	// Do the commands to set up register B
	outb(REGISTER_B, REGISTER_NUMBER);
	outb(INIT_B, DATA_BUS);

	// Set PIE
	RTC_PIE_ON();

	restore_flags(flags);

	// Initialize the total number of interrupts
	total_interrupts = 0;
	// Let it actually communicate through this pic port

	enable_irq(SLAVE_IRQ0);
	cur_interrupts = 0;
}

/*  handle_RTC
*       DESCRIPTION: Used to handle the RTC after an interrupt
*       INPUTS: NONE
*       OUTPUTS: NONE
*       RETURNS: NONE
*       SIDE EFFECTS: Increases total interrupts, uses the test_interrupts from lib, sends eoi, reads from port C to let the RTC continue
*/

void handle_sig_RTC(){
	int flags;
	cli_and_save(flags);
	// Increase the total number of interrupts each time the handler pops
	total_interrupts++;
	cur_interrupts = 1;
	// Check to see how many times the handler has popped
	//test_interrupts();
	//clear();
	//puts("RTC");
	//printf("handle_RTC %d\n", total_interrupts);
	// This is used to test the interrupts.
	//test_interrupts();
	// Has to be read so that the next interrupt can be allowed
	outb(REGISTER_C, REGISTER_NUMBER);
	inb(DATA_BUS);

	// Lets it send more interrupts on the PIC
	send_eoi(SLAVE_IRQ0);
	restore_flags(flags);
}

/*  frequency_RTC
*       DESCRIPTION: Used to change the frequency of the RTC
*       INPUTS: int x -- frequency to set to
*       OUTPUTS: NONE
*       RETURNS: NONE
*       SIDE EFFECTS: changes the frequenc of the RTC
*/
void frequency_RTC(int x){
	int8_t z;			                    	// Use z for math
	int flags;				                    // Saves Flags
	cli_and_save(flags);
	outb(REGISTER_A, REGISTER_NUMBER);			// Get the previous value
	z = inb(DATA_BUS);
	z &= Clear_Speed;		// Clears the speed
	z |= x;					// Sets the speed to the necessary number
	outb(REGISTER_A, REGISTER_NUMBER);
	outb(z, DATA_BUS);

	restore_flags(flags);		// Restores the flags
}

// Opens the file. Only sets the frequency for right now
/* open_RTC
*       DESCRIPTION: Opens an instance of RTC in the file system. Just sets frequency to 2 Hz for right now
*       INPUTS: filename - The name of the file to open
*       OUTPUTS: Zero for success
*       SIDE EFFECTS: Sets the frequency of the RTC to 2 Hz
*/
int32_t open_RTC(const uint8_t* filename){
		cli();
    frequency_RTC(SPEED_1);     // Sets frequency to 2 Hz
		pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
		pcb_addr->RTC_freq = SPEED_1;  // Update the frequency for this process
		cur_interrupts = 0;
		sti();
    return 0;
}


// Closes the file. Does nothing yet
/*  close_RTC
*       DESCRIPTION: Closes the instance of RTC in the filesystem
*       INPUTS: fd - the file system array location to wipe
*       OUTPUTS:    Zero
*       SIDE EFFECTS: None. Does not affect frequency or anything else right now. Will eventuall have to close the file descriptor
*/
int32_t close_RTC(int32_t fd){
		cli();
		pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
		pcb_addr->RTC_freq = SPEED_0;		// Set the frequency for this process
		sti();
    return 0;       // Just return zero for checkpoint 2

}


// Reads from the file. Does not happen until the next interrupt happens.
/*  read_RTC
*       DESCRIPTION: Waits until there is an interrupt from the pic and then continues with whatever it's supposed to "read"
*       INPUTS: RTC_fd - file descriptor to read from
*               buf - the buffer to put data into if we were reading from something
                nbytes - the number of bytes we would have to read into the buffer
*       OUTPUTS: None
*       SIDE EFFECTS: Right now it changes the screen with test interrupts so we can test that read is working only at the speed the interrupts allow
*/
int32_t read_RTC(int32_t fd, void* buf, int32_t nbytes){
    while(cur_interrupts == 0){} // Infinite loop while it's waiting for an interrupt to be raised.
    cur_interrupts = 0;          // Reset to no interrupts. Zero here resets the flag
    return 0;             // Success, so it returns zero
}

// Is supposed to set up the frequency to the requested value
/*  write_RTC
*       DESCRIPTION: Changes the RTC frequency. Only takes powers of two up to 1024
*       INPUTS: RTC_fd - The file descriptor for the RTC
*               buf - the frequency to change the RTC to
*               nbytes - the number of bytes written from user to RTC
*       OUTPUTS: -1 if a valid frequency is not passed
                 nbytes if it was successful
        SIDE EFFECTS: Changes the frequency of the RTC
*/
int32_t write_RTC(int32_t fd, const void* buf, int32_t nbytes){    // This is assuming the frequency data is being passed through the buffer
	 int flags;
	 cli_and_save(flags);
     int z;                                 // z is used for the frequency_RTC parameter. It is set in the case statement.
     uint32_t* data  = (uint32_t*)buf;        // Makes the buffer data useable by casting it as a pointer
		 //pcb_t * curPCB = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCBOFFSET);
		 switch(*data){                         // Dereferences the pointer and uses that data to determine the switch value
		 case Hz0:    z = SPEED_0;
		 break;
         case Hz2:    z = SPEED_1;          // Each of these cases converts the requested Hz into a useable value for the frequency function
         break;
         case Hz4:    z = SPEED_2;
         break;
         case Hz8:    z = SPEED_3;
         break;
         case Hz16:   z = SPEED_4;
         break;
         case Hz32:   z = SPEED_5;
         break;
         case Hz64:   z = SPEED_6;
         break;
         case Hz128:  z = SPEED_7;
         break;
         case Hz256:  z = SPEED_8;
         break;
         case Hz512:  z = SPEED_9;
         break;
         case Hz1024: z = SPEED_10;         // Only allowed to do speeds up to 1024
         break;
         default: return -1;                // If the frequency isn't any of the ones that we want, then there was an invalid parameter.
     }
		 //curPCB->RTC_freq = z;
    frequency_RTC(z);                       // Sets the frequency to the requested value
		pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
		pcb_addr->RTC_freq = z; // Update the frequency for this process
	restore_flags(flags);
    return  nbytes;                         // Only one byte is being actually "written", but to confirm if it works in a standard set of programs, it should return it's nbytes
}
