
#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "audio.h"
#include "graphics.h"
#include "images.h"
#include "io.h"

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (1023)

#define SCALE(n, input_max, output_max) (n * input_max / output_max)

void draw() {

}

int main() {
	vga_init();
	audio_init();

	int x = 0;
	int y = 0;
	while (1) {
		audio_fill_buffer();

		unsigned int input = IORD(BUTTON_PASSTHROUGH_BASE, 0);

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

		vga_draw_image(
			x, y,
			image_snake_headed_west_width, image_snake_headed_west_height,
			image_snake_headed_west_palette,
			image_snake_headed_west,
			IMAGE_snake_headed_west_MAX_BYTES
		);

		for (int x = 0; x < 300; x++) {
			int RAW = audio_data[x];

			if (RAW >= 0xffff / 2) {
				RAW = 0xffff - RAW;
			}

			int max_y = RAW * 200 / 0xffff * 2;

			vga_draw_vertical_line(x + 10, 10, max_y, RGB(BIT10_MAX, 0, 0));
		}

		vga_swap_buffers();
		vga_clear();
	}
	return 0;
}
