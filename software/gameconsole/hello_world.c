
#include <stdio.h>

#include <system.h>
#include <sys/alt_irq.h>

#define WRITE_SDRAM(offset, value) *(NEW_SDRAM_CONTROLLER_0_BASE + offset) = value;
#define READ_SDRAM(offset) (*(NEW_SDRAM_CONTROLLER_0_BASE + offset))

void return_color_irq(void* irq_context, long unsigned int _) {
	int* pio_color = (int*)PIO_PIXEL_COLOR_BASE;
	*pio_color = 0x00ffff0f;
}

int main() {
	alt_irq_init(0);

	alt_irq_register(
		PIO_REQUEST_IRQ,
		0,
		return_color_irq
	);

	int* pio_color = (int*)PIO_PIXEL_COLOR_BASE;
	int* pio_pixel_bundle = (int*)PIO_PIXEL_POSITION_BASE;

	printf("(%u, %u)", *pio_pixel_bundle >> 16, *pio_pixel_bundle & 0xffff);
	*pio_color = 0x00ffff03;
	printf("why");

	while (1) {};
//	printf("PIO Color: %i", *pio_color_addr);
}