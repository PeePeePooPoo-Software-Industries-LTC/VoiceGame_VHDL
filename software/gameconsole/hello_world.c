#include <stdio.h>

#include "system.h"
#include "sys/alt_irq.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "graphics.h"
#include "images.h"
#include "io.h"

#define IS_SET(n, bit) (n & (1 << bit))
#define GET_BIT(n, bit) ((n & (1 << bit)) >> bit)

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (1023)

#define START_X 5
#define START_Y 5

#define SCALE(n, input_max, output_max) (n * input_max / output_max)
#define GRID_SIZE_Y 15
#define GRID_SIZE_X 20
#define PIXEL_SIZE 16

#define GRID_ARG int grid[GRID_SIZE_X][GRID_SIZE_Y]

#define GAME_OVER -2
#define APPLE -1
#define IGNORE 0

typedef enum {
	Playing,
	Paused
} GameState;

typedef struct {
	int length;
	int head_x, head_y;
	int delta_x, delta_y;
	GameState state;
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
	for (int x = 0; x < GRID_SIZE_X; x++) {
		for (int y = 0; y < GRID_SIZE_Y; y++) {
			int value = grid[x][y];
			if (value != APPLE && value != IGNORE && value != GAME_OVER) {
				vga_draw_rect(x * PIXEL_SIZE, y * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(0, 1023, 0));
			} else if(value == IGNORE) {
				vga_draw_rect(x * PIXEL_SIZE, y * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(0, 0, 0));
			} else if(value == APPLE) {
				vga_draw_transparent_image(x * PIXEL_SIZE, y * PIXEL_SIZE, image_apple_width, image_apple_palette, image_apple, IMAGE_apple_MAX_BYTES, 0x3fffffff);
//				vga_draw_rect(x * PIXEL_SIZE, y * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(0, 0, 0));
//				vga_draw_rect(x * PIXEL_SIZE, (y * PIXEL_SIZE) + 2, 8, 6, RGB(1023, 0, 0));
//				vga_draw_rect((x * PIXEL_SIZE) + 3, y * PIXEL_SIZE, 0, 2, RGB(600, 300, 0));
			} else {
				vga_draw_rect(x * PIXEL_SIZE, y * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, RGB(0, 0, 1023));
			}
		}
	}
}

void grow_snake(GRID_ARG, Snake* snake) {
	for (int x = 0; x < GRID_SIZE_X; x++) {
		for (int y = 0; y < GRID_SIZE_Y; y++) {
			int value = grid[x][y];
			if (value != APPLE && value != IGNORE && value != GAME_OVER) {
				// Do increments.
				if (value < snake->length) {
					grid[x][y] = value + 1;
				} else {
					grid[x][y] = 0;
				}
			}
			// No apples?
		}
	}
}

void game_over(Snake* snake, GRID_ARG) {
	snake->state = Paused;

	for (int x = 0; x < GRID_SIZE_X; x++){
		for (int y = 0; y < GRID_SIZE_Y; y++){
			grid[x][y] = -2;
		}
	}
}

void move_snake(GRID_ARG, Snake* snake, unsigned int input) {
	grow_snake(grid, snake);

	// Input from the switches. (Currently LEVEL checked.)
	if (IS_SET(input, 2)) {
		// Turn right.
		// new x = -y, new y = x
		int old_x = snake->delta_x;
		int old_y = snake->delta_y;

		snake->delta_x = old_y * -1;
		snake->delta_y = old_x;

		// Reset edge_capture register.
		IOWR(BUTTON_PASSTHROUGH_BASE, 3, 1);
	}
	if (IS_SET(input, 3)) {
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
	if (snake->head_x >= GRID_SIZE_X) {
		return game_over(snake, grid);
	}
	if (snake->head_x < 0) {
		return game_over(snake, grid);
	}
	if (snake->head_y  >= GRID_SIZE_Y) {
		return game_over(snake, grid);
	}
	if (snake->head_y < 0) {
		return game_over(snake, grid);
	}

	if (grid[snake->head_x][snake->head_y] == APPLE) {
		snake->length++;
		spawn_apple(grid);
	}
	if (grid[snake->head_x][snake->head_y] != APPLE && grid[snake->head_x][snake->head_y] != IGNORE) {
		// Hit snake, game over
		return game_over(snake, grid);
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
	snake->state = Playing;

	for (int x = 0; x < GRID_SIZE_X; x++){
		for (int y = 0; y < GRID_SIZE_Y; y++){
			grid[x][y] = 0;
		}
	}

	spawn_apple(grid);
}



int main() {
	vga_init();

	int grid[GRID_SIZE_X][GRID_SIZE_Y];

	// Making snake struct
	Snake snake;
	snake.state = Paused;

	while (1) {
		int input = IORD(BUTTON_PASSTHROUGH_BASE, 3);

		switch (snake.state) {
		case Paused:
			if (IS_SET(input, 1)) {
				printf("Reset?");
				restart_game(grid, &snake);
				IOWR(BUTTON_PASSTHROUGH_BASE, 3, 1);
			}
			break;

		case Playing:
			move_snake(grid, &snake, input);
			break;
		}

		draw_grid(grid);
		vga_swap_buffers();

		// If we're playing, delay the move
		if (snake.state == Playing) {
			usleep(10000);
		}
	}
	return 0;
}
