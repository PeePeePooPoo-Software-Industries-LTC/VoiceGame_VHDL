#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "io.h"

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (1023)

#define SCALE(n, input_max, output_max) (n * input_max / output_max)
#define GRID_SIZE_Y 30
#define GRID_SIZE_X 40
#define PIXEL_SIZE 8

typedef int Color;
typedef struct VgaBuffer_t {
	alt_up_pixel_buffer_dma_dev* device;
	unsigned int current_buffer;
} VgaBuffer;

void vga_swap_buffers(VgaBuffer* buff);
void vga_clear(VgaBuffer* buff);
void vga_draw_pixel(VgaBuffer* buff, int x, int y, Color);
void vga_draw_rect(VgaBuffer* buff, int x, int y, int w, int h, Color);

inline void vga_swap_buffers(VgaBuffer* buff) {
	alt_up_pixel_buffer_dma_swap_buffers(buff->device);
	while (alt_up_pixel_buffer_dma_check_swap_buffers_status(buff->device)) {};
	vga_clear(buff);
}

inline void vga_draw_pixel(VgaBuffer* buff, int x, int y, Color color) {
	alt_up_pixel_buffer_dma_draw(buff->device, color, x, y);
}

inline void vga_clear(VgaBuffer* buff) {
	alt_up_pixel_buffer_dma_clear_screen(buff->device, buff->current_buffer);
}

inline void vga_draw_rect(VgaBuffer* buff, int x, int y, int w, int h, Color color) {
	alt_up_pixel_buffer_dma_draw_box(buff->device, x, y, x + w, y + h, color, buff->current_buffer);
}

void draw() {

}


struct Snake{
	int length_in_rect;
	int length;
	int width;
	int headX, headY;
};

void SpawnApple(VgaBuffer vga_buffer)
{
    int randX = rand() % GRID_SIZE_X;
    int randY = rand() % GRID_SIZE_Y;
    vga_draw_rect(&vga_buffer, randX*PIXEL_SIZE, randY*PIXEL_SIZE, 6, 6, RGB(1023, 0, 0));
    vga_draw_rect(&vga_buffer, (randX + 3)*PIXEL_SIZE, (randY - 3)*PIXEL_SIZE, 0, 2, RGB(600, 300, 0));
}

void draw_snake(int snek[GRID_SIZE_X][GRID_SIZE_Y], VgaBuffer vga_buffer){
		for(int i = 0; i < GRID_SIZE_X;i++){
			for(int j = 0; j < GRID_SIZE_Y;j++){
				int waarde = snek[i][j];
				if(waarde > 1000){
					vga_draw_rect(&vga_buffer, i*PIXEL_SIZE, j*PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(0, waarde, 0));
				}
				else
				{
					vga_draw_rect(&vga_buffer, i*PIXEL_SIZE, j*PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(255, 0, 0));
				}
			}
		}
	}

void move_snake(unsigned int input, int* x, int* y, int grid[GRID_SIZE_X][GRID_SIZE_Y])
	{
		grid[(int)*x][(int)*y] = 0;
		*x += ((input & 0x1) >> 0);
		*x -= ((input & 0x2) >> 1);
		*y += ((input & 0x4) >> 2);
		*y -= ((input & 0x8) >> 3);
		if (*x > GRID_SIZE_X) {
			*x = 0;
		}
		if (*x < 0) {
			*x = GRID_SIZE_X;
		}
		if (*y > GRID_SIZE_Y) {
			*y = 0;
		}
		if (*y < 0) {
			*y = GRID_SIZE_Y;
		}
		grid[(int)*x][(int)*y] = 1023;
	}

int main() {
	VgaBuffer vga_buffer = {
		alt_up_pixel_buffer_dma_open_dev(VIDEO_PIXEL_BUFFER_DMA_0_NAME),
		1
	};
	if (vga_buffer.device == NULL) {
		printf("Failed to open device\n");
		return 1;
	}

	int x = 0;
	int y = 0;

	printf(
		"Addresses (FRONT: %p) (BACK: %p)",
		vga_buffer.device->buffer_start_address,
		vga_buffer.device->back_buffer_start_address
	);

//	struct Snake grid[GRID_SIZE][GRID_SIZE];
	int grid[GRID_SIZE_X][GRID_SIZE_Y];
	for(int i = 0; i < GRID_SIZE_X;i++){
		for(int j = 0; j < GRID_SIZE_Y;j++){
			grid[i][j] = 0;
		}
	}

	while (1) {
		for(int i =0; i<699999; i++){}

		unsigned int input = IORD(BUTTON_PASSTHROUGH_BASE, 0);
		move_snake(input, &x, &y, grid);
//		grid[0][0] = 1023;
		draw_snake(grid, vga_buffer);
//		snake_hit_apple();
//		if(snake_hit == true){
//			grow_snake();
//			SpawnApple();
//		}
//		snake_hit_wall();

		vga_swap_buffers(&vga_buffer);
	}
	return 0;
}
