#include <stdio.h>
#include <stdlib.h>
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

struct Snake
{
	int length_in_rect;
	int length;
	int width;
	int headX, headY;
};

int apple_cords[4]; //[0] = x1, [1] = x2, [2] = y1, [3] = y2

struct Snake test_snake;

void vga_swap_buffers(VgaBuffer* buff);
void vga_clear(VgaBuffer* buff);
void vga_draw_pixel(VgaBuffer* buff, int x, int y, Color);
void vga_draw_rect(VgaBuffer* buff, int x, int y, int w, int h, Color);
void spawn_apple();
void grow_snake();


int main() {
	VgaBuffer vga_buffer = {
		alt_up_pixel_buffer_dma_open_dev(VIDEO_PIXEL_BUFFER_DMA_0_NAME),
		1
	};
	if (vga_buffer.device == NULL) {
		printf("Failed to open device\n");
		return 1;
	}

//	alt_up_pixel_buffer_dma_clear_screen(vga_buffer.device, 0);
//	alt_up_pixel_buffer_dma_clear_screen(vga_buffer.device, 1);

	struct Snake test_snake;

	printf(
		"Addresses (FRONT: %p) (BACK: %p)",
		vga_buffer.device->buffer_start_address,
		vga_buffer.device->back_buffer_start_address
	);

	int x = 0;
	int y = 0;
	while (1) {
		unsigned int input = IORD(BUTTON_PASSTHROUGH_BASE, 0);

//		vga_draw_rect(&vga_buffer, x, y, 20, 20, 0);

		int speed = 5;

		x += ((input & 0x1) >> 0) * speed;
		x -= ((input & 0x2) >> 1) * speed;
		y += ((input & 0x4) >> 2) * speed;
		y -= ((input & 0x8) >> 3) * speed;

		if (x > 300) {
			x = 0;
		}
		if (x < 0) {
			x = 300;
		}
		if (y > 220) {
			y = 0;
		}
		if (y < 0) {
			y = 220;
		}

		int normalized_x = x * BIT10_MAX / 300;
		int normalized_y = y * BIT10_MAX / 220;

		vga_draw_rect(&vga_buffer, x, y, 20, 20, RGB(BIT10_MAX - (normalized_x + normalized_y) / 2, normalized_x, normalized_y));

		for(int i = 0; i < 9999999; i++)
		{
			SpawnApple();
		}

		vga_swap_buffers(&vga_buffer);
	}
	return 0;
}

inline void vga_swap_buffers(VgaBuffer* buff) {
	alt_up_pixel_buffer_dma_swap_buffers(buff->device);
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(buff->device)) {};
	vga_clear(buff);
}

inline void vga_draw_pixel(VgaBuffer* buff, int x, int y, Color color) {
	alt_up_pixel_buffer_dma_draw(buff->device, x, y, color);
}

inline void vga_clear(VgaBuffer* buff) {
	alt_up_pixel_buffer_dma_clear_screen(buff->device, buff->current_buffer);
}

inline void vga_draw_rect(VgaBuffer* buff, int x, int y, int w, int h, Color color) {
	alt_up_pixel_buffer_dma_draw_box(buff->device, x, y, x + w, y + h, color, buff->current_buffer);
}

void draw() {

}

void spawn_apple()
{
	int randX = rand() % 315;
	int randY = rand() % 235;
	vga_draw_rect(&vga_buffer, randX, randY, 5, 5, RGB(1023, 0, 0));
	vga_draw_rect(&vga_buffer, randX + 2, randY - 4, 1, 4, RGB(600, 300, 0));
}

void grow_snake(struct test_snake)
{
	test_snake.length_in_rect++;
	test_snake.length = test_snake.length * test_snake.length_in_rect;

}

