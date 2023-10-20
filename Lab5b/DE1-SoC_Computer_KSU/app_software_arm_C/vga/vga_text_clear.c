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