#include "system_calls.h"


// Current process bookkeeping
static dentry_t file;
//the number of processes currently running
static int num_process;



//text driver
//file specific drivers
// Put the file_op templates in order of their file types
static file_op_ptr_t std_in;           // These structs are used to hold the function pointer data per file type
static file_op_ptr_t std_out;
static file_op_ptr_t RTC_ops;
static file_op_ptr_t dir_ops;
static file_op_ptr_t txt_ops;

/*description: populates the std in/out driver with relevant functions
  inputs: none
  output: text_ops populated
  side effects: none
*/
void init_std_driver () {
  std_in.spec_read  = &terminal_read;          // For all these similar functions, this syntax sets the variable function pointers
  std_in.spec_write = NULL;
  std_in.spec_open  = NULL;
  std_in.spec_close = NULL;

  std_out.spec_read  = NULL;          // For all these similar functions, this syntax sets the variable function pointers
  std_out.spec_write = &terminal_write;
  std_out.spec_open  = NULL;
  std_out.spec_close = NULL;
}
/*description: populates the RTC driver with relevant functions
  inputs: none
  output: text_ops populated
  side effects: none
*/
void init_RTC_driver () {
  RTC_ops.spec_read  = &read_RTC;
  RTC_ops.spec_write = &write_RTC;
  RTC_ops.spec_open  = &open_RTC;
  RTC_ops.spec_close = &close_RTC;
}
/*description: populates the directory driver with relevant functions
  inputs: none
  output: text_ops populated
  side effects: none
*/
void init_dir_driver () {
  dir_ops.spec_read  = &dir_read;
  dir_ops.spec_write = &dir_write;
  dir_ops.spec_open  = &dir_open;
  dir_ops.spec_close = &dir_close;
}
/*description: populates the text driver with relevant functions
  inputs: none
  output: text_ops populated
  side effects: none
*/
void init_txt_driver () {
  txt_ops.spec_read  = &file_read;
  txt_ops.spec_write = &file_write;
  txt_ops.spec_open  = &file_open;
  txt_ops.spec_close = &file_close;
}
//end_txt_driver


/*description: Initializes all driver structs and allocates space for the PCBs
  inputs: none
  outputs: none
  side_effects: initializes the drivers
*/
void init_all_drivers () {
  init_std_driver();        // These initlize the drivers
  init_RTC_driver();
  init_dir_driver();
  init_txt_driver();
  init_STD();
  cur_process = 0;
  //have to be able to open up three shells always
  num_process = 2;
  int i;
  for(i = 0; i < MAX_PROCESSES; i++)
      user_page_array[i] = 0;

  //set each shell to not present
  shell_present[0] = 0;
  shell_present[1] = 0;
  shell_present[2] = 0;

  //set first thread to position 0 b/c thats where the first shell opens
  thread_position[0] = 0;
  //put the other threads to uninit state
  thread_position[1] = -1;
  thread_position[2] = -1;

  //same as thread_position
  shell_position[0] = 0;
  shell_position[1] = -1;
  shell_position[2] = -1;

}

/*description: clears the specified file descriptor
 *input: i: the index to clean
 *output: none
 *side_effects: a clear file descriptor at i
 */
void zero_file_data(int i) {
//  cur_process_files[i].file_op_ptr = NULL;
  cur_process_files[i].inode = 0;
  cur_process_files[i].file_position = 0;
  cur_process_files[i].flags = 0;
  cur_process_files[i].file_type = 0;
}

/* Description: initialize all of the file locations to be unused
 * inputs: none
 * outputs: a clear file array
 * side effects: none
*/
int init_process_data () {
  int i;
  for (i = 0; i<NUM_PROCESS_FILES; i++) {
    zero_file_data(i);
  }
  return 0;
}
/*  init_STD:
*       DESCRIPTION: Sets up the STD drivers for FD locations 0 and 1
*       INPUTS: None
*       OUTPUTS: None
*       SIDE EFFECTS: STD file descriptors initialized for the process
*/

void init_STD() {
    cur_process_files[0].file_op_ptr = std_in;
    cur_process_files[0].inode = 0;
    cur_process_files[0].file_position = 0;
    cur_process_files[0].flags = 1;
    cur_process_files[0].file_type = 0;

    cur_process_files[1].file_op_ptr = std_out;
    cur_process_files[1].inode = 0;
    cur_process_files[1].file_position = 0;
    cur_process_files[1].flags = 1;
    cur_process_files[1].file_type = 0;
}

/* * * * *
 * int halt() - halt a process
 *
 * params: an unsigned character for status
 * outputs: an integer based on whether or not the program could be halted.
 *
 * side effects: halts the current process and will return to the shell afterwards.
 * */
int halt(unsigned char status) {

    cli();
    //if they try to halt one of the base shells, restart it, DO NOT HALT IT
    if(shell_position[0] == cur_process || shell_position[1] == cur_process || shell_position[2] == cur_process) {
          user_page_array[cur_process] = 0;
          shell_setup(cur_shell);
    }
    //remove a process
    num_process--;
    //clear the user page the cur process is on
    user_page_array[cur_process] = 0;
    //set the cur process to the process we are halting's parent
    pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
    cur_process = pcb_addr->parent_PID;

    //update the thread position of this terminal to the process we return to
    thread_position[cur_shell] = cur_process;
    //get the pcb for process we are returning to
    pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
    //now that we have parent process, switch back to it
    frequency_RTC(pcb_addr->RTC_freq);
    user_page(cur_process);
    purge_tlb();                            // Flushes the TLB
    tss.esp0 = pcb_addr->esp0;
    tss.ss0 = KERNEL_DS;                  // Sets the segment selector

    //reset the cur files to the process we are ret to
    int i;
    for(i = 0; i < NUM_PROCESS_FILES; i++) {  // Copies over the necessary files
        cur_process_files[i] = pcb_addr->process_files[i];
    }

    return 0;
}

/* * * * *
 *  int execute() - execute a process, most of our functionality is here
 *
 *  params: an unsigned character array to a command
 *  outputs: if the process can be executed, the process will be executed.
 *  returns an integer at the end.
 *
 *  side effects: will return an integer after execution.
 * */
int execute(const unsigned char* command) {
    cli();
    //check if the argument is null
    if(command == NULL)
        return -1;
    //check if we have room to run more processes
    if(num_process == MAX_PROCESSES - 1)
      return -1;

	  int h = strlen(command);
	  unsigned char whut[h];
	  cpy_string(whut, command);
    //initialize the command_file to prevent dereferencing null
    dentry_t command_file;
    unsigned char magic_number[FOURBYTES];
	  unsigned char file_to_dentry[80]; // Made file_to_dentry and arbitrary size because I didn't want to do math. True max should be 32 I think
	  cpy_to_space(file_to_dentry, command);
    if(read_dentry_by_name(file_to_dentry, &command_file) == -1)
        return -1;

    //try to read first 4 bytes, which tell us if its executable
    //set offset to 0
    if(read_data(command_file.inode_number, 0, magic_number, FOURBYTES) == -1)
    {
      return -1;
    }
   //check if the file is executable
   // The magic numbers are the fence magic numbers of an executable file
    if(magic_number[0] != 0x7f || magic_number[1] != 0x45 || magic_number[2] != 0x4c || magic_number[3] != 0x46)
    {
      return -1;
    }
    //look for where to put the new process
    int new_process = 0;
    for(new_process = 0; new_process < MAX_PROCESSES; new_process++) {
        if(user_page_array[new_process] == 0)
            break;
    }
    //set the enentry in the array to present
    user_page_array[new_process] = 1;
    //change the page_dir to new process
    user_page(new_process);
    purge_tlb();
    thread_position[cur_shell] = new_process;

    //copy the exe file to physical memory
    if(copy_to_user(command_file.inode_number, (unsigned char*)LOAD_USER_ADDR) == -1)
    {
      return -1;
    }
    unsigned int* eip_addr = (unsigned int*)(*((unsigned int*)EIP_ADDR));

    tss.ss0 = KERNEL_DS;            // Sets the ss to the kernel data segment
    int stack_pcb = (EIGHT_MB - (new_process)*EIGHT_KB - FOURBYTES - TWO_KB);        // Gets the current PCB stack location

    pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (new_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET); // Gets the actual current PCB
    pcb_t* parent_pcb = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
    pcb_addr->RTC_freq = SPEED_0;

    int x;
	cpy_after_space(pcb_addr->argument, whut);
    pcb_addr->PID           = new_process;     // It's Process ID is it's parents + 1
    pcb_addr->parent_PID    = cur_process;         // it's parent's ID is the preincremented process number

    parent_pcb->esp0 = tss.esp0;

    for(x = 0; x < NUM_PROCESS_FILES; x++)
    {           //save the current process files in the current process pcb
        parent_pcb->process_files[x] = cur_process_files[x];
    }
	for(x = 2; x < NUM_PROCESS_FILES; x++)
    {           // Copies over the files, so that the child can know what it's parent processes are
        zero_file_data(x);
    }

    cur_process = new_process;
    int parent_ESP0 = 0;
    //set esp0 to the current_process's kernel stack
    update_tss();

    parent_ESP0 = tss.esp0;

    num_process++;

    swap_stack(stack_pcb);      // Stack swap for the context swap to the new user program
    tricky(eip_addr);           // iret to ring 3
    swap_stack(parent_ESP0);    // Swap the stack back because we are now back in the previous program
    pop_esp();                  // There was an extra local variable that  needed to be popped
    return 0;
}



/* * * * *
 * int read()
 *      description: the general read that uses the file op table to read the file
 *      inputs: fd - the file to read
 *              buf - the buffer to read into
 *              nbytes - the number of bytes to read
 *      outputs: none
 *      side effects: fills the buffer with the data to read based on the file type
 *
 * */
int read(int fd, void* buf, int nbytes)
{
  //can't read from a null buf
  //int flags;
  //cli_and_save(flags);
  if(buf == NULL || fd < 0 || fd > NUM_PROCESS_FILES || fd == 1)
  {
      return -1;
  }

  if((unsigned)buf < VM_USER_PAGE || (unsigned)buf >= END_OF_VM_USER_PAGE)  // Checks if the pointer is to an invalid VM page
      return -1;

  if(cur_process_files[fd].flags == 0)
  {
	  return -1;
  }

  //cannot read from stdout
  if(fd == 1)
  {
	  return -1;
  }
    //restore_flags(flags);
  return cur_process_files[fd].file_op_ptr.spec_read(fd, buf, nbytes);
}

/* * * * *
 *   int write()
 *      description: write depending on the file type
 *      inputs: fd - the file descriptor
                buf- the buffer to write to
                nbytes - the number of bytes to write
 *      outputs: depends on the file type, but usually the number of bytes successfully written
 *      side effects: Writes whatever is in the buffer to the specified file based on it's type
 *
 *
 * */
int write(int fd, const void* buf, int nbytes)
 {
    int flags;
    cli_and_save(flags);
    //can't write to a null buf
    if(buf == NULL || fd < 1 || fd > NUM_PROCESS_FILES)
    {
        return -1;

    if((unsigned)buf < VM_USER_PAGE || (unsigned)buf >= END_OF_VM_USER_PAGE)  // Checks if the pointer is to an invalid VM page
          return -1;

    }

	if(cur_process_files[fd].flags == 0)
  {
		return -1;
  }
	//cannot write to stdin
	if(fd == 0)
  {
		return -1;
  }
    restore_flags(flags);
    return cur_process_files[fd].file_op_ptr.spec_write(fd, buf, nbytes);

}

/* * * * *
 * int open()
 * description: opens up a file type
 * params: the string for a file
 *
 * outputs: an integer based on whether or not the file was able to be opened
 * side effects: opens up a file descriptor
 * */
int open(const unsigned char* filename)
{
  int flags;
  cli_and_save(flags);
  //check for bad argument
  if(filename == NULL)
  {
      return -1;
  }
  if (-1 == read_dentry_by_name(filename, &file))
  {
    return -1;
  }


  if((unsigned)filename < VM_USER_PAGE || (unsigned)filename >= END_OF_VM_USER_PAGE)  // Checks if the pointer is to an invalid VM page
      return -1;

  if (-1 == read_dentry_by_name(filename, &file)) {return -1;}

  int i;
  //start from 2 because stdin and out are reserved
  for (i = 2; i<NUM_PROCESS_FILES; i++)
  {
    if (cur_process_files[i].flags == 0)
    {
      break;
    }
  }
  //if everything is occupied, return -1
  if (i == NUM_PROCESS_FILES)
  {
    return -1;
  }
  //different interpretations of file types...
  //default for now .txt
  switch (file.file_type)
  {
    //TO DO (if there are other file type xD)
    //assume everything is .txt
    default:
      cur_process_files[i].file_op_ptr = txt_ops;
      break;
  }
  cur_process_files[i].inode = file.inode_number;
  cur_process_files[i].file_position = 0;
  cur_process_files[i].flags = 1; //100% sure this is not the convention for flags but it will do for now #CATCH
  cur_process_files[i].file_type = file.file_type;
  if(cur_process_files[i].file_type == 0) //0 is RTC type of file
  {
    cur_process_files[i].file_op_ptr = RTC_ops;
  }
  else if(cur_process_files[i].file_type == 1) //1 is a dir type of file
  {
    cur_process_files[i].file_op_ptr = dir_ops;
  }
  else if(cur_process_files[i].file_type == 2)
  {
    cur_process_files[i].file_op_ptr = txt_ops;
  }  //2 is a txt type of file
  else
  {
    return -1;
  }

  cur_process_files[i].file_op_ptr.spec_open(filename);
  restore_flags(flags);
  return i;
}

/* * * * *
 *  int close()
 *  description: closest the specified file descriptor
 *  params: an integer file descriptor
 *  outputs: an integer based on whether or not the file was closed
 *  side effects: closes the file descriptor
 *
 * */
int close(int fd)
{
	  //cannot close stin and stout
    int flags;
    cli_and_save(flags);
    //cannot close std in or std out
    if(fd < 2 || fd > NUM_PROCESS_FILES){return -1;}
	  if(cur_process_files[fd].flags == 0)
	  return -1;

    cur_process_files[fd].file_op_ptr.spec_close(fd);
    zero_file_data(fd);
    restore_flags(flags);
    return 0;
}
/* copy_to_user(int fd, unsigned char* target_addr)
*       description:    copies a file to a page
*       inputs:         fd  - the file descriptor to copy
*                       target_addr - the target address to copy to in memory
*       outputs:    a positive number for successs, -1 for failure
*       side effects: copies the file data to it's specified memory location
*/
int copy_to_user(int inode, unsigned char* target_addr)
{
    //get the size of the file
    int file_size = num_bytes(inode);
    //attempt to copy entire fill into its space in memory.
    //return -1 upon failure, positive number on success
    return read_data(inode, 0, target_addr, file_size);
}


/* getargs(unsigned char* buf, int32_t nbytes)
*     description: Gets the argument from the PCB and puts it into a user level buffer
*     inputs: unsigned char* buf - buffer to copy into
              int32_t nbytes     - byte size of buffer
*     outputs: 0 for success, -1 for failure
*     side effects: fills in user level buffer with argument
*/
int getargs(unsigned char* buf, int32_t nbytes){	// We've got to find the correct PCB to pull data from. buf is the userspace buffer to copy to. nbytes is the size of that buffer.
//check if the argument is null
if(buf == NULL)
    return -1;

if((unsigned)buf < VM_USER_PAGE || (unsigned)buf >= END_OF_VM_USER_PAGE)  // Checks if the pointer is to an invalid VM page
    return -1;

  //the current process pcb holds its arguments
  pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
  if(strlen(pcb_addr->argument) > nbytes)		// If the number of characters in the buffer is greater than the size of the user buffer, then it can't fit
		return -1;
	if(pcb_addr->argument[0] == NULL)			// If the argument space is null, just leave
		return -1;

	cpy_string(buf, pcb_addr->argument); 		// Copy the string over because it is valid
	return 0;
}

/* vidmap(uint8_t** screen_start)
*     description: passes a pointer to the start of video memory into the double pointer
*     inputs:      screen_start - pointer in which to pass back a pointer to video memory
*     outputs:     0 for success, -1 for failure
*     side effects: fills in screen_start pointer with the virtual memory pointer
*/
int vidmap(uint8_t** screen_start){
  if (screen_start == 0)    // Checks if screen start is NULL
      return -1;

  if((unsigned)screen_start < VM_USER_PAGE || (unsigned)screen_start >= END_OF_VM_USER_PAGE)  // Checks if the pointer is to an invalid VM page
      return -1;

	*screen_start = (uint8_t*)get_video_memory();      // Fills in VM pointer
	return 0;     // Return 0 for success
}
/* set_handler()
*     description: nothing
*     input: nothing
*     output: -1 for failure due to no sigs having handlers
*     side effects: none
*/
int set_handler(){
  return -1;
}
/* sigreturn()
*     description: nothing
*     input: nothing
*     output: -1 for failure due to no sigs having handlers
*     side effects: none
*/
int sigreturn(){
  return -1;
}

/*
shell_setup
description: Initilizes one of the three base shells
inputs: shell_number - The shell we are setting up
outputs: none
side_effects: Initilizes one of the base shells and hands execution to it 
*/
void shell_setup(int shell_number) {
    //execute will increment num_process, so decrement it here
    cli();
    num_process--;
    int i, j;
    //look for where the shell can go
    for(j = 0; j < MAX_PROCESSES; j++) {
        if(user_page_array[j] == 0)
            break;
    }
    //save cur process's video memory
    reset_vid();
    purge_tlb();
    switch(cur_terminal) {
      case 0:
      for(i = 0; i < FOUR_KB; i++)
          *(unsigned int*)(SAVE_PAGE_A + i) = *(unsigned int*)(VIDEO + i);
      break;

      case 1:
      for(i = 0; i < FOUR_KB; i++)
          *(unsigned int*)(SAVE_PAGE_B + i) = *(unsigned int*)(VIDEO + i);
      break;

      case 2:
      for(i = 0; i < FOUR_KB; i++)
          *(unsigned int*)(SAVE_PAGE_C + i) = *(unsigned int*)(VIDEO + i);
      break;
    }
    //save the screenx and screeny
    save_screen_location(cur_shell);
    //reset the screen for new shell
    reset_screen();

    //set where this shell was placed, and the new shell is the current thread
    shell_position[shell_number] = j;
    thread_position[shell_number] = j;
    //set shell to present
    shell_present[shell_number] = 1;
    //get the pcb of the cur process to save its task swap info
    pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
    //save the task switching info
    pcb_addr->esp = kbd_esp;
    pcb_addr->ebp = kbd_ebp;
    vid_mem_page_trade(cur_terminal, shell_number);

    purge_tlb();

    cur_terminal = shell_number;

    cur_shell = cur_terminal;

    move_cursor();
    //execute shell
    //NOTE: execute does the pcb set up for the new shell, so don't panic that it isnt' here
    execute((unsigned char*)"shell");

}
/*
task_swap
description: swaps task upon a keyboard switch i.e. F1, F2, F3
inputs: shell_number - the shell we want to switch to
outputs: none
side_effects: changes the current shell displayed to screen and switches to process
              running in shell_number
*/
void task_swap(int shell_number) {

  //get the current pcb
  pcb_t* pcb_addr = (pcb_t*)(EIGHT_MB - (cur_process)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
  //save the task returning info
  pcb_addr->esp = kbd_esp;
  pcb_addr->ebp = kbd_ebp;
  //save the esp0 for this task, this is where we want to go for halt
  pcb_addr->esp0 = tss.esp0;

  int i;
  //save current files
  for(i = 0; i < NUM_PROCESS_FILES; i++)
      pcb_addr->process_files[i] = cur_process_files[i];

  //save cur process's video memory
  reset_vid();
  purge_tlb();
  switch(cur_terminal) {
    case 0:
    for(i = 0; i < FOUR_KB; i++)
        *(unsigned int*)(SAVE_PAGE_A + i) = *(unsigned int*)(VIDEO + i);
    break;

    case 1:
    for(i = 0; i < FOUR_KB; i++)
        *(unsigned int*)(SAVE_PAGE_B + i) = *(unsigned int*)(VIDEO + i);
    break;

    case 2:
    for(i = 0; i < FOUR_KB; i++)
        *(unsigned int*)(SAVE_PAGE_C + i) = *(unsigned int*)(VIDEO + i);
    break;
  }

  //save the screenx and screeny
  save_screen_location(cur_shell);

  //this is process ID to return to
  int process_ret = thread_position[shell_number];
  //get the pcb for the process_ret
  pcb_addr = (pcb_t*)(EIGHT_MB - (process_ret)*(EIGHT_KB) - FOURBYTES - PCB_OFFSET);
  frequency_RTC(pcb_addr->RTC_freq);
  //update process files for process we are switching to
  for(i = 0; i < NUM_PROCESS_FILES; i++)
      cur_process_files[i] = pcb_addr->process_files[i];

  //switch cur_terminal to shell we are switching to
  int previous_terminal = cur_terminal;
  cur_terminal = shell_number;
  cur_shell = shell_number;
  //update cur process with the active thread of shell_number
  cur_process = thread_position[shell_number];
  //change the page dir
  user_page(process_ret);
  purge_tlb();
  //change the tss to the process_ret saved esp0
  tss.esp0 = pcb_addr->esp0;
  //switch the stacks and iret

  //change the video memory to the saved video memory
  switch(cur_terminal) {
    case 0:
    for(i = 0; i < FOUR_KB; i++)
        *(unsigned int*)(VIDEO + i) = *(unsigned int*)(SAVE_PAGE_A + i);
    break;

    case 1:
    for(i = 0; i < FOUR_KB; i++)
        *(unsigned int*)(VIDEO + i) = *(unsigned int*)(SAVE_PAGE_B + i);
    break;

    case 2:
    for(i = 0; i < FOUR_KB; i++)
        *(unsigned int*)(VIDEO + i) = *(unsigned int*)(SAVE_PAGE_C + i);
    break;
  }

  vid_mem_page_trade(previous_terminal, shell_number);


  purge_tlb();
  //update screen x and screen y with their saved positon
  update_screen(cur_terminal);
  move_cursor();

  //return to the this stack and iret to processs saved on said stack
  process_return(pcb_addr->ebp, pcb_addr->esp);

}
