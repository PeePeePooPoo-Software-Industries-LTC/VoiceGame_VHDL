/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>

int main()
{
  int x = 0;

  printf("Printing out address of variable X: %p\n", &x);

  int* framebuffer = 0x00100000;

  while ((int)framebuffer <= 0x007fffff) {

	  *framebuffer = 0xff;

	  framebuffer++;

	  if ((int)framebuffer % 0x1000 == 0) {
		  printf("At: %p\n", framebuffer);
	  }
  }

  printf("Done\n");

  return 0;
}
