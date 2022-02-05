#include "file_system.h"

/* Description: reads nbytes of the file at index fd into buf, starting where it left off
   inputs: fd-the index to read from: nbytes-the number of bytes to read: buf- the buffer to read to
   outputs: the buf filled with nbytes of the file at fd and the file position advanced by nbytes | 0 on success -1 otherwise
   side effects: changes the buffer to have the data from the file
*/
int32_t file_read(int32_t fd, void* buf, int32_t nbytes) {
  if (cur_process_files[fd].flags == 0) {return -1;}  //if the file doesn't exist
  //read_data doesn't perform checks so don't rely on this check EVER
  //read the data into the buffer
  int x;
  if (-1 == (x = read_data(cur_process_files[fd].inode, cur_process_files[fd].file_position, (unsigned char *) buf, nbytes))) {return -1;}
  //use that files read interpreter
  //cur_process_files[fd].file_op_ptr.spec_read(fd,buf,nbytes);
  //advance the position
  cur_process_files[fd].file_position += x;
  return x;
}



/*Description: zeros out the file in the file accesss array which is equivilent to closing it
 *input : the index to close
 *output: 0 for succcess
 *side effects: that file and index closed
*/
int32_t file_close(int32_t fd) {
  if (cur_process_files[fd].flags == 0) {return -1;} // Sets the file location as empty for this process
  zero_file_data(fd);
  return 0;
}



//to do
/*description: writes the buf to the current position of the file to write to
 *input: @fd the index to write to, @buf the buf to write, @nbytes the number of bytes that that is
 *output: the file is updated and 0 is returned on success -1 on failure
 *side_effects: none
*/
int32_t file_write(int32_t fd, const void* buf, int32_t nbytes) {
  return -1;
}


/*Description: opens the file by its name and prepares it for reading
 *input @filename the null terminated file name to read
 *output an initialized descriptor for that file in the access array
 *side effects: none
*/
int32_t file_open(const uint8_t* filename) {

  return 0;
}


/* read_dentry_by_name
*   DESCRIPTION: Finds the file name in the bootblock and gets the necessary data associated with it into dentry
*   INPUT: fname - the name of the file to search for. It's a null terminated string
           dentry - the data entry to populate for use by other functions
*   OUTPUT: 0 if the file is found. -1 if the file isn't
*   SIDE EFFECTS: Populates the dentry with the necessary data
*
*/

int read_dentry_by_name(const unsigned char* fname, dentry_t* dentry) {
    int i;
    /*int is_equal;
    if (strlen(fname) == 32) {
      for(i = 0; i < (*bootblock_addr); i++){
        is_equal = 1;
        for (j = 0; j<32; j++) {
          if ((unsigned char*)((bootblock_addr + OFFSET_64*(i+1)))[j] != fname[j]) {
            is_equal = 0;
            break;
          }
        }
        if (is_equal) {
            for (j = 0; j<32; j++) {
              dentry->file_name[j] = fname[j];
            }
            int* file = bootblock_addr;
            dentry->file_type =  *(file + 16*(i+1) + 8);
            dentry->inode_number = *(file + 16*(i+1) + 9);
            dentry->data_blocks  = *(bootblock_addr + OFFSET_INODE*(dentry->inode_number + 1));
            return 0;
        }
      }
    } */
	unsigned char* temp = (unsigned char*)"temp";

    for(i = 0; i < (*bootblock_addr); i++){
		cpy_string(temp, (unsigned char*)(bootblock_addr + OFFSET_64*(i+1)));
		temp[32] = '\0';
      if(cmp_string(temp, fname) == 0){ // The 1s in the following if statement are used to skip past the initial boot data
            // In this if statement, the file name is confirmed and the data is being populated into the dentry struct
          cpy_string(dentry->file_name, fname);
          int* file = bootblock_addr;
          dentry->file_type =  *(file + OFFSET_64*(i+1) + OFFSET_32);     // location of the file_type
          dentry->inode_number = *(file + OFFSET_64*(i+1) + OFFSET_32 + OFFSET_4);  // Location of the inode number
          dentry->data_blocks  = *(bootblock_addr + OFFSET_INODE*(dentry->inode_number + OFFSET_4));  // Locations of the number of data blocks to cycle through
          return 0;
      }
    }
    return -1;
}

/* read_dentry_by_index
*   DESCRIPTION: Supposed to find the data entry by the index provided
*   INPUTS: index - which dentry to find
*           dentry - the struct to populate
*   OUTPUTS: 0 for success. -1 For failure
*   SIDE EFFECTS: Populates the dentry
*/
int read_dentry_by_index(int index, dentry_t* dentry) {
		  if(index >= *(bootblock_addr)){  // Makes sure that the index if valid
			  return -1;
		  }
		  int* file = bootblock_addr;      // Transfers the pointer for use
		  unsigned char* temp = (unsigned char*)"temp"; // String needs to be initialized
		  cpy_string(temp, (unsigned char*)(bootblock_addr + OFFSET_64*(index+1))); //copies the name of the file over
		  //temp[32] = '\0';
      // Fills out the rest of the data in the dentry
		  cpy_string(dentry->file_name, temp);
      dentry->file_type =  *(file + OFFSET_64*(index+1) + OFFSET_32);
      dentry->inode_number = *(file + OFFSET_64*(index+1) + OFFSET_32 + OFFSET_4);
      dentry->data_blocks  = *(bootblock_addr + OFFSET_INODE*(dentry->inode_number + OFFSET_4));

    return 0;
}



/* read_data
*   DESCRPTION: Finds the data blocks in the inode and populates the buffer with it
*   INPUTS: inode  - the indode number to look at
*           offset - the number to offset by if looking for data in the middle of a file
*           buf    - the buffer to fill with data from the data block
*           length - how long the buffer is, so it knows how much data to get. If it doesn't reach EOF, then the user has to specify the last location as a null terminator
*   OUTPUTS: 0. It doesn't understand if the read is a failure or not so just return 0
*   SIDE EFFECTS: Fills the buffer with data from the requested inode
*/
int read_data(int inode, int offset, unsigned char* buf, int length) {
    int i;
    //current data block we are on
    int data_block = offset / OFFSET_INBLOCK; // Finds the data block to start at
	int offset_2;
	int offset_3;
	offset_3 = offset;
    offset_2 = offset % OFFSET_INBLOCK;   // Finds the location inside the block to start at
    int j = 0;
    int* file;
    int* block;
    int data_block_num;
    int inode_total = *(bootblock_addr + 1);
    //add length elements to the buffer
    for(i = 0; i < length; i++) {
        //if we hit EOF, then we hit end of data block
        if((offset_3 + i) == num_bytes(inode)){
            break;
        }
        //check if we moved to a new data block
        if(((offset_2+j) / (4*(OFFSET_INODE))) == 1) {
            //move to next data_block
            data_block++;
            //reset offset to start of new data block
            offset_2 = 0;
            //reset the j counter
            j = 0;
        }
        //put the current char into the buffer
        file = bootblock_addr + OFFSET_INODE*(inode + 1); // Gets us to the start of data blocks
        data_block_num = *(file + data_block + OFFSET_4);
        block = bootblock_addr + (inode_total+1)*OFFSET_INODE + data_block_num*OFFSET_INODE;
        char* datablock_ptr = (char*)block;
        buf[i] = *(datablock_ptr + offset_2 + j);     // Finds the location in the data block and puts it into the buffer
        j++;
    }
    //return success
    return i;
}

/*******
 * int num_bytes()
 *
 * params: an inode number
 * outputs: the number of bytes offset from the boot block address
 *
 * side effects: none
 */
int num_bytes(int inode_number) {
    return *((int*)(bootblock_addr + (inode_number + 1)*OFFSET_INODE));
}
/* function_ls
*       DESCRIPTION: Outputs the file names to the terminal
*       INPUTS: None
*       OUTPUTS: None
*       SIDE EFFECTS: Outputs the file names to the terminal
*/
/*void function_ls() {
    int number_dir = *(bootblock_addr);     // Gets the number of directories
    int i;
	unsigned char* temp = "temp";
    for(i = 0; i < number_dir; i++) {       // Loops through and prints out the name of each file per directory.
		    dir_read(i, temp);
		    temp[32] = '\0';
        terminal_write(temp);
    }
}*/
