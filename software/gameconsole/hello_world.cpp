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

//#include "Frame_Buffer.hpp"

int main()
{
  int x = 0;

  printf("Printing out address of variable X: %p\n", &x);

//  unsigned long framebuffer_addr = 0x00100000;
//
//  Frame_Buffer vip(framebuffer_addr, 2);
//
//  printf("Is on: %d\n", vip.is_on());
//  vip.start();
//  printf("Is on: %d\n", vip.is_on());


//  unsigned long test = framebuffer_addr + 0x10000;
//
//  for (int i = 0; i < 0x20000; i++) {
//	  *((char*)(test + i)) = 0xff;
//  }

  return 0;
}
