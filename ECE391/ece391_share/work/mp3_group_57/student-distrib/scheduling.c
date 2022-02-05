#include "scheduling.h"

// OSS: Includes for all the things scheduler has going on
// OSS: from PIT data page, we know the necesssary regisgter information
// OSS: https://www.scs.stanford.edu/10wi-cs140/pintos/specs/8254.pdf
// OSS: ^ use above link as datasheet for the i8254 chip
// OSS: status register is latched to the data bus

#define PIT_MASK 0xFF       // OSS: local mask for enabling you to set the frequency, defined so not a magic num

static int pit_initialized_flag;


/*
Description: Initializes the PIT to interupt with highest priority at 33 MHZ
Input: none
Output: None
Side Effects: Pit functions and interrupts properly.
Notes: None
*/
void scheduler_initialize(void)
{
    pit_helper();
    pit_initialized_flag = 1;
    enable_irq(0);          // OSS: enable interrupts on the highest priority interrupt line
}

/*
Description: Initializes the PITto function at  33 MHZ
Input: none
Output: None
Side Effects: Pit runs at 33Mhz
Notes: None
*/
void pit_helper(void)
{
    if(pit_initialized_flag == 1)
    {
        return; // OSS: return if already initialized
    }
    set_pit_mode();                                                         // OSS: set the PIT mode to square wave BAUD mode (see datasheet pg10)
    outb((HZ_I_33 & PIT_MASK), SCHED_CHANNEL);  // OSS: send   your 33 interrupts frequency to the PIT channel
    outb(HZ_I_33 >> MASK_SHIFT, SCHED_CHANNEL);
}

/*
Description: Pit interupt driven thread control switch
Input: none
Output: none
Side Effect: The next active thread has contorl and the previous threads registers are saved in its pcb
Notes: Bug occured here since the context switch clobbered registers. Errors were infrequent before this was fixed
*/

void scheduler_switch(void)
{
  cli();
  pcb_t* cur_pcb = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
  //save regs in the pcb
  cur_pcb->eax = pit_eax;
  cur_pcb->ebx = pit_ebx;
  cur_pcb->ecx = pit_ecx;
  cur_pcb->edx = pit_edx;
  cur_pcb->esi = pit_esi;
  cur_pcb->edi = pit_edi;
  //send PIT its eoi
  send_eoi(MASTER_IRQ0);

  int y;
  int next_process = cur_shell;
  for(y = 0; y < NUM_TERMINALS; y++)
  {
      next_process = (next_process + 1) % 3;  // OSS: this is the round robin scheduling part in action, it will go from terminal 1 to 3 to check which process is running
      if(next_process == cur_shell)
          return;
      if(shell_present[next_process] == 1)
          break;
  }
  save_screen_location(cur_shell);
  //get the current pcb
  pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
  //save the task returning info
  pcb_addr->esp = pit_esp;
  pcb_addr->ebp = pit_ebp;
  //save the esp0 for this task, this is where we want to go for halt
  pcb_addr->esp0 = tss.esp0;

  int i;
  //save current files
  for(i = 0; i < NUM_PROCESS_FILES; i++)
      pcb_addr->process_files[i] = cur_process_files[i];


  cur_shell = next_process;
  //this is process ID to return to
  int process_ret = thread_position[next_process];
  //get the pcb for the process_ret
  pcb_addr = (pcb_t*)(EIGHT_MB - (process_ret)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);

  //update process files for process we are switching to
  for(i = 0; i < NUM_PROCESS_FILES; i++)
      cur_process_files[i] = pcb_addr->process_files[i];

  //update cur process with the active thread of next_process
  cur_process = thread_position[next_process];
  //change the page dir
  user_page(process_ret);
  purge_tlb();
  //change the tss to the process_ret saved esp0
  tss.esp0 = pcb_addr->esp0;
  //if we are on cur_terminal we can print to physical vid mem, otherwise print to a save page
  if(cur_shell == cur_terminal)
      reset_vid();
  else
      vid_swap();

  purge_tlb();
  //set screenx and screeny to process we are jumping to
  update_screen(cur_shell);

  cur_pcb = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
  //get regs ready to restore in asm
  pit_eax = cur_pcb->eax;
  pit_ebx = cur_pcb->ebx;
  pit_ecx = cur_pcb->ecx;
  pit_edx = cur_pcb->edx;
  pit_esi = cur_pcb->esi;
  pit_edi = cur_pcb->edi;
  //switch the stacks and iret

  frequency_RTC(cur_pcb->RTC_freq);
  process_return(pcb_addr->ebp, pcb_addr->esp);


}

/*
Description: Sets the Pits frequency to 33MHZ
Input: None
Output: None
Side Effects: PIT freq is 33 MHZ
Notes:
*/
void set_pit_mode(void)
{
    if(pit_initialized_flag == 1)
    {
        return;
    }
    outb(SPEED, TIMER_REG);  // OSS: set the timing register to mode 3;
    /* *
     *  THE PIT has 8 bit data control word with the following
     *  structure:
     *
     *  SC1   SC0   RW1   RW0   M2   M1   M0   BCD
     *
     * [ SC1: select counter 1 and SC0: select counter 0]
     * not important for us in this case. We will leave these as 0, to se;ect counter 0.
     *
     * [RW1 and RW0: want both to be 1, so we can write MSB first and then LSB]
     * [M2:M0] => mode bits. We want mode three, so that number is 011.
     * final number is 00:11:011:0
     *                       ^this translates to 0x36.
     * */
}
