#include "tests.h"

#define PASS 1
#define FAIL 0

/* format these macros as you see fit */
#define TEST_HEADER 	\
	printf("[TEST %s] Running %s at %s:%d\n", __FUNCTION__, __FUNCTION__, __FILE__, __LINE__)
#define TEST_OUTPUT(name, result)	\
	printf("[TEST %s] Result = %s\n", name, (result) ? "PASS" : "FAIL");

static inline void assertion_failure(){
	/* Use exception #15 for assertions, otherwise
	   reserved by Intel */
	asm volatile("int $15");
}


/* Checkpoint 1 tests */

/* IDT Test - Example
 *
 * Asserts that first 10 IDT entries are not NULL
 * Inputs: None
 * Outputs: PASS/FAIL
 * Side Effects: None
 * Coverage: Load IDT, IDT definition
 * Files: x86_desc.h/S
 */
int idt_test(){
	TEST_HEADER;

	int i;
	int result = PASS;
	for (i = 0; i < 10; ++i){
		if ((idt[i].offset_15_00 == NULL) &&
			(idt[i].offset_31_16 == NULL)){
			assertion_failure();
			result = FAIL;
		}
	}

	return result;
}

/*
divide_by_zero_test
INPUTS: none
OUTPUTS: none(it shouldn't return)
SIDE EFFECTS: None
coverage: Test divide by zero exception, uses LDT table and shows it works
*/
int divide_by_zero_test() {
		int z;
		int zero = 0;
		int one = 1;
		z = one/zero;
		return z;
}

/*
RTC_TEST
INPUTS: none
OUTPUTS: none
SIDE EFFECTS: sets the frequency of the RTC
COVERAGE: Enables interrupts from the RTC
*/
int RTC_TEST(){
	clear();
	// Initialize the RTC
	//init_RTC();
	int* buf;
	int z;
	int i;
	*buf = 32;
	z = write_RTC(0,buf,4);
	for(i = 0; i < 100; i++ ){
		read_RTC(0, buf, 4);
	}
	*buf = 2;
	z = write_RTC(0,buf,4);
	for(i = 0; i < 20; i++ ){
		read_RTC(0, buf, 4);
	}
	*buf = 1033;
	z = write_RTC(0,buf,4);
	for(i = 0; i < 20; i++ ){
		read_RTC(0, buf, 4);
	}
	*buf = 0;
	z = write_RTC(0,buf,4);
	for(i = 0; i < 1; i++ ){
		read_RTC(0, buf, 4);
	}
	return FAIL;
}

/*
OVERFLOW_TEST
INPUTS: none
OUTPTUS: none(it shouldn't get to return)
SIDE EFFECTS: None
COVERAGE: Tests the overflow execption, similar to divide_by_zero_test
*/
int OVERFLOW_TEST() {
		uint32_t x = 0xFFFFFFFF;
		uint32_t y;
		x = y;
		uint32_t z = x*y;
		return z;
}

int TEST_KEYBOARD() {
	reset_screen();
	move_cursor();
	while(1) {
		//handle_SIG_KBD();
	}
	return FAIL;
}

int TEST_IRQ() {
	enable_irq(MASTER_IRQ2);
	return FAIL;
}

int paging_test() {
		int* ptr = NULL;
		//*ptr = 0xFF;
		int value = *ptr;
		return value;
}
/* Checkpoint 2 tests */
int file_system_test() {
	dentry_t* x;
	//read_dentry_by_index(10,x);
	read_dentry_by_name((unsigned char*)("syserr"), x);
	int buffer_size = *(bootblock_addr + (x->inode_number + 1)*1024);
	unsigned char buf[buffer_size + 1];
	unsigned char* file_passer;
	cpy_string(file_passer, x->file_name);
	open(file_passer);
	read(2, buf, buffer_size);
	buf[buffer_size] = '\n';	// So we can add a next line

	//printf("%s", buf);
	int i;
	for(i = 0; i < buffer_size; i++) {
			if(buf[i] != 0)
					putc(buf[i]);
		}
	for(i = 0; i < BUFFER_SIZE; i++){
		//terminal_array[cur_terminal].kbd_struct->kbd_buffer[i] = 0x00;
	}
	while(1);
	/*if (-1 == open("frame1.txt")) {
		printf("failed to open frame1.txt\n");
		pass = 0;
		return 1;
	}
  read(2, buf, 18);
	buf[18] = "/0";
	printf("%s",myString);
	if (-1 == close(2)) {
		printf("failed to close frame1.txt\n");
		pass = 0;
		return 1;
	}
	if (-1 == open("verylargetextwithverylongname.txt")) {
		printf("cant open large files");
		return 1;
	}
	close("verylargetextwithverylongname.txt");
	if (-1 == open("cat")) {
		printf("failed to open cat\n");
		pass = 0;
		return 1;
	}
	if (-1 != open("cat")) {
		printf("failed to prevent redundant open\n");
		pass = 0;
		return 1;
	}
	open("frame1.txt");
	open("frame0.txt");
	open("hello");
	open("grep");
	if (-1 == open("shell")) {
		printf("failed to preventn allow 6 files\n");
		pass = 0;
		return 1;
	}
	if ((close(3) == -1) || (close(4) == -1) || (close(5) == -1) || (close(7) == -1 ) || (close(6) == -1)) {
		printf("couldn't close everythign\n");
		pass = 0;
		return 1;
	}
	read(2, buf, 19);
	buf[19] = "/0";
	printf("%s", buf);
	close(2);
	if (pass) {
		printf("apparently passed");
	} else {
		printf("apparently failed");
	}*/
	return SUCCESS;
}

/*int terminal_read_test() {
		reset_screen();
		terminal_init();
		terminal_open();
		terminal_open();
		terminal_open();
		while(1);
		return SUCCESS;
}*/

/*int terminal_largestring() {
		reset_screen();
		terminal_init();
		terminal_open();
		return terminal_write("This is a really big string that is too big for this functions to print out I am not sure if its big enough yet I'll keep going for a little bit more almost there now I am happy\n");
}

int TEST_STRINGZ(){
	char* x = "Hello";
	char* y;
	cpy_string(y, x);
	int z = cmp_string(x,y);
	if(z==0){
		return SUCCESS;
	}
	return FAIL;
}

int TEST_READ_BY_NAME() {
		//reset_screen();
		dentry_t* x;
		read_dentry_by_name("frame1.txt", x);
		printf("%d\n", x->inode_number);

		char buf[100];
		read_data(x->inode_number, 0, buf, 100);

		return 0;
}*/
/* Checkpoint 3 tests */
int shell_space() {
		int* shell_ptr = (int*)(0x800001);
		int my_int = *shell_ptr;
		my_int = 1;
		while(1);
		return my_int;
}
/* Checkpoint 4 tests */
/* Checkpoint 5 tests */


/* Test suite entry point */
void launch_tests(){
	//TEST_OUTPUT("idt_test", idt_test());
	//TEST_OUTPUT("divide_by_zero_test", divide_by_zero_test());
	//TEST_OUTPUT("RTC_TEST", RTC_TEST());
	// launch your tests here
	//TEST_OUTPUT("TEST_KEYBOARD", TEST_KEYBOARD());
	//TEST_OUTPUT("TEST_IRQ", TEST_IRQ());
	//TEST_OUTPUT("terminal_read_test", terminal_read_test());
	//TEST_OUTPUT("terminal_largestring", terminal_largestring());
	TEST_OUTPUT("paging_test", paging_test());
	//TEST_OUTPUT("TEST_STRINGZ", TEST_STRINGZ());
	//TEST_OUTPUT("TEST_READ_BY_NAME", TEST_READ_BY_NAME());
	//TEST_OUTPUT("file_system_test", file_system_test());
	//TEST_OUTPUT("shell_space", shell_space());
}
