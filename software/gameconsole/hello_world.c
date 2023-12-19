#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "io.h"

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (1023)

#define START_X 5
#define START_Y 5

#define SCALE(n, input_max, output_max) (n * input_max / output_max)
#define GRID_SIZE_Y 30
#define GRID_SIZE_X 40
#define PIXEL_SIZE 8

#define APPLE -1
#define IGNORE 0

typedef int Color;
typedef struct VgaBuffer_t {
	alt_up_pixel_buffer_dma_dev* device;
	unsigned int current_buffer;
} VgaBuffer;

typedef struct {
	int length;
	int head_x, head_y;
	int delta_x, delta_y;
} Snake;

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

void SpawnApple(VgaBuffer vga_buffer)
{
    int randX = rand() % GRID_SIZE_X;
    int randY = rand() % GRID_SIZE_Y;
    vga_draw_rect(&vga_buffer, randX*PIXEL_SIZE, randY*PIXEL_SIZE, 6, 6, RGB(1023, 0, 0));
    vga_draw_rect(&vga_buffer, (randX + 3)*PIXEL_SIZE, (randY - 3)*PIXEL_SIZE, 0, 2, RGB(600, 300, 0));
}

void draw_grid(int grid[GRID_SIZE_X][GRID_SIZE_Y], VgaBuffer vga_buffer){
	// Check squares for value.
		for(int i = 0; i < GRID_SIZE_X;i++){
			for(int j = 0; j < GRID_SIZE_Y;j++){
				int waarde = grid[i][j];
				if(waarde > 0){
					vga_draw_rect(&vga_buffer, i*PIXEL_SIZE, j*PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(BIT10_MAX, BIT10_MAX, 0));
				}
				else
				{
					vga_draw_rect(&vga_buffer, i*PIXEL_SIZE, j*PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(50, 0, 0));
				}
			}
		}
	}

void update_grid(int grid[GRID_SIZE_X][GRID_SIZE_Y], Snake snake) {
	for(int i=0; i < GRID_SIZE_X; i++) {
		for(int j = 0; j < GRID_SIZE_Y; j++) {
			int value = grid[i][j];
			if(value != APPLE && value != IGNORE) {
				// Do increments.
				if (value < snake.length) {
					grid[i][j] = value + 1;
				} else {
					grid[i][j] = 0;
				}
			}
			// No apples?
		}
	}
}

Snake move_snake(unsigned int input, Snake snake, int grid[GRID_SIZE_X][GRID_SIZE_Y])
	{
		// Input from the switches. (Currently LEVEL checked.)

		if ((input & 0x4)) {
			// Turn right.
			// new x = -y, new y = x
			int old_x = snake.delta_x;
			int old_y = snake.delta_y;

			printf("Turn right\n");

			snake.delta_x = old_y * -1;
			snake.delta_y = old_x;

			// Reset edge_capture register.
			IOWR(BUTTON_PASSTHROUGH_BASE,3,1);
		}
		if ((input & 0x8)) {
			// Turn left.
			// new x = y, new y = -x
			int old_x = snake.delta_x;
			int old_y = snake.delta_y;

			printf("Turn left\n");

			snake.delta_x = old_y;
			snake.delta_y = old_x * -1;

			// Reset edge_capture register.
			IOWR(BUTTON_PASSTHROUGH_BASE,3,1);
		}

		// Move snake.

		snake.head_x = snake.head_x + snake.delta_x;
		snake.head_y = snake.head_y + snake.delta_y;

		// Killzones
		if (snake.head_x > GRID_SIZE_X) {
			snake.head_x = 0;
		}
		if (snake.head_x < 0) {
			snake.head_x = GRID_SIZE_X;
		}
		if (snake.head_y  > GRID_SIZE_Y) {
			snake.head_y = 0;
		}
		if (snake.head_y < 0) {
			snake.head_y = GRID_SIZE_Y;
		}

		grid[snake.head_x][snake.head_y] = 1;

		return snake;
	}

int main() {
	VgaBuffer vga_buffer = {
		alt_up_pixel_buffer_dma_open_dev(VIDEO_PIXEL_BUFFER_DMA_0_NAME),
		1
	};
	if (vga_buffer.device == NULL) {
		return 1;
	}

	printf(
		"Addresses (FRONT: %p) (BACK: %p)",
		vga_buffer.device->buffer_start_address,
		vga_buffer.device->back_buffer_start_address
	);

	// Making snake struct
	Snake snake = {3,START_X,START_Y,0,1};

//	struct Snake grid[GRID_SIZE][GRID_SIZE];
	int grid[GRID_SIZE_X][GRID_SIZE_Y];
	for(int i = 0; i < GRID_SIZE_X;i++){
		for(int j = 0; j < GRID_SIZE_Y;j++){
			grid[i][j] = 0;
		}
	}

	while (1) {
		for(int i =0; i<99999; i++){}

		int input = IORD(BUTTON_PASSTHROUGH_BASE,3);

		update_grid(grid,snake);
		snake = move_snake(input, snake, grid);
		draw_grid(grid, vga_buffer);

		// Apple

		vga_swap_buffers(&vga_buffer);
	}
	return 0;
}
