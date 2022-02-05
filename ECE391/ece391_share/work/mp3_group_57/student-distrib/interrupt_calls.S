#define ASM 1

#include "idt.h"
#include "interrupt_calls.h"
#include "i8259.h"
#include "x86_desc.h"
#include "RTC.h"
#include "system_calls.h"
#include "system_calls_asm.h"

process_return:
.long

.global handle_SIG_DE
.type handle_SIG_DE, @function
handle_SIG_DE:
    pushal
    pushl $SIG_DE
    call handle_exception
    addl $4, %esp
    popal
    iret

    .global handle_SIG_KBD
    .type handle_SIG_KBD, @function
    handle_SIG_KBD:
    #save the ebp

    pushl %ebp
    popl kbd_ebp

    pushl %eax

    #save esp
    movl %esp, %eax
    addl $4, %eax
    pushl %eax
    popl kbd_esp

    popl %eax

        pushal
        call handle_keyboard_sig
        popal
        iret

        .global handle_RTC
        .type handle_RTC, @function
        handle_RTC:
            pushal
            call handle_sig_RTC
            popal
            iret


.global handle_SIG_DBG
.type handle_SIG_DBG, @function
handle_SIG_DBG:
    pushal
    pushl $SIG_DBG
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_NMI
.type handle_SIG_NMI, @function
handle_SIG_NMI:
    pushal
    pushl $SIG_NMI
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_BP
.type handle_SIG_BP, @function
handle_SIG_BP:
    pushal
    pushl $SIG_BP
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_OF
.type handle_SIG_OF, @function
handle_SIG_OF:
    pushal
    pushl $SIG_OF
    call handle_exception
    addl $4, %esp
    popal
    iret


.global handle_SIG_BR
.type handle_SIG_BR, @function
handle_SIG_BR:
    pushal
    pushl $SIG_BR
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_UD
.type handle_SIG_UD, @function
handle_SIG_UD:
    pushal
    pushl $SIG_UD
    call handle_exception
    addl $4, %esp
    popal
    iret


.global handle_SIG_NM
.type handle_SIG_NM, @function
handle_SIG_NM:
    pushal
    pushl $SIG_NM
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_BAD
.type handle_SIG_BAD, @function
handle_SIG_BAD:
    pushal
    pushl $SIG_BAD
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_DDF
.type handle_SIG_DDF, @function
handle_SIG_DDF:
    pushal
    pushl $SIG_DDF
    call handle_exception
    addl $4, %esp
    popal
    iret


.global handle_SIG_SEGO
.type handle_SIG_SEGO, @function
handle_SIG_SEGO:
    pushal
    pushl $SIG_SEGO
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_TSS
.type handle_SIG_TSS, @function
handle_SIG_TSS:
    pushal
    pushl $SIG_TSS
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_NP
.type handle_SIG_NP, @function
handle_SIG_NP:
    pushal
    pushl $SIG_NP
    call handle_exception
    addl $4, %esp
    popal
    iret


.global handle_SIG_SS
.type handle_SIG_SS, @function
handle_SIG_SS:
    pushal
    pushl $SIG_SS
    call handle_exception
    addl $4, %esp
    popal
    iret


.global handle_SIG_GP
.type handle_SIG_GP, @function
handle_SIG_GP:
    pushal
    pushfl
    pushl $SIG_GP
    call handle_exception
    addl $4, %esp
    popfl
    popal
    iret


.global handle_SIG_PF
.type handle_SIG_PF, @function
handle_SIG_PF:
    pushal
    pushl $SIG_PF
    call handle_exception
    addl $4, %esp
    popal
    iret



.global handle_SIG_FP
.type handle_SIG_FP, @function
handle_SIG_FP:
    pushal
    pushl $SIG_FP
    call handle_exception
    addl $4, %esp
    popal
    iret


.global handle_SIG_AC
.type handle_SIG_AC, @function
handle_SIG_AC:
    pushal
    pushl $SIG_AC
    call handle_exception
    addl $4, %esp
    popal
    iret


.global handle_SIG_MC
.type handle_SIG_MC, @function
handle_SIG_MC:
    pushal
    pushl $SIG_MC
    call handle_exception
    addl $4, %esp
    popal
    iret

.global handle_SIG_XF
.type handle_SIG_XF, @function
handle_SIG_XF:
    pushal
    pushl $SIG_XF
    call handle_exception
    addl $4, %esp
    popal
    iret

#handle_SIG_USER
#inputs: register eax holds which sytem call function, registers ebx, ecx, and
#        edx hold the arguments
#outputs: value 0-255 from halt, or -1 for faliure
#side_effects: changes control to user program

# aligns the jump table used for jumping between user signal commands
.align 4
user_jump_table:
  .long halt, execute, read, write, open, close, getargs, vidmap, set_handler, sigreturn

.global handle_SIG_USER
handle_SIG_USER:
  #save some regs
  cli
  #pushf
  pushl %esi
  pushl %edi

  #check if the requested function exists, only 10 exist
  cmp $10, %eax
  ja BAD_USER_SIG
  cmp $0, %eax
  jbe BAD_USER_SIG
  #jump to asm function that will set up call to C function
  subl $1, %eax

  #we might be halting, we have to return ret back to execute
  movl $0, halt_flag
  cmp $0, %eax
  jne halt_skip
  movl $1, halt_flag

halt_skip:

  #push the arguments
  pushl %edx
  pushl %ecx
  pushl %ebx
  movl user_jump_table(, %eax, 4), %eax
  sti
  call *%eax

  #pop arguments
  cli
  addl $12, %esp
  jmp USER_RET



#return failure
BAD_USER_SIG:
  popl %edi
  popl %esi
  #popf
  movl $-1, %eax
  iret



#pop callee saved regs back
USER_RET:
  popl %edi
  popl %esi
  #popf

  #do fancy halt return if halt flag set
  cmp $1, halt_flag
  je halt_return

#update the values of data segment
halt_fail:

  movl $0x002b, %ebx
  movw %bx, %ds
  movw %bx, %es
  movw %bx, %fs
  movw %bx, %gs
#stack is set up so just iret
#iret will sti for us
  iret

halt_return:

#reset the flag
  movl $0, halt_flag
#go back to tricky to return from execute
  cmp $-1, %eax
  je halt_fail

  jmp hacki


#void tricky(unsigned int* eip_addr)
#inputs: The user eip value to start execution at
#outputs: none
#side effects: irets into a user program
.global tricky
.type tricky, @function
tricky:
  cli
  movl (%esp), %eax
  movl %eax, process_return
  #save value of return from trick here
  movl %esp, tss + 4

  #update the values of data segment
  movl %ebx, ebx_garbage
  movl $0x002b, %eax
  movw %ax, %ds
  movw %ax, %es
  movw %ax, %fs
  movw %ax, %gs

  #push the data segment on stack
  pushl %eax

  #push the esp value for the function
  pushl $0x83FFFF0

  #push the flags, change to enalbe interrupts for user
  pushfl
  popl %eax
  orl $0x4200, %eax
  pushl %eax

  #put user code segment on stack
  pushl $0x0023

  #put the value of eip onto stack
  movl 20(%esp), %eax
  pushl %eax
  movl ebx_garbage, %ebx
  iret
  #this is where we want jump to from halt
  hacki:
    #pop halt iret stuff because we are not returing there
    addl $20, %esp
    ret


      .global handle_PIT
      .type handle_PIT, @function
      handle_PIT:
          #save the ebp


          movl %ebp, pit_ebp
          #save reg
          movl %eax, pit_eax
          movl %ebx, pit_ebx
          movl %ecx, pit_ecx
          movl %edx, pit_edx
          movl %edi, pit_edi
          movl %esi, pit_esi

          pushl %eax

          #save esp
          movl %esp, %eax
          addl $4, %eax
          pushl %eax
          popl pit_esp

          popl %eax


          call scheduler_switch


          iret

.align 4
halt_flag:
    .long
