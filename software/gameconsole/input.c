
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

inline void input_preframe(Input* buttons) {
    if (audio_fill_async()) {
        unsigned int sum = 0;
        for (unsigned int index = 0; index < AUDIO_BUFFER_SIZE; index++) {
            sum += audio_data[index];
        }
        sum /= AUDIO_BUFFER_SIZE;

        unsigned int MAX_VALUE = 1 << 15;

//        printf("%d/%d\n", sum, MAX_VALUE);

        buttons->speed = 3 + (sum * 6 / MAX_VALUE);
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

