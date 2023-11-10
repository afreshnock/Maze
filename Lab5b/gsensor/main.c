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
#include "VGA.h"
#include "Tiles.h"

#define HW_REGS_BASE (0xFC000000)
#define HW_OCRAM_BASE (0xC8000000)
#define HW_REGS_SPAN (0x04000000)
#define HW_REGS_MASK (HW_REGS_SPAN - 1)
#define FPGA_CHAR_BASE      0xC9000000

#define PHYSMEM_32(addr) (*((unsigned int *)(virtual_base + (addr & HW_REGS_MASK))))
#define PHYSMEM_16(addr) (*((unsigned short *)(virtual_base + (addr & HW_REGS_MASK))))




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

	//Gsensor
	int file;
	const char *filename = "/dev/i2c-0";
	uint8_t id;
	bool bSuccess;
	const int mg_per_digi = 4;
	uint16_t szXYZ[3];
	int cnt=0, max_cnt=0;

	printf("===== gsensor test =====\r\n");
	
	/* if (argc == 2){
		max_cnt = atoi(argv[1]);
	} */
	
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
	
	printf("Program running");
    VGA_clear(virtual_base);
    

	//initial circle coordinates
	int circle_x = 100;
	int circle_y = 100;
	int velocity_x = 0;
	int velocity_y = 0;
	int prev_circle_x, prev_circle_y;
	VGA_draw_circle(10,circle_x,circle_y, virtual_base); // Draw circle at center of screen

    DrawTiles(virtual_base);

    while(bSuccess && (max_cnt == 0 || cnt < max_cnt)){
        if (ADXL345_IsDataReady(file)){
            bSuccess = ADXL345_XYZ_Read(file, szXYZ);
            if (bSuccess){
				cnt++;
				int r = 10; // radius of the circle
				int x_g = (int16_t)szXYZ[0]*mg_per_digi;
				int y_g = (int16_t)szXYZ[1]*mg_per_digi;
                //printf("[%d]X=%d mg, Y=%d mg, Z=%d mg\r\n", cnt, x_g, y_g, (int16_t)szXYZ[2]*mg_per_digi);

				
				
				//printf(" circle x: %d \r\n", circle_x);

				
				//int move_amount = 5;	// movement speed

				if (x_g > 125 && circle_x < 635 - r) {
					circle_x += (x_g/100);
					velocity_x += (x_g/100);
				} 
				
				else if (x_g < -125 && circle_x > 0 + r) {
					circle_x -= -(x_g/100);
					velocity_x -= -(x_g/100);
				}
				
				else if (x_g > -125 && x_g < 125 && circle_x < 635 -r && circle_x > 0 + r)
				{
					if(velocity_x > 1)
					{
						circle_x += 2;
						velocity_x -= 3;
					}
					else if(velocity_x < -1)
					{
						circle_x -= 2;
						velocity_x += 3;
					}
					printf("velocity_x: %d\r\n",velocity_x);
				}

				
				if (y_g > 100 && circle_y > 0 + r) {
					circle_y -= (y_g/100);
					velocity_y -= -(y_g/100);
				} 
				else if (y_g < -100 && circle_y < 475 - r) {
					circle_y += -(y_g/100);
					velocity_y += (y_g/100);
				}
				
				else if (y_g > -100 && y_g < 100 && circle_y > 0 +r && circle_y < 475 -r)
				{
					if(velocity_y > 1)
					{
						circle_y += 2;
						velocity_y -= 3;
					}
					else if(velocity_y < -1)
					{
						circle_y -= 2;
						velocity_y += 3;
					}
					printf("velocity_y: %d\r\n",velocity_y);
				}
				
				

				// Clear the previous circle position only
				VGA_clear_circle(r,prev_circle_x, prev_circle_y,virtual_base);

				// Draw the new box position
				VGA_draw_circle(r,circle_x,circle_y,virtual_base);
				
				//printf("prev x - new x:%d \r\n",(prev_circle_x - circle_x)); 
				// Update the previous position for the next iteration
				prev_circle_x = circle_x;
				prev_circle_y = circle_y;

				

                usleep(50*1000); //sleep for 50 ms
            }
        }
    }

    if (munmap(virtual_base, HW_REGS_SPAN) != 0) {
        printf("ERROR: munmap() failed...\n");
        close(fd);
        return(1);
    }

    close(fd);
    return 0;
}