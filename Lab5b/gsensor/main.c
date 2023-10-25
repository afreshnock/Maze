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
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <linux/i2c-dev.h>
#include "hwlib.h"
#include "ADXL345.h"

#define HW_REGS_BASE ( 0xFC000000 )
#define HW_OCRAM_BASE ( 0xC8000000 )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )
#define FPGA_CHAR_BASE      0xC9000000

#define PHYSMEM_32(addr) (*((unsigned int *)(virtual_base + (addr & HW_REGS_MASK))))
#define PHYSMEM_16(addr) (*((unsigned short *)(virtual_base + (addr & HW_REGS_MASK))))

void VGA_box(int x1, int y1, int x2, int y2, short pixel_color, void *virtual_base) {
    unsigned int pixel_ptr, row, col;

    for (row = y1; row <= y2; row++) {
        for (col = x1; col <= x2; ++col) {
            pixel_ptr = HW_OCRAM_BASE + (row << 10) + col;
            PHYSMEM_16(pixel_ptr) = pixel_color; // set pixel color
        }
    }
}

void VGA_text(int x, int y, char * text_ptr, void *virtual_base) {
    int offset;
    unsigned int char_ptr;

    offset = (y << 7) + x;
    while (*(text_ptr)) {
        char_ptr = FPGA_CHAR_BASE + offset;
        PHYSMEM_32(char_ptr) = *(text_ptr);
        ++text_ptr;
        ++offset;
    }
}

void Draw_Circle(int x, int y, short pixel_color, void *virtual_base)
{
	
	unsigned int pixel_ptr;
	int r = 15;
	static double PI = 3.14;
	double x1, y1;
	double i;
	for( i =0; i < 360; i ++)
	{
		for( r = 15; r > 0; r--){
		x1 = r * cos( i * PI/180);
		y1 = r * sin( i * PI/180);
		// pixel_ptr = HW_OCRAM_BASE + x + x1;
		// PHYSMEM_16(pixel_ptr) = pixel_color;
		// pixel_ptr = HW_OCRAM_BASE + y + y1;
		// PHYSMEM_16(pixel_ptr) = pixel_color;
		
		pixel_ptr = HW_OCRAM_BASE + ((int)(x + x1) << 10) + (int)(y + y1);
		PHYSMEM_16(pixel_ptr) = pixel_color;
		}
	}	
	
}


void VGA_text_clear(void *virtual_base) {
    int x,y;
    int offset;
    char blank[1] = " ";
    unsigned int char_ptr;

    for(x = 0; x < 80; x++) {
        for(y = 0; y < 60; y++) {
            offset = (y << 7) + x;
            char_ptr = FPGA_CHAR_BASE + offset;
            PHYSMEM_32(char_ptr) = *blank;
        }
    }
}

void VGA_clear(void *virtual_base) {
    VGA_box(0, 0, 572, 480, 0x0000, virtual_base); // Black
    VGA_text_clear(virtual_base);
}

void VGA_line(int x0, int y0, int x1, int y1, short pixel_color, void *virtual_base) {
    // Implementing Bresenham's Line Drawing Algorithm
    int dx = abs(x1 - x0);
    int dy = abs(y1 - y0);
    int sx = (x0 < x1) ? 1 : -1;
    int sy = (y0 < y1) ? 1 : -1;
    int err = dx - dy;
    int e2;

    while (1) {
        unsigned int pixel_ptr = HW_OCRAM_BASE + (y0 << 10) + x0;
        PHYSMEM_16(pixel_ptr) = pixel_color;

        if (x0 == x1 && y0 == y1) {
            break;
        }

        e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            x0 += sx;
        }
        if (e2 < dx) {
            err += dx;
            y0 += sy;
        }
    }
}

bool ADXL345_REG_WRITE(int file, uint8_t address, uint8_t value){
	bool bSuccess = false;
	uint8_t szValue[2];
	
	// write to define register
	szValue[0] = address;
	szValue[1] = value;
	if (write(file, &szValue, sizeof(szValue)) == sizeof(szValue)){
			bSuccess = true;
	}
		
	
	return bSuccess;		
}

bool ADXL345_REG_READ(int file, uint8_t address,uint8_t *value){
	bool bSuccess = false;
	uint8_t Value;
	
	// write to define register
	if (write(file, &address, sizeof(address)) == sizeof(address)){
	
		// read back value
		if (read(file, &Value, sizeof(Value)) == sizeof(Value)){
			*value = Value;
			bSuccess = true;
		}
	}
		
	
	return bSuccess;	
}

bool ADXL345_REG_MULTI_READ(int file, uint8_t readaddr,uint8_t readdata[], uint8_t len){
	bool bSuccess = false;

	// write to define register
	if (write(file, &readaddr, sizeof(readaddr)) == sizeof(readaddr)){
		// read back value
		if (read(file, readdata, len) == len){
			bSuccess = true;
		}
	}
	
		
	return bSuccess;
}


int main(int argc, char *argv[]){
	
	//////////////////////////////// VGA CODE ///////////////////////////////////
	void *virtual_base;
	int fd;
	/* int box_x1 = 260, box_y1 = 220, box_x2 = 310, box_y2 = 270;
	int prev_box_x1 = 0, prev_box_y1 = 0, prev_box_x2 = 0, prev_box_y2 = 0;
	int start_x = 286, start_y = 240;
	int center_x, center_y;
	int prev_center_x = start_x, prev_center_y = start_y; */

	if ((fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1) {
        printf("ERROR: could not open \"/dev/mem\"...\n");
        return(1);
    }

	virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);
    if (virtual_base == MAP_FAILED) {
        printf("ERROR: mmap() failed...\n");
        close(fd);
        return(1);
    }

	// Set framebuffer addr to beginning of the SRAM
    PHYSMEM_32(0xff203024) = 0xc8000000; // Pixel BackBuffer register
    PHYSMEM_32(0xff203020) = 0xc8000000; // Pixel Buffer register

	if (munmap(virtual_base, HW_REGS_SPAN) != 0) {
        printf("ERROR: munmap() failed...\n");
        close(fd);
        return(1);
    }

	virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_OCRAM_BASE);
    if (virtual_base == MAP_FAILED) {
        printf("ERROR: mmap() failed...\n");
        close(fd);
        return(1);
    }

	VGA_clear(virtual_base);
	//VGA_box(box_x1, box_y1, box_x2, box_y2, 0xFFFF, virtual_base);	// Initial box position

	// VGA_line(0, 0, 571, 479, 0xFFFF, virtual_base); // White diagonal from top-left to bottom-right
    // VGA_line(0, 479, 571, 0, 0xFFFF, virtual_base); // White diagonal from bottom-left to top-right
    // VGA_line(0, 240, 571, 240, 0xFFFF, virtual_base); // White horizontal line in the middle
    // VGA_line(286, 0, 286, 479, 0xFFFF, virtual_base); // White vertical line in the middle

	//////////////////////////////// GSENSOR CODE ///////////////////////////////////
	int file;
	const char *filename = "/dev/i2c-0";
	uint8_t id;
	bool bSuccess;
	//const int mg_per_digi = 4;
	uint16_t szXYZ[3];
	int cnt=0, max_cnt=0;
	
	printf("===== gsensor test =====\r\n");
	
	if (argc == 2){
		max_cnt = atoi(argv[1]);
	}
	
	// open bus
	if ((file = open(filename, O_RDWR)) < 0) {
  	  /* ERROR HANDLING: you can check errno to see what went wrong */
	    perror("Failed to open the i2c bus of gsensor");
  	  exit(1);
	}	
	

	// init	 
	// gsensor i2c address: 101_0011
	int addr = 0b01010011; 
	if (ioctl(file, I2C_SLAVE, addr) < 0) {
  	  printf("Failed to acquire bus access and/or talk to slave.\n");
	    /* ERROR HANDLING; you can check errno to see what went wrong */
  	  exit(1);
	}	
	

    // configure accelerometer as +-2g and start measure
    bSuccess = ADXL345_Init(file);
    if (bSuccess){
        // dump chip id
        bSuccess = ADXL345_IdRead(file, &id);
        if (bSuccess)
            printf("id=%02Xh\r\n", id);
    }        
    
    while(bSuccess && (max_cnt == 0 || cnt < max_cnt)){
        if (ADXL345_IsDataReady(file)){
            bSuccess = ADXL345_XYZ_Read(file, szXYZ);
            if (bSuccess){
				/* cnt++;
				int x_g = (int16_t)szXYZ[0]*mg_per_digi;
				int y_g = (int16_t)szXYZ[1]*mg_per_digi;
                printf("[%d]X=%d mg, Y=%d mg, Z=%d mg\r\n", cnt, x_g, y_g, (int16_t)szXYZ[2]*mg_per_digi);

				int move_amount = 20;

				if (x_g > 100 && box_x2 < 572) {
					box_x1 += move_amount;
					box_x2 += move_amount;
				} else if (x_g < -100 && box_x1 > 0) {
					box_x1 -= move_amount;
					box_x2 -= move_amount;
				}

				if (y_g > 100 && box_y1 > 0) {
					box_y1 -= move_amount;
					box_y2 -= move_amount;
				} else if (y_g < -100 && box_y1 < 480) {
					box_y1 += move_amount;
					box_y2 += move_amount;
				} */

				/* // Clear the previous box position only
				//VGA_box(prev_box_x1, prev_box_y1, prev_box_x2, prev_box_y2, 0x0000, virtual_base);

				// Draw the new box position
				//VGA_box(box_x1, box_y1, box_x2, box_y2, 0xFFFF, virtual_base);

				// Update the previous position for the next iteration
				prev_box_x1 = box_x1;
				prev_box_y1 = box_y1;
				prev_box_x2 = box_x2;
				prev_box_y2 = box_y2;

				// Clear the previous line position only
				//VGA_line(start_x, start_y, prev_center_x, prev_center_y, 0x0000, virtual_base);

				center_x = (box_x1 + box_x2) / 2;
				center_y = (box_y1 + box_y2) / 2;

				//VGA_line(start_x, start_y, center_x, center_y, 0xFFFF, virtual_base);

				// Update the previous position for the next line
				prev_center_x = center_x;
				prev_center_y = center_y; */
				
				Draw_Circle(200,200, 0xFFFF, virtual_base);

                usleep(50*1000);
            }
        }
    }
    
    if (!bSuccess)
        printf("Failed to access accelerometer\r\n");
	
	if (file)
		close(file);
			
	printf("gsensor, bye!\r\n");

	if (munmap(virtual_base, HW_REGS_SPAN) != 0) {
        printf("ERROR: munmap() failed...\n");
        close(fd);
        return(1);
    }			

	close(fd);
	return 0;
	
}