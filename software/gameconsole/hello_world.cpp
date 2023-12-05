
#include <sys/alt_irq.h>
#include <stdio.h>

#define SDRAM_BASE ((int*)0x00800000)
#define WRITE_SDRAM(offset, value) *(SDRAM_BASE + offset) = value;
#define READ_SDRAM(offset) (*(SDRAM_BASE + offset))

void return_color_irq(void* irq_context) {

}

int main() {
	alt_ic_isr_register(0, 2, return_color_irq, (void*)0, (void*)0);
	alt_ic_irq_enabled(0, 2);

	int* pio_color = (int*)0x01101000;
	int* pio_pixel_bundle = (int*)0x01101020;

	printf("(%u, %u)", *pio_pixel_bundle >> 16, *pio_pixel_bundle & 0xffff);
	*pio_color = 0x00ffff03;
	printf("why");
//	printf("PIO Color: %i", *pio_color_addr);
}
