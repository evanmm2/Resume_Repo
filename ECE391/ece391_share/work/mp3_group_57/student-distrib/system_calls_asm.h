#ifndef SYSASM_H
#define SYSASM_H

#ifndef ASM

#include "x86_desc.h"


extern void halt_return(int* pcb_block, unsigned int* eip);
extern void swap_stack(int stack_pcb);
extern void update_tss();
extern void pop_esp();
extern void process_return(int esp, int ebp);

#endif

#endif
