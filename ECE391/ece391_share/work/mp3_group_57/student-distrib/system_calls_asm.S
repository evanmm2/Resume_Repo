#define ASM     1

#include "system_calls_asm.h"


#void stack_swap(int stack_pcb)
#description: switches stack to given value
#inputs: stack_pcb: the esp value to swap to
#side effects - changes the stack
.global swap_stack
.type swap_stack, @function
swap_stack:

  #pop return address
  movl (%esp), %ecx

  #pop argument
  movl 4(%esp), %eax

  #swap stacks
  movl %eax, %esp

  #push back arg and return value so c can pop them
  pushl %eax
  pushl %ecx
  ret

#void update_tss()
#description: moves the current esp into esp0 of the tss
#inputs: none
#side effects - changes tss.esp0 to the current esp
.global update_tss
.type update_tss, @function
update_tss:

  movl %esp, %eax
  addl $4, %eax
  movl %eax, tss + 4

  ret

#void pop_ebp()
#description: asm function that pops one value off the stack
#inputs: none
#side effects - pops a value off the stack
.global pop_esp
.type pop_esp, @function
pop_esp:

    popl %eax
    addl $4, %esp
    pushl %eax
    ret


#void process_return(int esp, int ebp)
#description: asm function that task_swaps to a process
#inputs: esp - the stack pointer that contains the iret info
#        ebp - the base pointer for the function we are returning to
#side effects - irets into a different process
.global process_return
.type process_return, @function
process_return:
    addl $4, %esp
    popl %ebp
    popl %esp
    pushl %eax
    movl 12(%esp), %eax
    orl $0x200, %eax
    movl %eax, 12(%esp)
    popl %eax
    #restore regs
    movl pit_eax, %eax
    movl pit_ebx, %ebx
    movl pit_ecx, %ecx
    movl pit_edx, %edx
    movl pit_esi, %esi
    movl pit_edi, %edi
    iret
