#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "io.h"

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (1023)

#define SCALE(n, input_max, output_max) (n * input_max / output_max)


typedef int Color;
typedef struct VgaBuffer_t {
	alt_up_pixel_buffer_dma_dev* device;
	unsigned int current_buffer;
} VgaBuffer;

void vga_swap_buffers(VgaBuffer* buff);
void vga_clear(VgaBuffer* buff);
void vga_draw_pixel(VgaBuffer* buff, int x, int y, Color);
void vga_draw_rect(VgaBuffer* buff, int x, int y, int w, int h, Color);

inline void vga_swap_buffers(VgaBuffer* buff) {
	alt_up_pixel_buffer_dma_swap_buffers(buff->device);
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(buff->device)) {};
	vga_clear(buff);
}

inline void vga_draw_pixel(VgaBuffer* buff, int x, int y, Color color) {
	alt_up_pixel_buffer_dma_draw(buff->device, color, x, y);
}

inline void vga_clear(VgaBuffer* buff) {
	alt_up_pixel_buffer_dma_clear_screen(buff->device, buff->current_buffer);
}

inline void vga_draw_rect(VgaBuffer* buff, int x, int y, int w, int h, Color color) {
	alt_up_pixel_buffer_dma_draw_box(buff->device, x, y, x + w, y + h, color, buff->current_buffer);
}

void draw() {

}


int main() {
	VgaBuffer vga_buffer = {
		alt_up_pixel_buffer_dma_open_dev(VIDEO_PIXEL_BUFFER_DMA_0_NAME),
		1
	};
	if (vga_buffer.device == NULL) {
		printf("Failed to open device\n");
		return 1;
	}
	void SpawnApple()
	{
	    int randX = rand() % 314;
	    int randY = rand() % 231 +3;
	    vga_draw_rect(&vga_buffer, randX, randY, 6, 6, RGB(1023, 0, 0));
	    vga_draw_rect(&vga_buffer, randX +3, randY - 3, 0, 2, RGB(600, 300, 0));
	}

	int x = 0;
	int y = 0;
	int stepSize = 8;


	void move_snake(unsigned int input)
	{

		x += ((input & 0x1) >> 0) * stepSize;
		x -= ((input & 0x2) >> 1) * stepSize;
		y += ((input & 0x4) >> 2) * stepSize;
		y -= ((input & 0x8) >> 3) * stepSize;
		if (x > 312) {
			x = 0;
		}
		if (x < 0) {
			x = 312;
		}
		if (y > 232) {
			y = 0;
		}
		if (y < 0) {
			y = 232;
		}

		vga_draw_rect(&vga_buffer, x, y, 8, 8, RGB(0, 1023, 0));

		if(input & 0x1 && !(input & 0x2 || input & 0x4 || input & 0x8)){
			vga_draw_rect(&vga_buffer, x+6, y+2, 0, 0, RGB(1023, 0, 0));
			vga_draw_rect(&vga_buffer, x+6, y+6, 0, 0, RGB(1023, 0, 0));
		}
		if(input & 0x2 && !(input & 0x1 || input & 0x4 || input & 0x8)){
			vga_draw_rect(&vga_buffer, x+2, y+2, 0, 0, RGB(1023, 0, 0));
			vga_draw_rect(&vga_buffer, x+2, y+6, 0, 0, RGB(1023, 0, 0));
		}
		if(input & 0x4 && !(input & 0x2 || input & 0x1 || input & 0x8)){
			vga_draw_rect(&vga_buffer, x+6, y+6, 0, 0, RGB(1023, 0, 0));
			vga_draw_rect(&vga_buffer, x+2, y+6, 0, 0, RGB(1023, 0, 0));
		}
		if(input & 0x8 && !(input & 0x2 || input & 0x4 || input & 0x1)){
			vga_draw_rect(&vga_buffer, x+6, y+2, 0, 0, RGB(1023, 0, 0));
			vga_draw_rect(&vga_buffer, x+2, y+2, 0, 0, RGB(1023, 0, 0));
		}
	}

//	alt_up_pixel_buffer_dma_clear_screen(vga_buffer.device, 0);
//	alt_up_pixel_buffer_dma_clear_screen(vga_buffer.device, 1);

	printf(
		"Addresses (FRONT: %p) (BACK: %p)",
		vga_buffer.device->buffer_start_address,
		vga_buffer.device->back_buffer_start_address
	);


	while (1) {

//		dingen
//		vga_draw_rect(&vga_buffer, x, y, 20, 20, 0);
//		int normalized_x = x * BIT10_MAX / 300;
//		int normalized_y = y * BIT10_MAX / 220;
//
//		vga_draw_rect(&vga_buffer, x, y, 20, 20, RGB(BIT10_MAX - (normalized_x + normalized_y) / 2, normalized_x, normalized_y));
//		vga_draw_rect(&vga_buffer, 10, 60, 300, 0, RGB(1023,1023,1023));
//		vga_draw_rect(&vga_buffer, 10, 120, 300, 0, RGB(1023,1023,1023));
//		vga_draw_rect(&vga_buffer, 10, 180, 300, 0, RGB(1023,1023,1023));
//		vga_draw_rect(&vga_buffer, 10, 0, 0, 240, RGB(1023,1023,1023));
//		vga_draw_rect(&vga_buffer, 70, 0, 0, 240, RGB(1023,1023,1023));
//		vga_draw_rect(&vga_buffer, 130, 0, 0, 240, RGB(1023,1023,1023));
//		vga_draw_rect(&vga_buffer, 190, 0, 0, 240, RGB(1023,1023,1023));
//		vga_draw_rect(&vga_buffer, 250, 0, 0, 240, RGB(1023,1023,1023));
//		vga_draw_rect(&vga_buffer, 310, 0, 0, 240, RGB(1023,1023,1023));

		for(int i =0; i<699999; i++){

		}

		unsigned int input = IORD(BUTTON_PASSTHROUGH_BASE, 0);

		move_snake(input);
//		SpawnApple();

		vga_swap_buffers(&vga_buffer);
	}
	return 0;
}
