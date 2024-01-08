
#include "input.h"

#include "system.h"
#include "audio.h"
#include "io.h"

#define BUTTON_LEFT 4
#define BUTTON_RIGHT 2
#define BUTTON_RESET 1

inline Input input_init() {
    Input input = {0};
    input.speed = 3;
    return input;
}

#define CLAMP_MAX_RANGE 20000

inline void input_preframe(Input* buttons) {
	int audio_average = audio_get_average();
	if (audio_average > 0) {
        unsigned int above_max = audio_average > CLAMP_MAX_RANGE;
		audio_average = (above_max * CLAMP_MAX_RANGE) | ((1 - above_max) * audio_average);
		buttons->speed = 20 - audio_average * 13 / CLAMP_MAX_RANGE;
	}

    unsigned int input = IORD(BUTTON_PASSTHROUGH_BASE, 3);
	IOWR(BUTTON_PASSTHROUGH_BASE, 3, BUTTON_RESET);

    buttons->left |= GET_BIT(input, BUTTON_LEFT);
    buttons->right |= GET_BIT(input, BUTTON_RIGHT);
    buttons->reset |= GET_BIT(input, BUTTON_RESET);
}

inline void input_postframe(Input* buttons) {
    buttons->left = 0;
    buttons->right = 0;
    buttons->reset = 0;
}

