#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "graphics.h"
#include "images.h"
#include "io.h"

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (1023)

#define START_X 5
#define START_Y 5

#define SCALE(n, input_max, output_max) (n * input_max / output_max)
#define GRID_SIZE_Y 15
#define GRID_SIZE_X 20
#define PIXEL_SIZE 16

#define GRID_ARG int grid[GRID_SIZE_Y][GRID_SIZE_X]

#define GAME_OVER -2
#define APPLE -1
#define IGNORE 0

typedef struct {
	int length;
	int head_x, head_y;
	int delta_x, delta_y;
} Snake;

void spawn_apple(int grid[GRID_SIZE_X][GRID_SIZE_Y]) {
	int posible_apple_spawn = 1;

	while (posible_apple_spawn) {
		int rand_x = rand() % GRID_SIZE_X;
		int rand_y = rand() % GRID_SIZE_Y;
		int suggested_apple_spawn = grid[rand_x][rand_y];
		if (suggested_apple_spawn == IGNORE) {
			posible_apple_spawn = 0;
			grid[rand_x][rand_y] = -1;
		}
	}
}

void draw_grid(GRID_ARG) {
	for (int i = 0; i < GRID_SIZE_X; i++) {
		for (int j = 0; j < GRID_SIZE_Y; j++) {
			int value = grid[i][j];
			if (value != APPLE && value != IGNORE && value != GAME_OVER) {
				vga_draw_rect(i * PIXEL_SIZE, j * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(0, 1023, 0));
			} else if(value == IGNORE) {
				vga_draw_rect(i * PIXEL_SIZE, j * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(0, 0, 0));
			} else if(value == APPLE) {
				vga_draw_rect(i * PIXEL_SIZE, (j * PIXEL_SIZE) + 2, 8, 6, RGB(1023, 0, 0));
				vga_draw_rect((i * PIXEL_SIZE) + 3, j * PIXEL_SIZE, 0, 2, RGB(600, 300, 0));
			} else {
				vga_draw_rect(i * PIXEL_SIZE, j * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(0, 0, 1023));
			}
		}
	}
}

void update_grid(GRID_ARG, Snake* snake) {
	for (int i=0; i < GRID_SIZE_X; i++) {
		for (int j = 0; j < GRID_SIZE_Y; j++) {
			int value = grid[i][j];
			if (value != APPLE && value != IGNORE && value != GAME_OVER) {
				// Do increments.
				if (value < snake->length) {
					grid[i][j] = value + 1;
				} else {
					grid[i][j] = 0;
				}
			}
			// No apples?
		}
	}
}

void game_over(GRID_ARG) {
	for (int i = 0; i < GRID_SIZE_X; i++){
		for (int j = 0; j < GRID_SIZE_Y; j++){
			grid[i][j] = -2;
		}
	}
}

void move_snake(GRID_ARG, Snake* snake, unsigned int input) {
	// Input from the switches. (Currently LEVEL checked.)
	if ((input & 0x4)) {
		// Turn right.
		// new x = -y, new y = x
		int old_x = snake->delta_x;
		int old_y = snake->delta_y;

		snake->delta_x = old_y * -1;
		snake->delta_y = old_x;

		// Reset edge_capture register.
		IOWR(BUTTON_PASSTHROUGH_BASE,3,1);
	}
	if ((input & 0x8)) {
		// Turn left.
		// new x = y, new y = -x
		int old_x = snake->delta_x;
		int old_y = snake->delta_y;

		snake->delta_x = old_y;
		snake->delta_y = old_x * -1;

		// Reset edge_capture register.
		IOWR(BUTTON_PASSTHROUGH_BASE, 3, 1);
	}

	// Move snake.
	snake->head_x = snake->head_x + snake->delta_x;
	snake->head_y = snake->head_y + snake->delta_y;

	// Killzones
	if (snake->head_x > GRID_SIZE_X) {
		game_over(grid);
	}
	if (snake->head_x < 0) {
		game_over(grid);
	}
	if (snake->head_y  > GRID_SIZE_Y) {
		game_over(grid);
	}
	if (snake->head_y < 0) {
		game_over(grid);
	}

	if (grid[snake->head_x][snake->head_y] == APPLE) {
		snake->length++;
		spawn_apple(grid);
	}
	if (grid[snake->head_x][snake->head_y] != APPLE && grid[snake->head_x][snake->head_y] != IGNORE) {
		//game over, tegen snake aan gekomen
		game_over(grid);
	} else {
		grid[snake->head_x][snake->head_y] = 1;
	}
}

void restart_game(GRID_ARG, Snake* snake){
	snake->length = 3;
	snake->head_x = START_X;
	snake->head_y = START_Y;
	snake->delta_x = 0;
	snake->delta_y = 1;

	for (int i = 0; i < GRID_SIZE_X; i++){
		for (int j = 0; j < GRID_SIZE_Y; j++){
			grid[i][j] = 0;
		}
	}

	spawn_apple(grid);
}



int main() {
	vga_init();

	// Making snake struct
	Snake snake = { 3, START_X, START_Y, 0, 1 };

	int grid[GRID_SIZE_X][GRID_SIZE_Y];

	for (int i = 0; i < GRID_SIZE_X; i++){
		for (int j = 0; j < GRID_SIZE_Y; j++){
			grid[i][j] = 0;
		}
	}

	spawn_apple(grid);

	while (1) {
		usleep(10000);

		int input = IORD(BUTTON_PASSTHROUGH_BASE,3);

		if (grid[0][0] == GAME_OVER && (input & 0x2)) {
			restart_game(grid, &snake);
			IOWR(BUTTON_PASSTHROUGH_BASE, 3, 1);
		} else {
			update_grid(grid, &snake);
			move_snake(grid, &snake, input);
		}

		draw_grid(grid);
		vga_swap_buffers();
	}
	return 0;
}
