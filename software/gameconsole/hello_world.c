
#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "audio.h"
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
void vga_draw_vertical_line(VgaBuffer* buff, int x, int y, int height, Color color);

inline void vga_draw_vertical_line(VgaBuffer* buff, int x, int y, int height, Color color) {
	alt_up_pixel_buffer_dma_draw_vline(buff->device, x, y, y + height, color, buff->current_buffer);
}

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
	printf(
		"VGA Setup (FRONT: %p) (BACK: %p)\n",
		vga_buffer.device->buffer_start_address,
		vga_buffer.device->back_buffer_start_address
	);

	audio_init();

	int x = 0;
	int y = 0;
	while (1) {
		audio_fill_buffer();

		unsigned int input = IORD(BUTTON_PASSTHROUGH_BASE, 0);

//		vga_draw_rect(&vga_buffer, x, y, 20, 20, 0);

		int speed = 5;

		unsigned int sum = 0;
		unsigned int counted = 0;
		for (int i = 0; i < AUDIO_BUFFER_SIZE; i++) {
			int data = audio_data[i];
			if (data < 0xffff / 6) {
				sum += data;
				counted++;
			}

		}
		sum /= counted;

		speed = 5 + sum * 25 / (0xffff / 6);

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

		for (int x = 0; x < 300; x++) {
			int RAW = audio_data[x];

			if (RAW >= 0xffff / 2) {
				RAW = 0xffff - RAW;
			}

			int max_y = RAW * 200 / 0xffff * 2;

//			for (int y = 0; y < max_y; y++) {
//				int val = y * 5;
//				vga_draw_pixel(&vga_buffer, x + 10, y + 10, RGB(BIT10_MAX - val, 0, val));
//			}

			vga_draw_vertical_line(&vga_buffer, x + 10, 10, max_y, RGB(BIT10_MAX, 0, 0));
		}

		vga_swap_buffers(&vga_buffer);
	}
	return 0;
}
