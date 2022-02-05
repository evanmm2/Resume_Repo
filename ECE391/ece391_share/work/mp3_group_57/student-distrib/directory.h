#ifndef DIRECTORY_H
#define DIRECTORY_H

#include "types.h"
#include "lib.h"
#include "file_system.h"
#include "terminal.h"

#define DIR_ENTRIES 14
#define FILE_ARRAY_SIZE 32
#define FILE_ARRAY_SIZE_MAX 33

#ifndef ASM

/* copy data to user */
int copy_to_user(int fd, unsigned char* target_addr);
/*read file system*/
int dir_read(int fd, void *buf, int32_t nbytes);
/* do nothing for the others*/
int dir_write(int32_t fd, const void* buf, int32_t nbytes);

int dir_open(const uint8_t* filename);

int dir_close(int32_t fd);

#endif
#endif
