#ifndef PAGING_H
#define PAGING_H


#define USER_SPACE    0x01200000
#define VIDEO_SPACE	  0x01600000
#define VM_USER_PAGE 0x8000000
#define END_OF_VM_USER_PAGE 0x8400000

#define SAVE_PAGE_A 0XB9000 //page after true VIDIO with flags
#define SAVE_PAGE_B 0xBA000
#define SAVE_PAGE_C 0xBB000

#ifndef ASM

#include "lib.h"
#include "Paging_asm.h"
#include "system_calls.h"
#include "terminal.h"

int paging_init();
void map_pages(uint32_t v, uint32_t real_addr);
void map_to_user(uint32_t v, uint32_t real_addr);
void map_specific_page(uint32_t v, uint32_t real_addr, uint32_t page_to_set);
void map_video_table(uint32_t v, uint32_t real_addr);
void user_page(int current_page);
void purge_tlb();
uint32_t get_video_memory();
void vid_mem_page_trade (unsigned prev_term, unsigned next_terminal);
void vid_swap();
void reset_vid();


#endif

#endif
