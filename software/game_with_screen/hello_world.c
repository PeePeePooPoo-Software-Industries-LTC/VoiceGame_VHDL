/*
 * A test for interrupts, using the PIO block set up for vhdl to dram stepping. (Via on-chip memory)
 * See "https://www.intel.com/content/www/us/en/docs/programmable/683525/21-3/registering-the-button-pio-isr-with-the-hal.html"
 */

#include <sys/alt_irq.h>
#include "alt_types.h"

// James's SDRAM read & write implementation.
#define SDRAM_BASE ((int*)0x00800000)
#define WRITE_SDRAM(offset, value) *(SDRAM_BASE + offset) = value;
#define READ_SDRAM(offset) (*(SDRAM_BASE + offset))

int main()
{
  printf("Hello world!\n");

  int* pio_color = (int*)0x01101000;
  int* pio_pixel_bundle = (int*)0x01101020;
  int* pio_request = (int*)0x01101010;

  printf("(%u, %u)\n", *pio_pixel_bundle >> 16, *pio_pixel_bundle & 0xffff);
  *pio_color = 0x00ffff00;
  printf("I am in pain.\n");

  // Enabling the interrupt mask
  *(pio_color+2) = 1; // Set the LSB of pio_color's interrupt mask to 1, which should correspond to the only connected key.



  int c;
  while(1) {
	  for(c=1; c<999999; c++) {/* Pain */}
	  printf("(%i)\n", *(pio_request+3));
	  if (*(pio_request+3) > 0) {
		  *pio_color = 0x00ffff01;
		  *(pio_request+3) = 0;
	  }
  }

  return 0;
}
