
#include <stdio.h>

#include "system.h"
#include "io.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_audio.h"

#define WRITE_SDRAM(offset, value) *(NEW_SDRAM_CONTROLLER_0_BASE + offset) = value;
#define READ_SDRAM(offset) (*(NEW_SDRAM_CONTROLLER_0_BASE + offset))

void return_color_irq(void* irq_context, long unsigned int irq) {
	if (irq == PIO_REQUEST_IRQ) {
		IOWR(PIO_PIXEL_COLOR_BASE, 0, 0x00ffff0f);
	}
}

int main() {
	alt_up_audio_dev * audio_dev;
	/* used for audio record/playback */
	unsigned int l_buf;
	unsigned int r_buf;
	// open the Audio port
	audio_dev = alt_up_audio_open_dev ("/dev/Audio");
	if ( audio_dev == NULL)
	alt_printf ("Error: could not open audio device \n");
	else
	alt_printf ("Opened audio device \n");
	/* read and echo audio data */
	while(1)
	{
	int fifospace = alt_up_audio_read_fifo_avail (audio_dev, ALT_UP_AUDIO_RIGHT);
	if ( fifospace > 0 ) // check if data is available
	{
	// read audio buffer
	alt_up_audio_read_fifo (audio_dev, &(r_buf), 1, ALT_UP_AUDIO_RIGHT);
	alt_up_audio_read_fifo (audio_dev, &(l_buf), 1, ALT_UP_AUDIO_LEFT);
	// write audio buffer
	alt_up_audio_write_fifo (audio_dev, &(r_buf), 1, ALT_UP_AUDIO_RIGHT);
	alt_up_audio_write_fifo (audio_dev, &(l_buf), 1, ALT_UP_AUDIO_LEFT);
	}
	}
//	alt_irq_init(0);
//
//	alt_irq_register(
//		PIO_REQUEST_IRQ,
//		0,
//		return_color_irq
//	);
//
//	int position = IORD(PIO_PIXEL_POSITION_BASE, 0);
//	printf("(%u, %u)\n", position >> 16, position & 0xffff);
//	IOWR(PIO_PIXEL_COLOR_BASE, 0, 0x00ffff03);
//	printf("why\n");
//
//	int prev_value = IORD(PIO_REQUEST_BASE, 0);
//	while (1) {
//		int current_value = IORD(PIO_REQUEST_BASE, 0);
//
////		printf("%i\n", current_value);
//
////		if (current_value == 1) {
////			printf("You should INTERRUPT yourself NOW!\n");
////		}
//		if (prev_value != current_value) {
//			prev_value = current_value;
//			return_color_irq(0, PIO_REQUEST_IRQ);
//			printf("Current: %i\n", current_value);
//		}
//	}
}
