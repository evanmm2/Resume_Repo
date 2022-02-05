#ifndef HANDLERS_H
#define HANDLERS_H

#include "types.h"
#include "keyboard.h"
#include "i8259.h"


#ifndef ASM
/* find the following information in chapters 2-3 of intel magnum opus vol 3 */

extern void handle_SIG_DE(void);
extern void handle_SIG_DBG(void);
extern void handle_SIG_NMI(void);
extern void handle_SIG_BP(void);
extern void handle_SIG_BP(void);
extern void handle_SIG_OF(void);
extern void handle_SIG_BR(void);
extern void handle_SIG_UD(void);
extern void handle_SIG_NM(void);
extern void handle_SIG_DDF(void);
extern void handle_SIG_SEGO(void);
extern void handle_SIG_TSS(void);
extern void handle_SIG_NP(void);
extern void handle_SIG_SS(void);
extern void handle_SIG_GP(void);
extern void handle_SIG_PF(void);
extern void handle_SIG_FP(void);
extern void handle_SIG_AC(void);
extern void handle_SIG_MC(void);
extern void handle_SIG_XF(void);
extern void handle_SIG_BAD(void);
extern void handle_SIG_KBD();
extern void handle_SIG_USER();
extern void handle_RTC();
extern void handle_PIT();

extern void tricky(unsigned int* eip);

extern void save_kernel_esp();
extern void recover_kernel_esp();
extern void shell_call(unsigned char* shell);

int kbd_esp;
int kbd_ebp;
int pit_esp;
int pit_ebp;

int pit_eax;
int pit_ebx;
int pit_ecx;
int pit_edx;
int pit_edi;
int pit_esi;
int ebx_garbage;

#endif

#endif
