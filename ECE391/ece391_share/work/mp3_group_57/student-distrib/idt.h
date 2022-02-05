#ifndef IDT_H
#define IDT_H

#include "types.h"
#include "interrupt_calls.h"
#include "x86_desc.h"
#include "lib.h"
#include "RTC.h"
#include "keyboard.h"


//File created by Sayan Sur

#define SIG_DE      0
#define SIG_DBG     1
#define SIG_NMI     2
#define SIG_BP      3   //breakpoint exception
#define SIG_OF      4   //overflow exception
#define SIG_BR      5   //bound range exceeded exception
#define SIG_UD      6   //bad opcode
#define SIG_NM      7   //device not available
#define SIG_DDF     8   //double fault
#define SIG_SEGO    9   //segment overflow
#define SIG_TSS     10  //invalid TSS
#define SIG_NP      11  //segment not present
#define SIG_SS      12  //stack fault
#define SIG_GP      13  //general protection
#define SIG_PF      14  //page fault

// number 15 is reserved by intel cuase reasons

#define SIG_FP      16  //floating point error
#define SIG_AC      17  //alignment check error
#define SIG_MC      18  //machine check error
#define SIG_XF      19  //SIMD math error
#define SIG_USER    0x80

#define SIG_PIT     0x20
#define SIG_RTC     0x28   //rtc interrupt
#define SIG_KBD     0x21

#define SIG_BAD      0xFF     //in case of VERY strange behavior
#define EXCEPTION_SS   256      //return when exception happens

#define KERNEL_DPL  0x0
#define USER_DPL    0x3

#ifndef ASM

/* initialize the IDT with this function */
void initialize_idt(void);

/* set an interrupt gate */
void set_interrupt_gate(uint8_t n, uint32_t addr);

/* set a TRAP gate */
void set_trap_gate(uint8_t n, uint32_t addr);

/* function for handling the exception */
void handle_exception(int ivector);

/* set a system gate here */
void set_system_gate(uint8_t n, uint32_t addr);

/* tells you whaty exception is generated */
uint32_t exception_found(void);

void set_user_gate(uint8_t n, uint32_t addr);

void handle_PIT();

#endif /* ASM END */


#endif  /* IDT_H */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
OSS STUB - log your adventure here!

        * * CP 1 * *
        SAYAN: Made file
        SAYAN: added function definitions in header
        SAYAN: added system defines
        SAYAN: added husks to function sin c file


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
