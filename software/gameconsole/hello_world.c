
#include <stdio.h>

#include "system.h"
#include "io.h"
#include "sys/alt_irq.h"

#define WRITE_SDRAM(offset, value) *(NEW_SDRAM_CONTROLLER_0_BASE + offset) = value;
#define READ_SDRAM(offset) (*(NEW_SDRAM_CONTROLLER_0_BASE + offset))

void return_color_irq(void* irq_context, long unsigned int irq) {
	if (irq == PIO_REQUEST_IRQ) {
		IOWR(PIO_PIXEL_COLOR_BASE, 0, 0x00ffff0f);
	}
}

int main() {
	alt_irq_init(0);

	alt_irq_register(
		PIO_REQUEST_IRQ,
		0,
		return_color_irq
	);

	int position = IORD(PIO_PIXEL_POSITION_BASE, 0);
	printf("(%u, %u)\n", position >> 16, position & 0xffff);
	IOWR(PIO_PIXEL_COLOR_BASE, 0, 0x00ffff03);
	printf("why\n");

	int prev_value = IORD(PIO_REQUEST_BASE, 0);
	while (1) {
		int current_value = IORD(PIO_REQUEST_BASE, 0);

//		printf("%i\n", current_value);

//		if (current_value == 1) {
//			printf("You should INTERRUPT yourself NOW!\n");
//		}
		if (prev_value != current_value) {
			prev_value = current_value;
			return_color_irq(0, PIO_REQUEST_IRQ);
			printf("Current: %i\n", current_value);
		}
	}
}
