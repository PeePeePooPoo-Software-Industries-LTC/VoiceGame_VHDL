
#ifndef __GRAPHIC_H__
#define __GRAPHIC_H__

#include "altera_up_avalon_video_pixel_buffer_dma.h"

typedef int Color;
typedef struct {
	alt_up_pixel_buffer_dma_dev* device;
	unsigned int current_buffer;
} VgaBuffer;

int vga_init();
void vga_swap_buffers();
void vga_clear();
void vga_draw_pixel(int x, int y, Color);
void vga_draw_rect(int x, int y, int w, int h, Color);
void vga_draw_vertical_line(int x, int y, int height, Color color);
void vga_draw_image(int x, int y, unsigned char w, unsigned char h, unsigned int* palette, unsigned char* image, unsigned int max_bytes);

#endif
