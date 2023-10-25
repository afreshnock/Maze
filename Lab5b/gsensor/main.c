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
#include <linux/i2c-dev.h>
#include "hwlib.h"
#include "ADXL345.h"

#define HW_REGS_BASE (0xFC000000)
#define HW_OCRAM_BASE (0xC8000000)
#define HW_REGS_SPAN (0x04000000)
#define HW_REGS_MASK (HW_REGS_SPAN - 1)
#define FPGA_CHAR_BASE      0xC9000000

#define PHYSMEM_32(addr) (*((unsigned int *)(virtual_base + (addr & HW_REGS_MASK))))
#define PHYSMEM_16(addr) (*((unsigned short *)(virtual_base + (addr & HW_REGS_MASK))))

void VGA_pixel(int x, int y, short pixel_color, void* virtual_base) {
    unsigned int pixel_ptr = HW_OCRAM_BASE + (y << 10) + x;
    PHYSMEM_16(pixel_ptr) = pixel_color; // Set pixel color
}

void VGA_clear(void* virtual_base) {
    int x,y;
    for (y = 0; y < 480; y++) {
        for (x = 0; x < 640; x++) {
            VGA_pixel(x, y, 0x0000, virtual_base); // Black
        }
    }
}

void VGA_circle(int x0, int y0, int radius, short pixel_color, void* virtual_base) {
    int x = radius;
    int y = 0;
    int radiusError = 1 - x;

    while (x >= y) {
        VGA_pixel(x + x0, y + y0, pixel_color, virtual_base);
        VGA_pixel(y + x0, x + y0, pixel_color, virtual_base);
        VGA_pixel(-x + x0, y + y0, pixel_color, virtual_base);
        VGA_pixel(-y + x0, x + y0, pixel_color, virtual_base);
        VGA_pixel(-x + x0, -y + y0, pixel_color, virtual_base);
        VGA_pixel(-y + x0, -x + y0, pixel_color, virtual_base);
        VGA_pixel(x + x0, -y + y0, pixel_color, virtual_base);
        VGA_pixel(y + x0, -x + y0, pixel_color, virtual_base);
        y++;
        if (radiusError < 0) {
            radiusError += 2 * y + 1;
        }
        else {
            x--;
            radiusError += 2 * (y - x + 1);
        }
    }
}

void VGA_draw_circle(int radius, void* virtual_base){
    int r = radius;
    for (r = radius; r > 0; r--)
    {
        VGA_circle(320, 240, r, 0xFFFF, virtual_base); // Draw circle at center of screen
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

int main() {
	void *virtual_base;
	int fd;

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
    VGA_draw_circle(10, virtual_base); // Draw circle at center of screen


    if (munmap(virtual_base, HW_REGS_SPAN) != 0) {
        printf("ERROR: munmap() failed...\n");
        close(fd);
        return(1);
    }

    close(fd);
    return 0;
}
