
#include "audio.h"

#include <stdio.h>

#include "altera_up_avalon_audio_and_video_config_regs.h"
#include "altera_up_avalon_audio_and_video_config.h"
#include "altera_up_avalon_audio.h"
#include "system.h"

#define NULL 0

unsigned int audio_data[AUDIO_BUFFER_SIZE];
extern unsigned int* audio_data_ptr = audio_data;

alt_up_audio_dev* audio_device = NULL;

void audio_correct_buffer() {
    for (unsigned int index = 0; index < AUDIO_BUFFER_SIZE; index++) {
        if (audio_data[index] >= (1 << (AUDIO_0_SPAN - 1))) {
            audio_data[index] = (1 << AUDIO_0_SPAN) - audio_data[index];
        }
    }
}

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

int audio_fill_async() {
    int is_done = 0;
    unsigned int available = alt_up_audio_read_fifo_avail(audio_device, 0);
    unsigned int max = available;

    if (audio_data_ptr + max >= audio_data + AUDIO_BUFFER_SIZE) {
        max = audio_data_ptr + max - (audio_data + AUDIO_BUFFER_SIZE);
        is_done = 1;
    }
    if (max > 0) {
    	alt_up_audio_read_fifo(audio_device, audio_data_ptr, max, 0);
		audio_data_ptr += max;
    }

//    printf("Async %d -> %d\n", max, is_done);
    if (is_done) {
	    audio_data_ptr = audio_data;
        audio_correct_buffer();
    }
    return is_done;
}

void audio_fill_buffer() {
	int break_out = 0;
	while (!break_out) {
		unsigned int available = alt_up_audio_read_fifo_avail(audio_device, 0);
		unsigned int max = available;

		if (audio_data_ptr + max >= audio_data + AUDIO_BUFFER_SIZE) {
			max = audio_data_ptr + max - (audio_data + AUDIO_BUFFER_SIZE);
			break_out = 1;
		}
		alt_up_audio_read_fifo(audio_device, audio_data_ptr, max, 0);
		audio_data_ptr += max;
	}
	audio_data_ptr = audio_data;
    audio_correct_buffer();
}
