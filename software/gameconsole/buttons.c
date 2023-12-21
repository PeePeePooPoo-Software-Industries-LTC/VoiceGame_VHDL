
#include "system.h"
#include "buttons.h"
#include "io.h"

#define BUTTON_LEFT 4
#define BUTTON_RIGHT 2
#define BUTTON_RESET 1

inline void buttons_preframe(InputButtons* buttons) {
    unsigned int input = IORD(BUTTON_PASSTHROUGH_BASE, 3);
	IOWR(BUTTON_PASSTHROUGH_BASE, 3, BUTTON_RESET);

    buttons->left |= GET_BIT(input, BUTTON_LEFT);
    buttons->right |= GET_BIT(input, BUTTON_RIGHT);
    buttons->reset |= GET_BIT(input, BUTTON_RESET);
}

inline void buttons_postframe(InputButtons* buttons) {
    buttons->left = 0;
    buttons->right = 0;
    buttons->reset = 0;
}

