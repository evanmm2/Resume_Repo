#ifndef FILESYSTEM_H
#define FILESYSTEM_H

#include "types.h"
#include "lib.h"
#include "terminal.h"
#include "system_calls.h"

#ifndef ASM

#define OFFSET_64 16         // 64 byte offsets for bootblock. 64/(4 bytes per integer) = 16
#define OFFSET_32 8          // 32 byte offset for the file type. 32/(4 bytes per integer) = 8
#define OFFSET_4  1          // 4 byte offset for the inode. 4/(4 bytes per integer) = 1
#define OFFSET_INODE 1024    // 4 KB offset to get to the next inode. It is 1024 due to integer math multiplying by 4 in C.
#define OFFSET_INBLOCK 4096

int* bootblock_addr;                // This is the address of the bootblock. Defined on boot. Not always static
// This data entry struct is used to keep track of the bootblock data for a specific file name
typedef struct dentry {
    unsigned char file_name[32];        // Holds the file name
    int file_type;                      // Holds the file type
    int inode_number;                   // Holds the inode number
    int data_blocks;                    // Holds the total number of bytes in the data blocks
}dentry_t;

/* read a file  */
int32_t file_read(int32_t fd, void* buf, int32_t nbytes);

/* close a file  */
int32_t file_close(int32_t fd);

/* write to a file  */
int32_t file_write(int32_t fd, const void* buf, int32_t nbytes);

/* open a file */
int32_t file_open(const uint8_t* filename);

// Reads the data entry by name and puts the information into the dentry data struct
int read_dentry_by_name(const unsigned char* fname, dentry_t* dentry);
// Supposed to read by index. Not implemented yet
int read_dentry_by_index(int index, dentry_t* dentry);
// Reads the data from the inode and passes it through the buffer back to be used
int read_data(int inode, int offset, unsigned char* buf, int length);
// Writes the files in the bootblock to screen
void function_ls();
//find directory file name at given index


int num_bytes(int inode_number);

#endif /* ASM END */

#endif  /* IDT_H */
