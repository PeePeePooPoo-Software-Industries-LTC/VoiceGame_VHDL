#include <stdio.h>
#include <stdlib.h>

#include "system.h"
#include "graphics.h"
#include "images.h"
#include "sys/alt_alarm.h"
#include "altera_avalon_timer.h"
#include "audio.h"
#include "input.h"

#define RGB(r, g, b) (((r) << 20) | ((g) << 10) | (b))
#define BIT10_MAX (1023)

#define START_X 5
#define START_Y 5

#define SCALE(n, input_max, output_max) (n * input_max / output_max)
#define GRID_SIZE_Y 15
#define GRID_SIZE_X 20
#define PIXEL_SIZE 16

#define GRID_ARG int grid[GRID_SIZE_X][GRID_SIZE_Y]

#define GAME_TICK_DURATION_MS 300
#define RENDER_TICK_DURATION_MS 100

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
				vga_draw_rect(x * PIXEL_SIZE, (y * PIXEL_SIZE) + 2, 8, 6, RGB(1023, 0, 0));
				vga_draw_rect((x * PIXEL_SIZE) + 3, y * PIXEL_SIZE, 0, 2, RGB(600, 300, 0));
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

void move_snake(GRID_ARG, Snake* snake, Input* buttons) {
	grow_snake(grid, snake);

	// Input from the switches. (Currently LEVEL checked.)
	if (buttons->right) {
		// Turn right.
		// new x = -y, new y = x
		int old_x = snake->delta_x;
		int old_y = snake->delta_y;

		snake->delta_x = old_y * -1;
		snake->delta_y = old_x;
	}
	if (buttons->left) {
		// Turn left.
		// new x = y, new y = -x
		int old_x = snake->delta_x;
		int old_y = snake->delta_y;

		snake->delta_x = old_y;
		snake->delta_y = old_x * -1;
	}

	// Move snake.
	snake->head_x = snake->head_x + snake->delta_x;
	snake->head_y = snake->head_y + snake->delta_y;

	// Killzones
	if (snake->head_x > GRID_SIZE_X) {
		return game_over(snake, grid);
	}
	if (snake->head_x < 0) {
		return game_over(snake, grid);
	}
	if (snake->head_y > GRID_SIZE_Y) {
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
	audio_init();
	vga_init();

    // Init the timer
    alt_avalon_timer_sc_init((void*)TIMER_0_BASE, TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID, TIMER_0_IRQ, TIMER_0_FREQ);
    alt_32 now = alt_nticks();
    alt_32 game_tick = now + GAME_TICK_DURATION_MS;
    alt_32 render_tick = now + RENDER_TICK_DURATION_MS;

    // Create the grid
	int grid[GRID_SIZE_X][GRID_SIZE_Y];

    Input input = input_init();

	// Making snake struct
	Snake snake;
    restart_game(grid, &snake);

	while (1) {
        now = alt_nticks();

        input_preframe(&input);

		switch (snake.state) {
		case Paused:
			if (input.reset) {
				restart_game(grid, &snake);
                input_postframe(&input);
			}
			break;

		case Playing:
            if (now >= game_tick) {
                game_tick = now + (1000 / input.speed);
			    move_snake(grid, &snake, &input);
                input_postframe(&input);
            }
			break;
		}

        if (now >= render_tick) {
            render_tick = now + RENDER_TICK_DURATION_MS;

            draw_grid(grid);
            vga_swap_buffers();
        }
	}
	return 0;
}
