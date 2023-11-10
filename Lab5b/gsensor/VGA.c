
#define PHYSMEM_16(addr) (*((unsigned short *)(virtual_base + (addr & HW_REGS_MASK))))
#define HW_OCRAM_BASE (0xC8000000)
#define HW_REGS_SPAN (0x04000000)
#define HW_REGS_MASK (HW_REGS_SPAN - 1)

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

void VGA_draw_circle(int radius,int x, int y, void* virtual_base){
    int r = radius;
    for (r = radius; r > 0; r--)
    {
        VGA_circle(x, y, r, 0xFFFF, virtual_base); // Draw circle at center of screen
    }
}

void VGA_clear_circle(int radius,int x, int y, void* virtual_base){
	int r = radius;
    for (r = radius; r > 0; r--)
    {
        VGA_circle(x, y, r, 0x0000, virtual_base); // Clear circle
    }
}

void VGA_box(int x1, int y1, int x2, int y2, short pixel_color, void *virtual_base) {
    unsigned int pixel_ptr, row, col;

    for (row = y1; row <= y2; row++) {
        for (col = x1; col <= x2; ++col) {
            pixel_ptr = HW_OCRAM_BASE + (row << 10) + col;
            PHYSMEM_16(pixel_ptr) = pixel_color; // set pixel color
        }
    }
}