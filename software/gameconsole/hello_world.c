
#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "altera_up_avalon_audio_and_video_config_regs.h"
#include "altera_up_avalon_audio_and_video_config.h"
#include "altera_up_avalon_audio.h"
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

	alt_up_av_config_dev* config_device = alt_up_av_config_open_dev(AUDIO_AND_VIDEO_CONFIG_0_NAME);
	if (config_device == NULL) {
		printf("Failed to open config device\n");
		return 1;
	}

	alt_up_audio_dev* audio_device = alt_up_audio_open_dev(AUDIO_0_NAME);
	if (config_device == NULL) {
		printf("Failed to open config device\n");
		return 1;
	}

	printf("Is Ready? %d\n", alt_up_av_config_read_ready(config_device));
	printf("Is Ack? %d\n", alt_up_av_config_read_acknowledge(config_device));
	printf("###\n");

	alt_up_av_config_reset(config_device);
	printf("Is Ready? %d\n", alt_up_av_config_read_ready(config_device));
	printf("Is Ack? %d\n", alt_up_av_config_read_acknowledge(config_device));

	printf("Configured audio\n");

	printf("Is Ready? %d\n", alt_up_av_config_read_ready(config_device));
	printf("Is Ack? %d\n", alt_up_av_config_read_acknowledge(config_device));
	printf("---\n");

	alt_up_av_config_reset(config_device);
//	alt_up_av_config_write_audio_cfg_register(config_device, 0b00001111, 0b00000000);
//	alt_up_av_config_write_audio_cfg_register(config_device, AUDIO_REG_ANALOG_AUDIO_PATH_CTRL, 0b00000110);
//	alt_up_av_config_write_audio_cfg_register(config_device, AUDIO_REG_ANALOG_AUDIO_PATH_CTRL, 0b00100110);
//	alt_up_av_config_write_audio_cfg_register(config_device, AUDIO_REG_DIGITAL_AUDIO_PATH_CTRL, 0b00001001);
//	alt_up_av_config_write_audio_cfg_register(config_device, AUDIO_REG_POWER_DOWN_CTRL, 0b00001001);
//	alt_up_av_config_write_audio_cfg_register(config_device, AUDIO_REG_AUDIO_DIGITAL_INTERFACE, 0b01000001);
//	alt_up_av_config_write_audio_cfg_register(config_device, AUDIO_REG_SAMPLING_CTRL, 0b00001100);
//	alt_up_av_config_write_audio_cfg_register(config_device, AUDIO_REG_ACTIVE_CTRL, 0b00000001);

	printf("Is Ready? %d\n", alt_up_av_config_read_ready(config_device));
	printf("Is Ack? %d\n", alt_up_av_config_read_acknowledge(config_device));

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

		unsigned int buffer_data[128] = {0};
		unsigned int available_l = alt_up_audio_read_fifo_avail(audio_device, 0);
		alt_up_audio_record_l(audio_device, buffer_data, available_l);

		printf("AV(%d) HEAD(%d)\n", available_l, alt_up_audio_read_fifo_head(audio_device, 0));
		for (int x = 0; x < available_l; x++) {
			int max_y = buffer_data[x] * 200 / 65535;
			for (int y = 0; y < max_y; y++) {
				vga_draw_rect(&vga_buffer, x, y, 0, 0, RGB(BIT10_MAX, 0, 0));
			}
		}

		vga_swap_buffers(&vga_buffer);
	}
	return 0;
}
