
#include <stdio.h>

#include "graphics.h"

#include "io.h"
#include "system.h"

#define BYTE_TYPE_OFFSET 7
#define COLOR_FIRST_COL_OFFSET 4
#define COLOR_SECOND_COL_OFFSET 0
#define COLOR_COPY_OFFSET 3
#define RANGE_COL_OFFSET 0
#define RANGE_RANGE_OFFSET 3

VgaBuffer graphics_handle;

// Globals for increased performance
unsigned int x_coord_offset;
unsigned int y_coord_offset;
unsigned int back_buffer_addr;

int vga_init() {
	graphics_handle.device = alt_up_pixel_buffer_dma_open_dev(VIDEO_PIXEL_BUFFER_DMA_0_NAME);
	graphics_handle.current_buffer = 1;

	if (graphics_handle.device == NULL) {
		printf("Failed to open device\n");
		return 1;
	}
	printf(
		"VGA Setup (FRONT: %p) (BACK: %p)\n",
		(void*)graphics_handle.device->buffer_start_address,
		(void*)graphics_handle.device->back_buffer_start_address
	);

	x_coord_offset = graphics_handle.device->x_coord_offset;
	y_coord_offset = graphics_handle.device->y_coord_offset;
	back_buffer_addr = graphics_handle.device->back_buffer_start_address;
	return 0;
}

inline void vga_draw_vertical_line(int x, register int y, register int height, Color color) {
	while (height--) {
		vga_draw_pixel(x, y + height, color);
	}
}

inline void vga_draw_horizontal_line(int x, register int y, register int width, Color color) {
	while (width--) {
		vga_draw_pixel(x + width, y, color);
	}
}

inline void vga_swap_buffers() {
	alt_up_pixel_buffer_dma_swap_buffers(graphics_handle.device);
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(graphics_handle.device)) {};
	back_buffer_addr = graphics_handle.device->back_buffer_start_address;
}

inline void vga_draw_pixel(unsigned int x, unsigned int y, Color color) {
	IOWR_32DIRECT(
		back_buffer_addr,
		(x << x_coord_offset) | (y << y_coord_offset),
		color
	);
}

inline void vga_clear() {
	alt_up_pixel_buffer_dma_clear_screen(graphics_handle.device, graphics_handle.current_buffer);
}

// This function is quite slow
// Dunno why
void vga_draw_rect(register int x, register int y, int w, register int h, Color color) {
	register int max_x = x + w;
	register int max_y = y + h;
	register unsigned int write_to_register;

	for (; x < max_x; x++) {
		write_to_register = back_buffer_addr + (x << x_coord_offset);
		for (; y < max_y; y++) {
			IOWR_32DIRECT(
				write_to_register,
				y << y_coord_offset,
				color
			);
		}
		y -= h;
	}
}

void vga_draw_image(register int x, register int y, register unsigned char w, register unsigned int* palette, register unsigned char* image, unsigned int max_bytes) {
	register unsigned char offset_x = 0;
	for (register int idx = 0; idx < max_bytes; idx++) {
		register int byte = image[idx];
		// Case 1: RANGE_BYTE
		if (byte & (1 << BYTE_TYPE_OFFSET)) {
			unsigned char range = (byte & (0b1111 << RANGE_RANGE_OFFSET)) >> RANGE_RANGE_OFFSET;
			unsigned char col_idx = (byte & (0b111 << RANGE_COL_OFFSET)) >> RANGE_COL_OFFSET;
			// Save on creating an extra variable by reusing the range var
			for (; range > 0; range--)
			{
				vga_draw_pixel(x + offset_x, y, palette[col_idx]);
				offset_x++;
				if (offset_x == w) { offset_x = 0; y++; };
			}
		} else { // Case 2: COLOR_BYTE
			// Retrieve the colors & write to screen
			unsigned char col_idx_1 = (byte & (0b111 << COLOR_FIRST_COL_OFFSET)) >> COLOR_FIRST_COL_OFFSET;
			unsigned char col_idx_2 = (byte & (0b111 << COLOR_SECOND_COL_OFFSET)) >> COLOR_SECOND_COL_OFFSET;

			vga_draw_pixel(x + offset_x, y, palette[col_idx_1]);
			offset_x++;
			if (offset_x == w) { offset_x = 0; y++; };
			vga_draw_pixel(x + offset_x, y, palette[col_idx_2]);
			offset_x++;
			if (offset_x == w) { offset_x = 0; y++; };

			// If the copy bit is set, write again
			if (byte & (1 << COLOR_COPY_OFFSET)) {
				vga_draw_pixel(x + offset_x, y, palette[col_idx_1]);
				offset_x++;
				if (offset_x == w) { offset_x = 0; y++; };
				vga_draw_pixel(x + offset_x, y, palette[col_idx_2]);
				offset_x++;
				if (offset_x == w) { offset_x = 0; y++; };
			}
		}
	}
}

