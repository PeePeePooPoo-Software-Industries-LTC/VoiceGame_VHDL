
#include <stdio.h>

#include "system.h"
#include "io.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"

//#define WRITE_SDRAM(offset, value) IOWR(NEW_SDRAM_CONTROLLER_0_BASE, offset, value);
//#define READ_SDRAM(offset) IORD(NEW_SDRAM_CONTROLLER_0_BASE, offset)

#define WRITE_SDRAM(offset, value) *(int*)(0x800000 + offset) = value;
#define READ_SDRAM(offset) (*(int*)0x800000 + offset)

#define VGA_WIDTH 640
#define VGA_HEIGHT 480

#define RGB(r, g, b) ((r << 20) | (g << 10) | b)

void update_screen();
void set_pixel_color(int x, int y, int color);

inline void set_pixel_color(int x, int y, int color) {
	WRITE_SDRAM(y * VGA_HEIGHT + x, color);
}

inline void update_screen() {
	int position = IORD(PIO_PIXEL_POSITION_BASE, 0);
//	int x = (position >> 16);
//	int y = position & 0xffff;

	IOWR(PIO_PIXEL_COLOR_BASE, 0, position);
//	IOWR(PIO_PIXEL_COLOR_BASE, 0, RGB(x, 0, 0));

//	IOWR(PIO_PIXEL_COLOR_BASE, 0, READ_SDRAM(y * VGA_HEIGHT + x));
}

int main() {
	alt_up_pixel_buffer_dma_dev* pixel_buffer = alt_up_pixel_buffer_dma_open_dev(VIDEO_PIXEL_BUFFER_DMA_0_NAME);
	if (pixel_buffer == NULL) {
		printf("Failed to open device\n");
	} else {
		printf("I am a god amongst men\n");
	}

	alt_up_pixel_buffer_dma_clear_screen(pixel_buffer, 0);
	alt_up_pixel_buffer_dma_draw(pixel_buffer, 0xffffffff, 5, 5);
	alt_up_pixel_buffer_dma_draw(pixel_buffer, 0xffffffff, 15, 5);

	alt_up_pixel_buffer_dma_draw_box(pixel_buffer, 0xffffffff, 200, 200, 250, 250, 0);

	while (1) {
//		IOWR(PIO_PIXEL_COLOR_BASE, 0, IORD(PIO_PIXEL_POSITION_BASE, 0));
//		update_screen();
	}
}
