#ifndef SCHEDULING_H
#define SCHEDULING_H

#include "lib.h"
#include "system_calls.h"
#include "interrupt_calls.h"
#include "terminal.h"
#include "i8259.h"



#define HZ_I_100 11932
#define HZ_I_20  59659
#define HZ_I_33  36157      //OSS: math for this is found in datasheet
                                        // and is 1193810 / frequency desired.

#define SCHED_INTLINE    0              // OSS: master interrupt on highest priority line
#define SCHED_CHANNEL   0x40    //OSS: found on PIT datasheet
#define MASK_SHIFT 8
#define SPEED 0x36


#define TIMER_REG 0x43

#ifndef ASM

void scheduler_initialize(void);        // OSS: turn scheduler on
void scheduler_switch(void);            // OSS: call interupt
void pit_helper(void);                      // OSS: helper function
void set_pit_mode(void);                // OSS: set the mode




#endif  /* ASM */




#endif /* SCHEDULING */
