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

#define HW_REGS_BASE ( 0xFC000000 )
#define HW_OCRAM_BASE ( 0xC8000000 )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )
#define FPGA_CHAR_BASE      0xC9000000

#define PHYSMEM_32(addr) (*((unsigned int *)(virtual_base + (addr & HW_REGS_MASK))))
#define PHYSMEM_16(addr) (*((unsigned short *)(virtual_base + (addr & HW_REGS_MASK))))

#define MAX(a,b) (a > b ? a : b)
#define MIN(a,b) (a > b ? b : a)

void VGA_box(int x1, int y1, int x2, int y2, short pixel_color, void *virtual_base);
void VGA_box_clear(void *virtual_base);
void VGA_text(int x, int y, char * text_ptr, void *virtual_base);
void VGA_text_clear(void *virtual_base);
void VGA_clear(void *virtual_base);
void VGA_line(int x1, int y1, int x2, int y2, short pixel_color, void *virtual_base);
void VGA_setPixel(uint32_t col, uint32_t row, uint32_t pixel_color, void *virtual_base);

// Test program for use with the DE1-SoC University Computer
// 

int main(int argc,char ** argv) {
	
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
	
    // Set framebuffer addr to beginning of the SRAM
    PHYSMEM_32(0xff203024) = 0xc8000000;  	// Pixel BackBuffer register
    PHYSMEM_32(0xff203020) = 0xc8000000;	// Pixel Buffer register
    
    // Unmap registers region, map onchip ram region
    if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}
    virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_OCRAM_BASE );
	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}
    
    // Clear the screen
	VGA_box(0, 0, 640,480,0xFFFF, virtual_base); // White
	VGA_box(0, 0, 320,480,0x001F, virtual_base); // Blue
	
	char text_top_row[40] = "Altera DE1-SoC\0";
	char text_bottom_row[40] = "Computer\0";

    VGA_text (34, 29, text_top_row, virtual_base);
	VGA_text (34, 30, text_bottom_row, virtual_base);
	
	VGA_text (1, 1, text_top_row, virtual_base);
	VGA_text (1, 2, text_bottom_row, virtual_base);
	VGA_text (65, 58, text_top_row, virtual_base);
	VGA_text (69, 59, text_bottom_row, virtual_base);
	
	VGA_clear(virtual_base);
	
	int pattern = 0;
	if(pattern == 0){
		VGA_line(100, 300, 180, 380, 0x3333, virtual_base);
		//VGA_line(300, 300, 380, 380, 0x3333, virtual_base);
		VGA_line(100, 100, 180, 180, 0x3333, virtual_base);
		VGA_line(300, 100, 380, 180, 0x3333, virtual_base);
		
		VGA_line(100, 100, 300, 100, 0x3333, virtual_base);
		VGA_line(100, 100, 100, 300, 0x3333, virtual_base);
		VGA_line(300, 100, 300, 180, 0x3333, virtual_base);
		VGA_line(100, 300, 180, 300, 0x3333, virtual_base);
		
		VGA_line(180, 180, 380, 180, 0x3333, virtual_base);
		VGA_line(180, 180, 180, 380, 0x3333, virtual_base);
		VGA_line(380, 180, 380, 380, 0x3333, virtual_base);
		VGA_line(180, 380, 380, 380, 0x3333, virtual_base);
		

		
		//VGA_line(300, 100, 380, 180, 0x3333, virtual_base);
		//VGA_box(380, 180, 380, 380, 0x3333, virtual_base);
		//VGA_box(180, 380, 380, 380, 0x3333, virtual_base);
		
		
	} else {
		VGA_box(140, 140, 340, 340, 0x3333, virtual_base);
		
		//TL = (0,0)
		//TR = (640, 0)
		//BL = (0,480)
		//BR = (640, 480)
		
		VGA_line(240,0,240,480, 0xFFFF, virtual_base);	//Center Vert
		VGA_line(0,240,640,240, 0xFFFF, virtual_base);	//Center Horiz
		
		//			Bottom Left to Top Rightish
		VGA_line(0, 480, 960, 0, 0xF0F0, virtual_base); //BL -> -.5 Slope
		VGA_line(0, 480, 480, 0, 0xF0F0, virtual_base); //BL -> -1 Slope
		VGA_line(0, 480, 240, 0, 0xF0F0, virtual_base); //BL -> -2 Slope

		//			Top Left to Bottom Right
		VGA_line(0,0,960, 480, 0x001F, virtual_base); // TL -> .5 Slope
		VGA_line(0,0,480, 480, 0x001F, virtual_base); // TL -> 1  Slope
		VGA_line(0,0,240, 480, 0x001F, virtual_base); // TL -> 2 Slope
	}
	
	//VGA_text_clear(virtual_base);
	
	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );

}


/****************************************************************************************
 * Draw a filled rectangle on the VGA monitor 
****************************************************************************************/
void VGA_box(int x1, int y1, int x2, int y2, short pixel_color, void *virtual_base){ 
	uint32_t row, col;

	/* assume that the box coordinates are valid */
	for (row = y1; row <= y2; row++)
		for (col = x1; col <= x2; ++col)
			VGA_setPixel(col, row, pixel_color, virtual_base);	
}

void VGA_text(int x, int y, char * text_ptr, void *virtual_base){
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

void VGA_text_clear(void *virtual_base){
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

void VGA_box_clear(void *virtual_base){
	VGA_box(0,0,640,480, 0x0000, virtual_base);
}

void VGA_clear(void *virtual_base){
	VGA_box_clear(virtual_base);
	VGA_text_clear(virtual_base);
}

void VGA_line(int x1, int y1, int x2, int y2, short pixel_color, void *virtual_base){
	//Equation for a line -> y = mx + b
	if(x1 == x2 || y1 == y2){	//Vertical or Horizontal line
		VGA_box(x1, y1, x2, y2, pixel_color, virtual_base);
		return;
	}

	double m = ((double)(y2 - y1)) / ((double)(x2 - x1));	//Slope
	int b = -(m * x1) + y1;
	
	uint32_t row, col, xmax, xmin, ymax, ymin;
	xmax = MIN(MAX(x1,x2), 640);
	xmin = MIN(MIN(x1,x2), 640);
	ymax = MIN(MAX(y1,y2), 480);
	ymin = MIN(MIN(y1,y2), 480);
	
	//m is the Slope	
	if(m > -1 && m < 1){
		for(row = xmin; row < xmax; row++) //Iterate over the rows
			VGA_setPixel(m * row + b, row, pixel_color, virtual_base);
	} else {
		for(col = ymin; col < ymax; col++) //Iterate over the columns
			VGA_setPixel(col, (int)((col - b) / m) , pixel_color, virtual_base);
	}
}

void VGA_setPixel(uint32_t row, uint32_t col, uint32_t pixel_color, void *virtual_base){
	uint32_t pixel_ptr = HW_OCRAM_BASE + (row << 10) + col; 	// New one for 640x480
	PHYSMEM_16(pixel_ptr) = pixel_color;						// set pixel color
}
