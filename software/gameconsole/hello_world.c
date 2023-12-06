
#include <stdio.h>

#include "system.h"
#include "io.h"
#include "sys/alt_irq.h"

//#define WRITE_SDRAM(offset, value) IOWR(NEW_SDRAM_CONTROLLER_0_BASE, offset, value);
//#define READ_SDRAM(offset) IORD(NEW_SDRAM_CONTROLLER_0_BASE, offset)

#define WRITE_SDRAM(offset, value) *(int*)(NEW_SDRAM_CONTROLLER_0_BASE + offset) = value;
#define READ_SDRAM(offset) (*(int*)NEW_SDRAM_CONTROLLER_0_BASE + offset)

#define VGA_WIDTH 640
#define VGA_HEIGHT 480

#define RGB(r, g, b) ((r << 16) | (g << 8) | b)

void update_screen();
void set_pixel_color(int x, int y, int color);

inline void set_pixel_color(int x, int y, int color) {
	WRITE_SDRAM(y * VGA_HEIGHT + x, color);
}

inline void update_screen() {
	int position = IORD(PIO_PIXEL_POSITION_BASE, 0);
//	int x = (position >> 16);
//	int y = position & 0xffff;

	IOWR(PIO_PIXEL_COLOR_BASE, 0, position);
//	IOWR(PIO_PIXEL_COLOR_BASE, 0, RGB(x, 0, 0));

//	IOWR(PIO_PIXEL_COLOR_BASE, 0, READ_SDRAM(y * VGA_HEIGHT + x));
}

int main() {
	for (int x = 0; x < VGA_WIDTH; x++) {
		for (int y = 0; y < VGA_HEIGHT; y++) {
//			if (x < 10) {
//				set_pixel_color(x, y, 0x00ff0000);
//			} else {
				set_pixel_color(x, y, 0x000000ff);
//			}
		}
	}

	while (1) {
		IOWR(PIO_PIXEL_COLOR_BASE, 0, IORD(PIO_PIXEL_POSITION_BASE, 0));
//		update_screen();
	}
}
