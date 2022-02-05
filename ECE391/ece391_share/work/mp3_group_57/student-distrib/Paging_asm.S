#define ASM     1
#include "Paging_asm.h"

#void load_cr3(unsigned int* dir_addr)
#description: sets cr3 register to given address
#inputs: dir_addr - the address of the paging directory
#outputs: none
#side_effects: gives cr3 the address of paging dir  
.global load_cr3
.type load_cr3, @function
load_cr3:
  pushl %ebp
  movl %esp, %ebp
  pushl %eax
  movl 8(%ebp), %eax
  movl %eax, %cr3
  popl %eax
  leave
  ret

#void enable_paging()
#description: sets control registers to enable paging
#inputs: none
#outputs: none
#side_effects: enables paging
.global enable_paging
.type enable_paging, @function
enable_paging:
  pushl %ebp
  movl %esp, %ebp
  pushl %eax

  #set paging size to 4kb
  movl %cr4, %eax
  orl $0x00000010, %eax
  movl %eax, %cr4

  #enable paging on top bit of cr0
  movl %cr0, %eax
  orl $0x80000001, %eax
  movl %eax, %cr0


  popl %eax
  leave
  ret
