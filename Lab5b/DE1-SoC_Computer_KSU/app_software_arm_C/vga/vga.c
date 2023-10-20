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
    VGA_box(0, 0, 572, 480, 0x0000, virtual_base); // Black //640
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

int main(int argc,char ** argv) {
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

    VGA_line(0, 0, 571, 479, 0xFFFF, virtual_base); // White diagonal from top-left to bottom-right //639
    VGA_line(0, 479, 571, 0, 0xFFFF, virtual_base); // White diagonal from bottom-left to top-right
    VGA_line(0, 240, 571, 240, 0xFFFF, virtual_base); // White horizontal line in the middle
    VGA_line(286, 0, 286, 479, 0xFFFF, virtual_base); // White vertical line in the middle // 320

    if (munmap(virtual_base, HW_REGS_SPAN) != 0) {
        printf("ERROR: munmap() failed...\n");
        close(fd);
        return(1);
    }

    close(fd);
    return(0);
}
