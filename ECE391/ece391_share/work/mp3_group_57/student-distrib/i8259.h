/* i8259.h - Defines used in interactions with the 8259 interrupt
 * controller
 * vim:ts=4 noexpandtab
 */

#ifndef _I8259_H
#define _I8259_H

#include "types.h"
#include "lib.h"

/* Ports that each PIC sits on */
#define MASTER_8259_PORT    0x20
#define SLAVE_8259_PORT     0xA0

#define SLAVE_IRQ0			8		/* Reserved for the RTC		*/
#define SLAVE_IRQ1			9
#define SLAVE_IRQ2			10
#define SLAVE_IRQ3			11
#define SLAVE_IRQ4			12
#define SLAVE_IRQ5			13
#define SLAVE_IRQ6			14
#define SLAVE_IRQ7			15


#define MASTER_IRQ0			0
#define MASTER_IRQ1			1		/* Reserved for the Keyboard */
#define MASTER_IRQ2			2
#define MASTER_IRQ3			3
#define MASTER_IRQ4			4
#define MASTER_IRQ5			5
#define MASTER_IRQ6			6
#define MASTER_IRQ7			7

#define SLAVE_START			8
#define SLAVE_END			15

/* Initialization control words to init each PIC.
 * See the Intel manuals for details on the meaning
 * of each word */
#define ICW1                0x11
#define ICW2_MASTER         0x20
#define ICW2_SLAVE          0x28
#define ICW3_MASTER         0x04
#define ICW3_SLAVE          0x02
#define ICW4                0x01

/* End-of-interrupt byte.  This gets OR'd with
 * the interrupt number and sent out to the PIC
 * to declare the interrupt finished */
#define EOI                 0x60

/* Externally-visible functions */
#ifndef ASM
/* Initialize both PICs */
void i8259_init(void);
/* Enable (unmask) the specified IRQ */
int32_t enable_irq(uint32_t irq_num);
/* Disable (mask) the specified IRQ */
int32_t disable_irq(uint32_t irq_num);
/* Send end-of-interrupt signal for the specified IRQ */
void send_eoi(uint32_t irq_num);


#endif /* ASM  */
#endif /* _I8259_H */
