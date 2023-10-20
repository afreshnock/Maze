#include <stdio.h>

#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"


//#include "address_map_arm.h"
#include "Computer_System.h"


#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

#define  ARM_CM_DEMCR      (*(uint32_t *)0xE000EDFC)

#define  ARM_CM_DWT_CTRL   (*(uint32_t *)0xE0001000)

#define  ARM_CM_DWT_CYCCNT (*(uint32_t *)0xE0001004)

/* This program demonstrates the use of parallel ports in the DE1-SoC Computer
 * It performs the following: 
 * 	1. displays the SW switch values on the red lights LEDR
 * 	2. displays a rotating pattern on the HEX displays
 * 	3. if a KEY[3..0] is pressed, uses the SW switches as the pattern
*/
int main(void)
{
	void *virtual_base;
	int fd;

	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}

	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );

	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}
	
	/* Declare volatile pointers to I/O registers (volatile means that the locations
	 * will not be cached, even in registers) */
	// volatile int * LED_ptr 				= (int *) LEDR_BASE;
	//volatile int * HEX3_HEX0_ptr		= (int *) HEX3_HEX0_BASE;
	//volatile int * SW_switch_ptr		= (int *) SW_BASE;
	//volatile int * KEY_ptr				= (int *) KEY_BASE;

	void * LED_ptr 				=  virtual_base + ( ( unsigned long  )( ALT_LWFPGASLVS_OFST + ARM_A9_HPS_LEDS_BASE ) & ( unsigned long)( HW_REGS_MASK ) );
	void * HEX3_HEX0_ptr		=  virtual_base + ( ( unsigned long  )( ALT_LWFPGASLVS_OFST + ARM_A9_HPS_HEX3_HEX0_BASE ) & ( unsigned long)( HW_REGS_MASK ) );
	void * SW_switch_ptr		=  virtual_base + ( ( unsigned long  )( ALT_LWFPGASLVS_OFST + ARM_A9_HPS_SLIDER_SWITCHES_BASE ) & ( unsigned long)( HW_REGS_MASK ) );
	void * KEY_ptr				=  virtual_base + ( ( unsigned long  )( ALT_LWFPGASLVS_OFST + ARM_A9_HPS_PUSHBUTTONS_BASE ) & ( unsigned long)( HW_REGS_MASK ) );

	int HEX_bits = 0x0000000F;					// initial pattern for HEX displays
	int SW_value;
	volatile int delay_count;					// volatile so the C compiler doesn't remove the loop

	while (1)
	{
		SW_value = *(int *) SW_switch_ptr;		 	// read the SW slider switch values
		* (int *) LED_ptr = SW_value; 					// light up the red LEDs

		if (* (int *) KEY_ptr != 0)						// check if any KEY was pressed
		{
			HEX_bits = SW_value;					// set pattern using SW values
			while (*(int *) KEY_ptr != 0);				// wait for pushbutton KEY release
		}
		*(int *) HEX3_HEX0_ptr = HEX_bits;			// display pattern on HEX3 ... HEX0

		/* rotate the pattern shown on the HEX displays */
		if (HEX_bits & 0x80000000)
			HEX_bits = (HEX_bits << 1) | 1;
		else
			HEX_bits = HEX_bits << 1;

		for (delay_count = 25000000; delay_count != 0; --delay_count); // delay loop
	}
	
	
	// clean up our memory mapping and exit
	
	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );
}
