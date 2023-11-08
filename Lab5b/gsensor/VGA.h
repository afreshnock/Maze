
void VGA_pixel(int x, int y, short pixel_color, void* virtual_base);
void VGA_clear(void* virtual_base);
void VGA_circle(int x0, int y0, int radius, short pixel_color, void* virtual_base);
void VGA_draw_circle(int radius,int x, int y, void* virtual_base);
void VGA_clear_circle(int radius,int x, int y, void* virtual_base);
void VGA_box(int x1, int y1, int x2, int y2, short pixel_color, void *virtual_base);