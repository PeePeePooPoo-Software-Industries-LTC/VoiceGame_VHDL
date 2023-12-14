#include <stdio.h>
#include <unistd.h>

#include "system.h"
#include "io.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_audio.h"
#include "altera_up_avalon_audio_and_video_config.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"

//#define WRITE_SDRAM(offset, value) *(NEW_SDRAM_CONTROLLER_0_BASE + offset) = value;
//#define READ_SDRAM(offset) (*(NEW_SDRAM_CONTROLLER_0_BASE + offset))
//
//
//int main() {
//	alt_up_audio_dev * audio_dev;
//	/* used for audio record/playback */
//	unsigned int l_buf;
//	unsigned int r_buf;
//	// open the Audio port
//	audio_dev = alt_up_audio_open_dev ("/dev/audio_0");
//	if ( audio_dev == NULL)
//	printf("Error: could not open audio device \n");
//	else
//	printf ("Opened audio device \n");
//	/* read and echo audio data */
//	while(1)
//	{
//	int fifospace = alt_up_audio_read_fifo_avail (audio_dev, ALT_UP_AUDIO_RIGHT);
//	if ( fifospace > 0 ) // check if data is available
//	{
//	// read audio buffer
//	alt_up_audio_read_fifo (audio_dev, &(r_buf), 1, ALT_UP_AUDIO_RIGHT);
//	alt_up_audio_read_fifo (audio_dev, &(l_buf), 1, ALT_UP_AUDIO_LEFT);
//	// write audio buffer
//	alt_up_audio_write_fifo (audio_dev, &(r_buf), 1, ALT_UP_AUDIO_RIGHT);
//	alt_up_audio_write_fifo (audio_dev, &(l_buf), 1, ALT_UP_AUDIO_LEFT);
//	}
//	}
////	alt_irq_init(0);
////
////	alt_irq_register(
////		PIO_REQUEST_IRQ,
////		0,
////		return_color_irq
////	);
////
////	int position = IORD(PIO_PIXEL_POSITION_BASE, 0);
////	printf("(%u, %u)\n", position >> 16, position & 0xffff);
////	IOWR(PIO_PIXEL_COLOR_BASE, 0, 0x00ffff03);
////	printf("why\n");
////
////	int prev_value = IORD(PIO_REQUEST_BASE, 0);
////	while (1) {
////		int current_value = IORD(PIO_REQUEST_BASE, 0);
////
//////		printf("%i\n", current_value);
////
//////		if (current_value == 1) {
//////			printf("You should INTERRUPT yourself NOW!\n");
//////		}
////		if (prev_value != current_value) {
////			prev_value = current_value;
////			return_color_irq(0, PIO_REQUEST_IRQ);
////			printf("Current: %i\n", current_value);
////		}
////	}
//}
int main() {
#define BUFFER_MAX_SIZE 128

alt_up_av_config_dev* config_device = alt_up_av_config_open_dev("/dev/audio_and_video_config_0"); // Open config device
alt_up_audio_dev* device = alt_up_audio_open_dev("/dev/audio_0"); // open audio device

if(config_device != NULL) {
	printf("Config device opened.\n");
}
if(device != NULL) {
	printf("Audio device opened.\n");
}

// Test clear FIFO buffers for audio.
printf("Config reset returned %i\n", alt_up_av_config_reset(config_device));
//printf("Audio  reset returned %i\n", alt_up_audio_reset_audio_core(device));

usleep(500000);

printf("Config Acknowledge: %i\n",alt_up_av_config_read_acknowledge(config_device));
printf("Config ready: %i\n",alt_up_av_config_read_ready(config_device));

int check = alt_up_av_config_write_audio_cfg_register(config_device,0b0001001,1);
if(!check) {
	printf("Chip activation successful\n");
} else {
	printf("Chip activation failed.\n");
}

while (1) {
	unsigned int input = IORD(BUTTON_PASSTHROUGH_BASE, 0);
  // Wait until a button is pressed or something
	//printf("%i\n",*(int*)BUTTON_PASSTHROUGH_BASE);

	// Activate the CODEC Chip
	// Byte: 0001001 - 0 - 1

	while(!(input & 0x10)) {input = IORD(BUTTON_PASSTHROUGH_BASE, 0);}; // Wait until a switch is held down
	printf("FIFO can read from left buffer: %d\n", alt_up_audio_read_fifo_avail(device, ALT_UP_AUDIO_LEFT)); // Print available bytes

	unsigned int left_available = alt_up_audio_read_fifo_avail(device, ALT_UP_AUDIO_LEFT); // Read how many bytes can be read
	unsigned int left_buffer[BUFFER_MAX_SIZE] = {0}; // Buffer for the audio to receive
	alt_up_audio_record_l(device, &left_buffer, left_available); // Read bytes into buffer

	unsigned int right_available = alt_up_audio_read_fifo_avail(device, 1); // Read how many bytes can be read
	unsigned int right_buffer[BUFFER_MAX_SIZE] = {0}; // Buffer for the audio to receive
	alt_up_audio_record_r(device, &right_buffer, right_available); // Read bytes into buffer

	printf("Latest byte being: %d\n", alt_up_audio_read_fifo_head(device, 0)); // Print the latest byte
	// Use my vga driver to show a graph of the data point on screen
	usleep(50000);
}
}
