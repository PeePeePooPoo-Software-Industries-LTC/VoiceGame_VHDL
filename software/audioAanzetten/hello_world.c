#include <stdio.h>

#include "system.h"
#include "io.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_audio.h"
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
#define BUFFER_MAX_SIZE 512

alt_up_audio_dev* device = alt_up_audio_open_dev("/dev/audio_0"); // open audio device

while (1) {
  // Wait until a button is pressed or something
	while(!(input & 0x8)) {}; // Wait until a switch is held down
	printf("FIFO can read from right buffer: %d", alt_up_audio_read_fifo_avail(device, 0)); // Print available bytes

  unsigned int left_available = alt_up_audio_read_fifo_avail(device, 0); // Read how many bytes can be read
  unsigned int left_buffer[BUFFER_MAX_SIZE] = {0}; // Buffer for the audio to recieve
  alt_up_audio_record_l(device, &left_buffer, left_available); // Read bytes into buffer

  unsigned int right_available = alt_up_audio_read_fifo_avail(device, 1); // Read how many bytes can be read
  unsigned int right_buffer[BUFFER_MAX_SIZE] = {0}; // Buffer for the audio to recieve
  alt_up_audio_record_r(device, &right_buffer, right_available); // Read bytes into buffer

  printf("Latest byte being: %d", alt_up_audio_read_fifo_head(device, 0)); // Print the latest byte
  // Use my vga driver to show a graph of the data point on screen
}
}
