
#ifndef __AUDIO_H__
#define __AUDIO_H__

#define AUDIO_BUFFER_SIZE 300

extern unsigned int audio_data[AUDIO_BUFFER_SIZE];
extern unsigned int* audio_data_ptr;

int audio_init();
void audio_fill_buffer();

#endif
