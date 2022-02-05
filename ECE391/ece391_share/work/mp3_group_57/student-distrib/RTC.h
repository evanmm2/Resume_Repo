#include "types.h"
#include "system_calls.h"

#ifndef RTC_H
#define RTC_H

#define SPEED_0  0x0 	// No speed
#define	SPEED_8_2 0x1	// 256 Hz
#define SPEED_7_2 0x2   // 128 Hz
#define SPEED_13 0x3    // 8,192 Hz
#define SPEED_12 0x4    // 4,096 Hz
#define SPEED_11 0x5    // 2,048 Hz
#define SPEED_10 0x6    // 1,024 Hz
#define SPEED_9 0x7     // 512 Hz
#define SPEED_8 0x8     // 256 Hz
#define SPEED_7 0x9     // 128 Hz
#define SPEED_6 0xA     // 64 Hz
#define SPEED_5 0xB     // 32 Hz
#define SPEED_4 0xC     // 16 Hz
#define SPEED_3 0xD     // 8 Hz
#define SPEED_2 0xE     // 4 Hz
#define SPEED_1 0xF		// Slow Speed. 2 HZ

#define Hz0		0x0000
#define Hz2     0x0002  // Each of these Hz are the acceptable numbers for the RTC to accept as frequencies
#define Hz4     0x0004  // They are used in case statements to convert between input from the write function to data useable by the device
#define Hz8     0x0008
#define Hz16    0x0010
#define Hz32    0x0020
#define Hz64    0x0040
#define Hz128   0x0080
#define Hz256   0x0100
#define Hz512   0x0200
#define Hz1024  0x0400

#ifndef ASM

// Sets up the struct for RTC Time so that other things can access the data from RTC
typedef struct rtc_time{
			int tm_sec; //Seconds
			int tm_min;	// Minutes
			int tm_hour;	// Hours
			int tm_mday;	// Day of the Month
			int tm_mon;		// Month
			int tm_year;	// Year
			int tm_wday;	// Day of the week
			int tm_yday;	// Day in the year
			int tm_isdst; 	// Daylight savings time? 1 or 0 for correction.
} rtc_time_t;


// Initializes the RTC
void init_RTC();
// Handles the RTC for interrupts
void handle_sig_RTC();
// Sets the frequency of the RTC. Used in write
void frequency_RTC(int32_t x);
// Opens an instance of RTC. Doesn't really do much for right now
int32_t open_RTC(const uint8_t* filename);
// Closes an instance of RTC. Also doesn't do much right now
int32_t close_RTC(int32_t fd);
// Reads the data from the RTC. Waits for an interrupt to go through before anything can be put to screen
int32_t read_RTC(int32_t fd, void* buf, int32_t nbytes);
// Writes the frequency in buf to RTC. Will always return nbytes
int32_t write_RTC(int32_t fd, const void* buf, int32_t nbytes);


//ASM End
#endif
//RTC End
#endif
