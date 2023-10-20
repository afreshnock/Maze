#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdbool.h>
#include "address_map_arm.h"

#define HW_REGS_BASE ( 0xFC000000 )
#define HW_OCRAM_BASE ( 0xC8000000 )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )
#define FPGA_CHAR_BASE      0xC9000000

#define PHYSMEM_32(addr) (*((unsigned int *)(virtual_base + (addr & HW_REGS_MASK))))
#define PHYSMEM_16(addr) (*((unsigned short *)(virtual_base + (addr & HW_REGS_MASK))))


/****************************************************************************************
 * Draw a filled rectangle on the VGA monitor 
****************************************************************************************/
void VGA_box(int x1, int y1, int x2, int y2, short pixel_color, void *virtual_base)
{ 
	unsigned int pixel_ptr, row, col;

	/* assume that the box coordinates are valid */
	for (row = y1; row <= y2; row++)
		for (col = x1; col <= x2; ++col)
		{
			pixel_ptr = HW_OCRAM_BASE + (row << 10) + (col << 1);
			PHYSMEM_16(pixel_ptr) = pixel_color;		// set pixel color
		}
}


void VGA_text(int x, int y, char * text_ptr, void *virtual_base)
{
	int offset;
  	unsigned int  char_ptr;

	/* assume that the text string fits on one line */
	offset = (y << 7) + x;
	while ( *(text_ptr) )
	{
		char_ptr =  FPGA_CHAR_BASE + offset;
		
		PHYSMEM_32(char_ptr) = *(text_ptr);
		
		++text_ptr;
		++offset;
	}
}

void VGA_text_clear(void *virtual_base)
{
	int x,y;
	int offset;
	char blank[1] = " ";
  	unsigned int  char_ptr;

	// Character coordinats are from 0,0 to 79,59 (x,y) position
	for(x = 0; x < 80; x++)
		for(y = 0; y < 60; y++)
		{
		/* assume that the text string fits on one line */
		offset = (y << 7) + x;
		char_ptr =  FPGA_CHAR_BASE + offset;
		PHYSMEM_32(char_ptr) = *blank;
		}
}
// Test program for use with the DE1-SoC University Computer
// 

int main(int argc,char ** argv) {
	
    void *virtual_base;
    int fd;
  	int audio_control, audio_fifo;
	long int audio_left_read, audio_left_write, audio_right_read, audio_right_write;
	
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
	
    // Set framebuffer addr to beginning of the SRAM
   
   int left_data, left_wr_space;
   int right_data;
   audio_left_write = 0;
   
   PHYSMEM_16((AUDIO_CTRL)) = 0x03; // Clear the Read and Write FIFOs
   PHYSMEM_16((AUDIO_CTRL)) = 0x00; // Clear the Read and Write FIFOs   
   
   while(1)
   {
	   audio_fifo =  PHYSMEM_16((AUDIO_SPACE));
	   //printf("audio_space = %x \n", audio_fifo);
	   PHYSMEM_32(AUDIO_DAC_LEFT_DAT) = audio_left_write;
	   audio_left_write = audio_left_write + 8000;
	   PHYSMEM_16((AUDIO_CTRL)) = 0x0c;
	   audio_left_read = PHYSMEM_32(AUDIO_ADC_LEFT_DAT);
	   printf("audio_space = %d write=%d read=%d \n", audio_fifo, audio_left_write, audio_left_read);
	   PHYSMEM_16((AUDIO_CTRL)) = 0x00;
	   /*
	   left_data = (audio_fifo & 0x0000FF00) >> 8;
	   left_wr_space = (audio_fifo & 0xFF000000) >> 24;
	   right_data = (audio_fifo & 0x000000FF);
	   audio_left_read = PHYSMEM_32((AUDIO_BASE+8));
	    PHYSMEM_32((AUDIO_BASE+8)) = audio_left_write;
	    PHYSMEM_32((AUDIO_BASE+16)) = audio_left_write++;
		PHYSMEM_32((AUDIO_BASE+24)) = audio_left_write++;
		printf("left_wr_space=%d, RALC=%d RARC=%d left_in = %d left_out = %d\n", left_wr_space, left_data, 
		right_data, audio_left_read, audio_left_write);
		
		//PHYSMEM_32((AUDIO_BASE)) = 0x000200; // Clear the Read and Write FIFOs 
	   */
   }
    

	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );

}
