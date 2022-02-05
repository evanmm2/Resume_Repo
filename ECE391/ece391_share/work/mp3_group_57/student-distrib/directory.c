#include "directory.h"


static int dir_location = 0;
static dentry_t file;
/* * * * *
 *  int dir_read()
 *
 *  params: an integer file descriptor, a void* buffer, and a number of bytes
 *
 *  outputs: an intyeger based on whether or not the directory could be read
 *  side effects: none
 *
 * */
int dir_read(int fd, void *buf, int32_t nbytes){
      //clean both buffers
      int i;
      for(i = 0; i < FILE_ARRAY_SIZE_MAX; i++) {
          ((char*)buf)[i] = '\0';
      }

      for(i = 0; i < FILE_ARRAY_SIZE; i++) {
          file.file_name[i] = '\0';
      }
      //if we hit end of directories return 0 bytes read and reset dir_location
      if(read_dentry_by_index(dir_location, &file) == -1) {
          dir_location = 0;
          return 0;
      }

      for(i = 0; i < FILE_ARRAY_SIZE; i++) {
          ((unsigned char*)buf)[i] = file.file_name[i];
      }
      //move dirLlocation up one
      dir_location++;
      //return number of bytes read
      return strlen((unsigned char*)buf);
}

/* * * * *
 *  dir_write()
 *
 *  params: an int file descriptor, a void* buffer, and a number of bytes
 *  outputs: -1, always
 *
 *  side effects: none
 * */
int dir_write(int32_t fd, const void* buf, int32_t nbytes){
  return -1;
}

/* * * * *
 *  dir_open()
 *
 *  params: a file name array
 *  outputs: returns 0 always.
 *
 *  side effects: resets the dir location
 * */
int dir_open(const uint8_t* filename){
    dir_location = 0;
    return 0;
}

/* * * * *
 * dir_close()
 *
 *  params: a file descriptor integer
 *  outputs: zero, always
 *
 *  side effects: none
 * */
int dir_close(int32_t fd){
    dir_location = 0;
    return 0;
}
