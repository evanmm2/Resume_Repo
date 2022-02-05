#ifndef PAGINGASM_H
#define PAGINGASM_H

#ifndef ASM


extern void load_cr3(unsigned int* dir_addr);
extern void enable_paging();

#endif

#endif
