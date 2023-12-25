/**
 * @file
 * @brief The graphics driver for the VGA screen configured for the VoiceGame project.
 *
 * Do **NOT** use the internal device drivers and this module at the same time.
 * In general, you should use this module over the internal device drivers, as
 * this module exposes some higher level functions with better performance.
 */

#ifndef __GRAPHIC_H__
#define __GRAPHIC_H__

#include "altera_up_avalon_video_pixel_buffer_dma.h"

typedef int Color;
typedef struct {
	alt_up_pixel_buffer_dma_dev* device; /** The VGA device driver, set automatically by vga_init() */
	unsigned int current_buffer; /** The backbuffer number to render too. Mostly ignored. Set automatically by vga_init() */
} VgaBuffer;

/**
 * Initializes the VGA driver.
 *
 * Using any other function in this module will be undefined and most likely result into crashes.
 *
 * @return 0 - For success
 * @return 1 - Failed to open VGA device
 */
int vga_init();

void vga_swap_buffers();
void vga_clear();
void vga_draw_pixel(unsigned int x, unsigned int y, Color);
void vga_draw_rect(int x, int y, int w, int h, Color);
void vga_draw_vertical_line(int x, int y, int height, Color color);
void vga_draw_image(int x, int y, unsigned char w, unsigned int* palette, unsigned char* image, unsigned int max_bytes);
unsigned char vga_contains_transparent_pixels(unsigned int* palette, unsigned char* image, unsigned int max_bytes, Color mask);
void vga_draw_transparent_pixel(unsigned int x, unsigned int y, Color color, Color mask);
void vga_draw_transparent_image(int x, int y, unsigned char w, unsigned int* palette, unsigned char* image, unsigned int max_bytes, Color mask);

#endif
