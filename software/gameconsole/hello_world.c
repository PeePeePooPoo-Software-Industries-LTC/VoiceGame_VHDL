
#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "audio.h"
#include "graphics.h"
#include "io.h"

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (1023)

#define SCALE(n, input_max, output_max) (n * input_max / output_max)

void draw() {

}

int main() {
	vga_init();
	audio_init();

	// AUTO-GENERATED IMAGE CONVERTED FROM: frogge.png
	unsigned char image_frogge_width = 20;
	unsigned char image_frogge_height = 20;
	unsigned int image_frogge_palette[8] = {
		0x0fc3f0ff, 0x0741904f, 0x0003503c, 0x0c0320a9, 0x00000000, 0x0640a092, 0x03026024, 0x00000000,
	};
	unsigned char image_frogge[108] = {
		0xf8, 0xf8, 0xf8, 0xf8, 0xf8, 0xc8, 0xa1, 0xa0, 0xa1, 0xb8, 0x12,
		0x9a, 0x10, 0x01, 0xa2, 0x10, 0xa8, 0x13, 0x32, 0x92, 0x91,
		0x9a, 0x93, 0x10, 0xa0, 0x12, 0x34, 0xc2, 0x43, 0x21, 0x98,
		0x12, 0x23, 0x42, 0xba, 0x43, 0x92, 0x10, 0x01, 0x25, 0x52,
		0xca, 0x95, 0x21, 0x98, 0x15, 0x52, 0xca, 0x95, 0x10, 0xa0,
		0x12, 0x62, 0xba, 0x62, 0x10, 0xa8, 0x12, 0x26, 0xbe, 0x92,
		0x10, 0xa0, 0x12, 0x9a, 0xb3, 0xa2, 0x10, 0x98, 0x12, 0xa2,
		0xa3, 0xaa, 0x10, 0x90, 0x12, 0x26, 0xd2, 0x62, 0x21, 0x90,
		0x12, 0x92, 0x62, 0xba, 0x62, 0x92, 0x10, 0x90, 0x12, 0x92,
		0x62, 0xaa, 0x62, 0x92, 0x10, 0x98, 0x12, 0x92, 0x62, 0xaa,
		0x62, 0x92, 0x10, 0x90, 0xf9, 0x99, 0x88,
	};


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

		vga_draw_image(x, y, 20, 20, image_frogge_palette, image_frogge, 108);

//		vga_draw_rect(x, y, 20, 20, RGB(BIT10_MAX - (normalized_x + normalized_y) / 2, normalized_x, normalized_y));

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

			vga_draw_vertical_line(x + 10, 10, max_y, RGB(BIT10_MAX, 0, 0));
		}

		vga_swap_buffers();
		vga_clear();
	}
	return 0;
}
