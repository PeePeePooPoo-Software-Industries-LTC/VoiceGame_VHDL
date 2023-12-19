
#include <stdio.h>

#include "graphics.h"

#include "system.h"

#define BYTE_TYPE_OFFSET 7
#define COLOR_FIRST_COL_OFFSET 4
#define COLOR_SECOND_COL_OFFSET 0
#define COLOR_COPY_OFFSET 3
#define RANGE_COL_OFFSET 0
#define RANGE_RANGE_OFFSET 3

VgaBuffer graphics_handle;

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
	return 0;
}

inline void vga_draw_vertical_line(int x, int y, int height, Color color) {
	alt_up_pixel_buffer_dma_draw_vline(graphics_handle.device, x, y, y + height, color, graphics_handle.current_buffer);
}

inline void vga_swap_buffers() {
	alt_up_pixel_buffer_dma_swap_buffers(graphics_handle.device);
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(graphics_handle.device)) {};
	vga_clear();
}

inline void vga_draw_pixel(int x, int y, Color color) {
	alt_up_pixel_buffer_dma_draw(graphics_handle.device, color, x, y);
}

inline void vga_clear() {
	alt_up_pixel_buffer_dma_clear_screen(graphics_handle.device, graphics_handle.current_buffer);
}

inline void vga_draw_rect(int x, int y, int w, int h, Color color) {
	alt_up_pixel_buffer_dma_draw_box(graphics_handle.device, x, y, x + w, y + h, color, graphics_handle.current_buffer);
}

void vga_draw_image(register int x, register int y, register unsigned char w, unsigned char h, register unsigned int* palette, register unsigned char* image, register unsigned int max_bytes) {
	register unsigned char start_x = x;
	for (register int idx = 0; idx < max_bytes; idx++) {
		register int byte = image[idx];
		// Case 1: RANGE_BYTE
		if (byte & (1 << BYTE_TYPE_OFFSET)) {
			unsigned char range = (byte & (0b1111 << RANGE_RANGE_OFFSET)) >> RANGE_RANGE_OFFSET;
			unsigned char col_idx = (byte & (0b111 << RANGE_COL_OFFSET)) >> RANGE_COL_OFFSET;
			// Save on creating an extra variable by reusing the range var
			for (; range > 0; range--)
			{
				vga_draw_pixel(x, y, palette[col_idx]);
				x++;
				if (x - start_x == w) { x = start_x; y++; };
			}
		} else { // Case 2: COLOR_BYTE
			// Retrieve the colors & write to screen
			unsigned char col_idx_1 = (byte & (0b111 << COLOR_FIRST_COL_OFFSET)) >> COLOR_FIRST_COL_OFFSET;
			unsigned char col_idx_2 = (byte & (0b111 << COLOR_SECOND_COL_OFFSET)) >> COLOR_SECOND_COL_OFFSET;

			vga_draw_pixel(x, y, palette[col_idx_1]);
			x++;
			if (x - start_x == w) { x = start_x; y++; };
			vga_draw_pixel(x, y, palette[col_idx_2]);
			x++;
			if (x - start_x == w) { x = start_x; y++; };

			// If the copy bit is set, write again
			if (byte & (1 << COLOR_COPY_OFFSET)) {
				vga_draw_pixel(x, y, palette[col_idx_1]);
				x++;
				if (x == w) { x = start_x; y++; };
				vga_draw_pixel(x, y, palette[col_idx_2]);
				x++;
				if (x == w) { x = start_x; y++; };
			}
		}
	}
}

