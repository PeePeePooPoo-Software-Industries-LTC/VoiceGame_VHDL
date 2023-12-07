
#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (0x3ff)

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

	int x = 0;
	while (1) {
//		alt_up_pixel_buffer_dma_draw_box(pixel_buffer, x, 200, x + 20, 220, 0, 0);

		x += 1;
		if (x == 620) {
			x = 0;
		}

		int normalized = x * BIT10_MAX / 620;

		alt_up_pixel_buffer_dma_draw_box(pixel_buffer, x, 200, x + 20, 220, RGB(normalized, BIT10_MAX - normalized, 0), 0);

		usleep(16000);
	}
}
