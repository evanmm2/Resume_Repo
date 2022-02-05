#include "idt.h"

static uint32_t intr_flag;

/*
initialize_idt
DESCRIPTION: Initialize the IDT by calling set_x_gate to fill the table
INPUTS: None
OUTPUTS: none
SIDE EFFECTS: Fills the IDT with the Intel interrupts
*/
void initialize_idt(void)
{
  //initilize a default signal, for testing
  int i;
  for(i = 0; i < 256; i++) {
    idt[i].present = 0x0;
    idt[i].dpl = KERNEL_DPL;
    idt[i].reserved0 = 0x0;
    idt[i].reserved1 = 0x1;
    idt[i].reserved2 = 0x1;
    idt[i].reserved3 = 0x1;
    idt[i].reserved4 = 0x0;
    idt[i].size = 0x1;
    idt[i].seg_selector = KERNEL_CS;
  }


  /*initilize intels interruptss*/
  set_trap_gate(SIG_DE, (uint32_t)handle_SIG_DE);
  set_trap_gate(SIG_DBG, (uint32_t)handle_SIG_DBG);
  set_trap_gate(SIG_NMI, (uint32_t)handle_SIG_NMI);
  set_trap_gate(SIG_BP, (uint32_t)handle_SIG_BP);
  set_trap_gate(SIG_OF, (uint32_t)handle_SIG_OF);
  set_trap_gate(SIG_BR, (uint32_t)handle_SIG_BR);
  set_trap_gate(SIG_UD, (uint32_t)handle_SIG_UD);
  set_trap_gate(SIG_NM, (uint32_t)handle_SIG_NM);
  //SIG_DDF ABORTS
  set_interrupt_gate(SIG_DDF, (uint32_t)handle_SIG_DDF);
  set_trap_gate(SIG_SEGO, (uint32_t)handle_SIG_SEGO);
  set_trap_gate(SIG_TSS, (uint32_t)handle_SIG_TSS);
  set_trap_gate(SIG_NP, (uint32_t)handle_SIG_NP);
  set_trap_gate(SIG_SS, (uint32_t)handle_SIG_SS);
  set_trap_gate(SIG_GP, (uint32_t)handle_SIG_GP);
  set_trap_gate(SIG_PF, (uint32_t)handle_SIG_PF);
  set_trap_gate(SIG_FP, (uint32_t)handle_SIG_FP);
  set_trap_gate(SIG_AC, (uint32_t)handle_SIG_AC);
  //SIG_MC ABORTS
  set_interrupt_gate(SIG_MC, (uint32_t)handle_SIG_MC);
  set_trap_gate(SIG_XF, (uint32_t)handle_SIG_XF);

  //set_trap_gate(SIG_RTC, (uint32_t)handle_RTC);	// Sets up the RTC handler gate in the IDT
  set_trap_gate(SIG_RTC, (uint32_t)handle_RTC);
  //set user gate which is called during function calls
  set_trap_gate(SIG_PIT, (unsigned int)handle_PIT);

  set_user_gate(SIG_USER, (int)handle_SIG_USER);

/*no interrups have been seen*/
intr_flag = 0;

}

/*  set_user_gate(uint8_t n, uint32_t addr)
*       description: sets up a trap gate for the user functions
*       inputs: n - the idt entry to set
*               addr - the function address
*       outputs: None
*       side effects: sets up the idt table location for the system call
*/
void set_user_gate(uint8_t n, uint32_t addr)
{
  //these interupt vectors are present, so set to 1
  idt[n].present = 0x1;

  //sets priority lvl to user
  idt[n].dpl = USER_DPL;

  //This is trap gate indentifyer data in struct, 01110
  idt[n].reserved0 = 0x0;
  idt[n].reserved1 = 0x1;
  idt[n].reserved2 = 0x1;
  idt[n].reserved3 = 0x1;
  idt[n].reserved4 = 0x0;

  //This determines the size as 32 bits
  idt[n].size = 0x1;

  //The segment selector will always be in the kernel
  idt[n].seg_selector = KERNEL_CS;

  SET_IDT_ENTRY(idt[n], addr);


}

/* * * * * * * * * * * * * * * * * * * * * * *
 *  set_interrupt_gate()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - a line number n
 *          - an address integer
 *
 *
 *      outputs:
 *        will set an interrupt gate at the current line number
 *        and address.
 *
 *      side effects:
 *
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes:  works
 * * * * * * * * * * * * * * * * * * * * * * *
 */
void set_interrupt_gate(uint8_t n, uint32_t addr)
{

  //these interupt vectors are present, so set to 1
  idt[n].present = 0x1;

  //sets priority lvl to highest
  idt[n].dpl = KERNEL_DPL;

  //This is interrupt gate indentifyer data in struct, 0D1100
  idt[n].reserved0 = 0x0;
  idt[n].reserved1 = 0x1;
  idt[n].reserved2 = 0x1;
  idt[n].reserved3 = 0x0;
  idt[n].reserved4 = 0x0;

  //This determines the size as 32 bits
  idt[n].size = 0x1;

  //The segment selector will always be in the kernel
  idt[n].seg_selector = KERNEL_CS;

  SET_IDT_ENTRY(idt[n], addr);

}

/* * * * * * * * * * * * * * * * * * * * * * *
 * set_trap_gate()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - a line number n and an address integer
 *
 *
 *      outputs:
 *        - will set a trap gate at the current line number and address.
 *        and allows exceptions to be handled.
 *
 *      side effects:
 *
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes:  works
 * * * * * * * * * * * * * * * * * * * * * * *
 */
void set_trap_gate(uint8_t n, uint32_t addr)
{
  //these interupt vectors are present, so set to 1
  idt[n].present = 0x1;

  //sets priority lvl to highest
  idt[n].dpl = KERNEL_DPL;

  //This is trap gate indentifyer data in struct, 01110
  idt[n].reserved0 = 0x0;
  idt[n].reserved1 = 0x1;
  idt[n].reserved2 = 0x1;
  idt[n].reserved3 = 0x1;
  idt[n].reserved4 = 0x0;

  //This determines the size as 32 bits
  idt[n].size = 0x1;

  //The segment selector will always be in the kernel
  idt[n].seg_selector = KERNEL_CS;

  SET_IDT_ENTRY(idt[n], addr);


}

/* * * * * * * * * * * * * * * * * * * * * * *
 *  handle_exception()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - an interrupt vector
 *
 *
 *      outputs:
 *        - called when an eception is generated,
 *        - creates a message to print to the screen
 *
 *
 *      side effects:
 *          returns "unknown interrupt" on bad ivector
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes:  works
 * * * * * * * * * * * * * * * * * * * * * * *
 */
void handle_exception(int ivector)
{
/*insert blue screen of death, and case statemant that puts the excetpiton
to the screen*/
//WHY 8 BITS?????????????????????????????????????????????????????
int8_t* msg;

switch(ivector) {
  case SIG_DE: msg = "EXCEPTION Divison error\n"; break;
  case SIG_DBG: msg = "EXCEPTION Reserved\n"; break;
  case SIG_NMI: msg = "EXCEPTION NMI interrupt\n"; break;
  case SIG_BP: msg = "EXCEPTION Breakpoint\n"; break;
  case SIG_OF: msg = "EXCEPTION  Overflow\n"; break;
  case SIG_BR: msg = "EXCEPTION BOUND Range Exceeded\n"; break;
  case SIG_UD: msg = "EXCEPTION Invalid Opcode\n"; break;
  case SIG_NM: msg = "EXCEPTION Device not available\n"; break;
  case SIG_DDF: msg = "EXCEPTION Double fault\n"; break;
  case SIG_SEGO: msg = "EXCEPTION Coprocessor Segment Overrun\n"; break;
  case SIG_TSS: msg = "EXCEPTION Invalid TSS\n"; break;
  case SIG_NP: msg = "EXCEPTION Segment Not Present\n"; break;
  case SIG_SS: msg = "EXCEPTION Stack-Segment Fault\n"; break;
  case SIG_GP: msg = "EXCEPTION General Protection\n"; break;
  case SIG_PF: msg = "EXCEPTION Page Fault\n"; break;
  case SIG_FP: msg = "EXCEPTION Floating-Point Error\n"; break;
  case SIG_AC: msg = "EXCEPTION Alignment Check\n"; break;
  case SIG_MC: msg = "EXCEPTION Machine Check\n"; break;
  case SIG_XF: msg = "EXCEPTION Floating-Point Exception\n"; break;
  //case SIG_BAD: msg = "GARBAGE\n"; break;
  default:  msg = "EXCEPTION Unknown Interrupt"; break;
}

reset_vid();
purge_tlb();

cli();
clear();
printf(" %s", msg);

while(1);
/*INSET BLUE SCREEN*/

//halt();
}

/* * * * * * * * * * * * * * * * * * * * * * *
 *  set_system_gate()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - a line number n and an address
 *
 *
 *      outputs:
 *        - will set a system gate at the following line
 *        number and address.
 *
 *      side effects:
 *          user level code.
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes:  works
 * * * * * * * * * * * * * * * * * * * * * * *
 */
void set_system_gate(uint8_t n, uint32_t addr)
{

  //these interupt vectors are present, so set to 1
  idt[n].present = 0x1;

  //sets priority lvl to highest
  idt[n].dpl = USER_DPL;

  //This is trap gate indentifyer data in struct, 01110
  idt[n].reserved0 = 0x0;
  idt[n].reserved1 = 0x1;
  idt[n].reserved2 = 0x1;
  idt[n].reserved3 = 0x1;
  idt[n].reserved4 = 0x0;

  //This determines the size as 32 bits
  idt[n].size = 0x1;

  //The segment selector will always be in the kernel
  idt[n].seg_selector = KERNEL_CS;

  SET_IDT_ENTRY(idt[n], addr);

}

/* * * * * * * * * * * * * * * * * * * * * * *
 *  exception_found()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - none
 *
 *
 *      outputs:
 *        - helper called when an exception found
 *
 *      side effects:
 *          none
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes:  works
 * * * * * * * * * * * * * * * * * * * * * * *
 */
uint32_t exception_found(void)
{
      //save the intr_flag to return it later
  int val = intr_flag;

  //clear the interrupt flag
  intr_flag = 0;

  return val;
}
