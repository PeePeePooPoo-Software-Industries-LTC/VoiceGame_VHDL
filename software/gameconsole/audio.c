
#include "audio.h"

#include <stdio.h>

#include "altera_up_avalon_audio_and_video_config_regs.h"
#include "altera_up_avalon_audio_and_video_config.h"
#include "altera_up_avalon_audio.h"
#include "system.h"

#define NULL 0

alt_up_audio_dev* audio_device = NULL;

int audio_init() {
	alt_up_av_config_dev* config_device = alt_up_av_config_open_dev(AUDIO_AND_VIDEO_CONFIG_0_NAME);
	if (config_device == NULL) {
		printf("Failed to open config device\n");
		return 1;
	}

	audio_device = alt_up_audio_open_dev(AUDIO_0_NAME);
	if (config_device == NULL) {
		printf("Failed to open config device\n");
		return 1;
	}

	alt_up_av_config_reset(config_device);
	return 0;
}

int audio_get_average() {
	unsigned int buffer[128];
	register unsigned int available = alt_up_audio_read_fifo_avail(audio_device, 0);
	alt_up_audio_read_fifo(audio_device, buffer, available, 0);

	if (available < 50) {
		return -1;
	}
	register unsigned int sum = 0;
	for (register unsigned short i = 0; i < available; i++) {
		register unsigned short should_subtract = buffer[i] >= (1<<15);
		sum += (should_subtract * (1<<16)) + (-2 * should_subtract + 1) * buffer[i];
	}
	return sum / available;
}
