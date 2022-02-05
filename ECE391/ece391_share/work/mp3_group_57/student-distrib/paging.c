#include "paging.h"
#include "lib.h"

#define TABLE_MASK   0xFFC00000
#define PAGE_MASK    0x003FF000
#define OFFSET_MASK  0x00000FFF
#define LOWER_TWELVE 0x00000FFF
#define TABLE_SIZE 1024
#define PTR_SIZE      4


#define NOT_PRESENT 0x02
#define PRESENT_PRIVILAGED 0x03
#define KERNAL_SPACE  0x00400000
#define SHELL_SPACE   0x00800000
#define FOUR_MEG_PAGE 0x00000040
#define LARGE_PAGE_SIZE 0x400000

#define VIRTUAL_VM_PTR_ONE 0x08400000 //table 33, page 0
#define VIRTUAL_VM_PTR_TWO 0x08401000 //table 33, page 1
#define VIRTUAL_VM_PTR_THREE 0x08402000 //table 33, page 2
#define FUCK 0x08403000



uint32_t page_dir[TABLE_SIZE] __attribute__((aligned (TABLE_SIZE * PTR_SIZE)));
uint32_t first_table[TABLE_SIZE] __attribute__((aligned (TABLE_SIZE * PTR_SIZE)));

uint32_t video_table[TABLE_SIZE]__attribute__((aligned(TABLE_SIZE * PTR_SIZE)));
//uint32_t _table[TABLE_SIZE]__attribute__((aligned(TABLE_SIZE * PTR_SIZE)));
uint32_t userspace_page_table[TABLE_SIZE]__attribute__((aligned(TABLE_SIZE * PTR_SIZE)));

/*
Desc: initializes paging
inputs: none
outputs: 1 on success
details: sets first page to exist

*/

int paging_init() {
  int i;
  //make whole table not present

  for (i=0; i<TABLE_SIZE; i++) {
    page_dir[i] =  0x00000002;   //set and NOT PRESENT,  YET
    first_table[i] = (i * 0x1000) | 2;    //supervisor level and read/write, still not present
	  //video_table[i] = (i * 0x1000) | 2;
     video_table[i] = 0; // Completely clears the table locations
    //kernel_table[i] |= 0x3;
  }

  //video memory
  page_dir[0] = ((unsigned int)first_table) | 3;  // Present, r/w enable
  //kernel space
  page_dir[1] = LARGE_PAGE_SIZE | 0x083; //size, present, r/w
  //shell program, set it to 4MB page, user lvl, present, r/w
  //page_dir[32] = SHELL_SPACE | 0x087;
  page_dir[33] = ((unsigned int)video_table) | 7;
  first_table[0xB8] |= 0x03;   //supervisor level, read/write, and is now present.
  first_table[0xB9] |= 0x03;  //termianl one vid space
  first_table[0xBA] |= 0x03;  //terminal two vid space
  first_table[0xBB] |= 0x03;  //termianl three vid space
  video_table[0x00]	|= 0xB8007; // B8 is the address for video memory and the 007 makes it user level, read/write, and present
  video_table[0x01] |= 0xBA007; // BA is the address for first save page and the 007 makes it user level, read/write, and present
  video_table[0x02] |= 0xBB007; // BB is the address for second save page and the 007 makes it user level, read/write, and present
  video_table[0x03] |= 0xBC007;
  load_cr3((unsigned int*)(&page_dir));
  enable_paging();


  return 1;
}
/* get_video_memory()
*     description: returns the virtual memory address for a user level VM space
*     inputs: none
*     outputs: the virtual memory address for a user level VM space
*     side effects: none
*/
uint32_t get_video_memory() {

  switch (cur_terminal) {
    case 0:
      return VIRTUAL_VM_PTR_ONE;
    case 1:
      return VIRTUAL_VM_PTR_TWO;
    case 2:
      return VIRTUAL_VM_PTR_THREE;
    default:
      while (1);
  }

}
/*
description: changes the virtual addr for user functions to proper space
             shell is places at 0x800000 and all user programs are placed
            sequentally after as 4 MB pages
inputs:     the user page to set
outputs:    none
side effects: changes the page_dir table

*/
void user_page(int current_page) {
    //change user space to point to where new process was loaded at
    //set it to 4MB, present, user space, and r/w
    page_dir[32] = (SHELL_SPACE + LARGE_PAGE_SIZE*current_page) | 0x087;

}
/*
Description: POints the yielding process's video pointer to its respective save page for buffering
Input: Cur_shell as global
Output: None
Side Effects: Previously running process will now write to its save page instead of video memory
Notes: None
*/
void vid_swap() {
    switch(cur_shell) {
        case 0:
          first_table[0xB8] = 0xB9007;  //set video mem to map to 0th save page
          break;
        case 1:
          first_table[0xB8] = 0xBA007;  //set vedeo mem to map to 1st save page
          break;
        case 2:
          first_table[0xB8] = 0xBB007; //set video mem to map to 2nd save page
          break;
    }
}
/*
Description: Set Kernal VM Mem Pointer
Input: none
output: none
Side Effects: Kernal Virtual Video Memory Pointer is 0xB8000
notes: None
*/
void reset_vid() {
    first_table[0xB8] = 0xB8007;  //reset video mem to map to physical video mem
}

/* *
 *  purge_tlb
 *
 * flushed the TLB, allowing for task state switching
 * will be used in later checkpoints
 *
 *
 * *
 */
void purge_tlb()
{
  asm volatile(
    "mov %%cr3, %%eax;"
    "mov %%eax, %%cr3;"
    :
    :
    :"%eax"
  );
}


/* *
 * map_pages()
 *
 * inputs:
 *    virtual addresss v and real address real_addr
 *
 *  basic page mapping, sets the page directory entries
 * *
 */
void map_pages(uint32_t v, uint32_t real_addr)
{
  uint32_t entry;

  entry = v / LARGE_PAGE_SIZE;

  page_dir[entry] = real_addr | 0x87;   //set user mode, r/w, page size, and is present in memory
  purge_tlb();
}

/* *
 * map_to_user()
 *
 * inputs:
 *    virtual addresss v and real address real_addr
 *
 *  outputs: none, maps the page to userspace page entries
 * *
 */
void map_to_user(uint32_t v, uint32_t real_addr)
{
  uint32_t entry;
  entry = v / LARGE_PAGE_SIZE;
  page_dir[entry] = ((unsigned int)userspace_page_table | 7);
  userspace_page_table[0] = real_addr | 7;
}

/* *
 * map_pages()
 *
 * inputs:
 *    virtual addresss v and real address real_addr
 *
 *  map a specific page at a specific locaiton here
 *
 * *
 */
void map_specific_page(uint32_t v, uint32_t real_addr, uint32_t page_to_set)
{
  uint32_t entry;
  entry = v / LARGE_PAGE_SIZE;
  page_dir[entry] = ((unsigned int)userspace_page_table | 7);
  userspace_page_table[page_to_set] = real_addr | 7;    //set a specific page here
}

void vid_mem_page_trade (unsigned prev_term, unsigned next_terminal){
  int flags;
  /*unsigned i;
  char* VidM = 0x000B8000;
  for (i=0; i<4096;i++) {
    //save memory
    (VidM + 0x1000 * (prev_term + 1))[i] = VidM[i]; //plus 1 because otherwise the 0th terminal would make this point to true Vid mem
    //make saved vid data active
    VidM[i] = (VidM + 0x1000 * (next_term + 1))[i];
  }*/
  //trade pages for updatimg
  cli_and_save(flags);
  if (prev_term > 2) {
    while(1) {
        ;
    }
  }
  video_table[prev_term] = 0x000B9007 + (0x1000 * prev_term);
  video_table[next_terminal] = 0x000B8007;
  restore_flags(flags);
}

/* *
 * map_pages()
 *
 * inputs:
 *    virtual addresss v and real address real_addr
 *
 * map to the video page table here.
 * *
 */
void map_video_table(uint32_t v, uint32_t real_addr)
{
  uint32_t entry;
  entry = v/LARGE_PAGE_SIZE;
  page_dir[entry] = ((unsigned int)video_table | 7);    //set r/w, present, usermode
  video_table[0] = real_addr | 7;
  purge_tlb();
}
