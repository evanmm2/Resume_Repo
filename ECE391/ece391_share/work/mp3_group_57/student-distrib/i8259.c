/* i8259.c - Functions to interact with the 8259 interrupt controller
 * vim:ts=4 noexpandtab
 */

#include "i8259.h"

/* Masks for all of the IRQs*/
#define MASK_IRQ_0 0x01
#define MASK_IRQ_1 0x02
#define MASK_IRQ_2 0x04
#define MASK_IRQ_3 0x08
#define MASK_IRQ_4 0x10
#define MASK_IRQ_5 0x20
#define MASK_IRQ_6 0x40
#define MASK_IRQ_7 0x80


//EOI signal here
#define EOI       0x60


#define SLAVE_MASK   0xFB
#define ALL_MASK     0xFF

/* Interrupt masks to determine which interrupts are enabled and disabled */
uint8_t master_mask; /* IRQs 0-7  */
uint8_t slave_mask;  /* IRQs 8-15 */

/* * * * * * * * * * * * * * * * * * * * * * *
 *  i8259_init()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - void
 *
 *      outputs:
 *          - will initialize the PIC of the device
 *          by setting the instruction control words
 *          to the device.
 *
 *      side effects:   stores and saves flags.
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes: works
 * * * * * * * * * * * * * * * * * * * * * * *
 */
void i8259_init(void) {
    unsigned long flags;
    /* save state of interrupts */
    cli_and_save(flags);

    outb(ALL_MASK, MASTER_8259_PORT + 1);

    /* update current master mask */
    master_mask = ALL_MASK;

    outb(ALL_MASK, SLAVE_8259_PORT + 1);

    slave_mask = ALL_MASK;

    outb(ICW1, MASTER_8259_PORT);

    outb(ICW2_MASTER, MASTER_8259_PORT + 1);    //vector

    outb(ICW3_MASTER, MASTER_8259_PORT + 1);

    outb(ICW4, MASTER_8259_PORT + 1);


    /* init the slave PIC now */

    outb(ICW1, SLAVE_8259_PORT);

    outb(ICW2_SLAVE, SLAVE_8259_PORT + 1);

    outb(ICW3_SLAVE, SLAVE_8259_PORT + 1);

    outb(ICW4, SLAVE_8259_PORT + 1);


    //enable the slave IRQs on the master line
    outb(SLAVE_MASK, MASTER_8259_PORT + 1);

    master_mask = SLAVE_MASK;

    restore_flags(flags);

}

/* * * * * * * * * * * * * * * * * * * * * * *
 *  enable_irq()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - irq_num, an integer IRQ number that will (hopefully)
 *          map to a number between 0 and 15.
 *
 *
 *      outputs:
 *          will enable an IRQ on the specified line by masking the opposite of their
 *          respective masks, which lets the proper data through the PIC and to the
 *          CPU.
 *
 *      side effects:
 *          needs a valid IRQ number or returns -1.
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes:  works
 * * * * * * * * * * * * * * * * * * * * * * *
 */
int32_t enable_irq(uint32_t irq_num) {

    uint32_t cur_flags;

    cli_and_save(cur_flags);

    // check if this is a master interrupt or a slave interrupt
    if(irq_num < SLAVE_START)
    {   // These enable the mask on the individual lines on the master
        switch(irq_num)
        {
            case MASTER_IRQ0:
                master_mask &= (~MASK_IRQ_0);
                break;

            case MASTER_IRQ1:
                master_mask &= (~MASK_IRQ_1);
                break;

            case MASTER_IRQ2:
                master_mask &= (~MASK_IRQ_2);
                break;

            case MASTER_IRQ3:
                master_mask &= (~MASK_IRQ_3);
                break;

            case MASTER_IRQ4:
                master_mask &= (~MASK_IRQ_4);
                break;


            case MASTER_IRQ5:
                master_mask &= (~MASK_IRQ_5);
                break;

            case MASTER_IRQ6:
                master_mask &= (~MASK_IRQ_6);
                break;

            case MASTER_IRQ7:
                master_mask &= (~MASK_IRQ_7);
                break;


            default:
                restore_flags(cur_flags);
                return -1;

        }

        outb(master_mask, MASTER_8259_PORT + 1);
    }

    // slave IRQ handler
    else
    {   // These enable the mask on the individual lines on the slave
        switch(irq_num)
        {
            case SLAVE_IRQ0:
            slave_mask &= (~MASK_IRQ_0);
            break;

            case SLAVE_IRQ1:
            slave_mask &= (~MASK_IRQ_1);
            break;

            case SLAVE_IRQ2:
            slave_mask &= (~MASK_IRQ_2);
            break;

            case SLAVE_IRQ3:
            slave_mask &= (~MASK_IRQ_3);
            break;

            case SLAVE_IRQ4:
            slave_mask &= (~MASK_IRQ_4);
            break;

            case SLAVE_IRQ5:
            slave_mask &= (~MASK_IRQ_5);
            break;

            case SLAVE_IRQ6:
            slave_mask &= (~MASK_IRQ_6);
            break;

            case SLAVE_IRQ7:
            slave_mask &= (~MASK_IRQ_7);
            break;

            default:
            restore_flags(cur_flags);
            return -1;

        }

        outb(slave_mask, SLAVE_8259_PORT + 1);


    }

    restore_flags(cur_flags);
    return 0;
}

/* * * * * * * * * * * * * * * * * * * * * * *
 *  disable_irq()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - irq_num, an IRQ number
 *
 *      outputs:
 *          - disables the IRQ on a specific line.
 *
 *      side effects: none
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes:  works?
 * * * * * * * * * * * * * * * * * * * * * * *
 */
int32_t disable_irq(uint32_t irq_num) {

    uint32_t cur_flags;

    cli_and_save(cur_flags);

    // check if this is a master interrupt or a slave interrupt
    if(irq_num < SLAVE_START)
    { // These disable the mask on the individual lines on the master
        switch(irq_num)
        {
            case MASTER_IRQ0:
                master_mask |= MASK_IRQ_0;
                break;

            case MASTER_IRQ1:
                master_mask |= MASK_IRQ_1;
                break;

            case MASTER_IRQ2:
                master_mask |= MASK_IRQ_2;
                break;

            case MASTER_IRQ3:
                master_mask |= MASK_IRQ_3;
                break;

            case MASTER_IRQ4:
                master_mask |= MASK_IRQ_4;
                break;


            case MASTER_IRQ5:
                master_mask |= MASK_IRQ_5;
                break;

            case MASTER_IRQ6:
                master_mask |=MASK_IRQ_6;
                break;

            case MASTER_IRQ7:
                master_mask |= MASK_IRQ_7;
                break;


            default:
                restore_flags(cur_flags);
                return -1;

        }

        outb(master_mask, MASTER_8259_PORT + 1);
    }

    // slave IRQ handler
    else
    {   // These enable the mask on the individual lines on the slave
        switch(irq_num)
        {
            case SLAVE_IRQ0:
            slave_mask |=MASK_IRQ_0;
            break;

            case SLAVE_IRQ1:
            slave_mask |= MASK_IRQ_1;
            break;

            case SLAVE_IRQ2:
            slave_mask |= MASK_IRQ_2;
            break;

            case SLAVE_IRQ3:
            slave_mask |= MASK_IRQ_3;
            break;

            case SLAVE_IRQ4:
            slave_mask |= MASK_IRQ_4;
            break;

            case SLAVE_IRQ5:
            slave_mask |= MASK_IRQ_5;
            break;

            case SLAVE_IRQ6:
            slave_mask |= MASK_IRQ_6;
            break;

            case SLAVE_IRQ7:
            slave_mask |= MASK_IRQ_7;
            break;

            default:
            restore_flags(cur_flags);
            return -1;

        }
        // Outputs the mask
        outb(slave_mask, SLAVE_8259_PORT + 1);


    }

    restore_flags(cur_flags);
    return 0;

}

/* * * * * * * * * * * * * * * * * * * * * * *
 *  send_eoi()
 * * * * * * * * * * * * * * * * * * * * * * *
 *      params:
 *          - an IRQ number (between 0 and 15.)
 *
 *      outputs:
 *      sends an EOI signal to the specified IRQ number.
 *      If the device is on the slave, both the master PIC and
 *      the slave PIC will get an EOI signal.
 *
 *      side effects: none
 * * * * * * * * * * * * * * * * * * * * * * *
 *  Notes:  works
 * * * * * * * * * * * * * * * * * * * * * * *
 */
void send_eoi(uint32_t irq_num) {
    uint32_t cur_flags;

    cli_and_save(cur_flags);

    if(irq_num > SLAVE_END)
    {
        return;     //bad irq num
    }

    if(irq_num < SLAVE_START)
    {
        outb(EOI | irq_num, MASTER_8259_PORT);
        //outb(0x20, MASTER_8259_PORT);
    }

    else
    {
        //send both the master and the slave an EOI signal in this case

        outb(EOI | (irq_num - SLAVE_START), SLAVE_8259_PORT);
        outb(EOI | MASK_IRQ_1, MASTER_8259_PORT);
        //outb(0x20, SLAVE_8259_PORT);
        //outb(0x20, MASTER_8259_PORT);
    }


    restore_flags(cur_flags);
}
