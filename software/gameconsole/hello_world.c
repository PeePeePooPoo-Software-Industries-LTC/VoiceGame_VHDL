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
#define TRANSPARENT_COLOR 0x3fffffff

#define START_X 5
#define START_Y 5

#define SCALE(n, input_max, output_max) (n * input_max / output_max)
#define GRID_SIZE_Y 15 //15 for full screen
#define GRID_SIZE_X 15 //20 for full screen
#define PIXEL_SIZE 16
#define SCREEN_OFFSET 40

#define GRID_ARG int grid[GRID_SIZE_X][GRID_SIZE_Y]

#define GAME_TICK_DURATION_MS 300
#define RENDER_TICK_DURATION_MS 100

#define DRAWBACKGROUND -3
#define APPLE -1
#define IGNORE 0
#define HEAD 1

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

void draw_background(register int x, register int y);
inline void draw_background(register int x, register int y) {
	if (x == 0 && y == 0) {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_topleft_width, image_sand_topleft_palette, image_sand_topleft, IMAGE_sand_topleft_MAX_BYTES);
	} else if (x == 0 && y == GRID_SIZE_Y - 1) {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_leftbottom_width, image_sand_leftbottom_palette, image_sand_leftbottom, IMAGE_sand_leftbottom_MAX_BYTES);
	} else if (x == GRID_SIZE_X - 1 && y == GRID_SIZE_Y - 1) {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_bottomright_width, image_sand_bottomright_palette, image_sand_bottomright, IMAGE_sand_bottomright_MAX_BYTES);
	} else if (x == GRID_SIZE_X - 1 && y == 0) {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_topright_width, image_sand_topright_palette, image_sand_topright, IMAGE_sand_topright_MAX_BYTES);
	} else if (x == 0) {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_left_width, image_sand_left_palette, image_sand_left, IMAGE_sand_left_MAX_BYTES);
	} else if (x == GRID_SIZE_X - 1) {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_right_width, image_sand_right_palette, image_sand_right, IMAGE_sand_right_MAX_BYTES);
	} else if (y == 0) {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_top_width, image_sand_top_palette, image_sand_top, IMAGE_sand_top_MAX_BYTES);
	} else if (y == GRID_SIZE_Y - 1) {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_bottom_width, image_sand_bottom_palette, image_sand_bottom, IMAGE_sand_bottom_MAX_BYTES);
	} else {
		vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_sand_width, image_sand_palette, image_sand, IMAGE_sand_MAX_BYTES);
	}
}

void draw_grid(GRID_ARG, Snake* snake) {
	for (int x = 0; x < GRID_SIZE_X; x++) {
		for (int y = 0; y < GRID_SIZE_Y; y++) {
			int value = grid[x][y];
			int valueEast = grid[x + 1][y];
			int valueWest = grid[x - 1][y];
			int valueNorth = grid[x][y - 1];
			int valueSouth = grid[x][y + 1];
			int TAIL = snake->length;
			if (value == DRAWBACKGROUND) {
				draw_background(x, y);
				grid[x][y] = IGNORE;
			}
			if (value != APPLE && value != IGNORE && value != DRAWBACKGROUND) {
				if(value == HEAD){
					if(valueEast == value + 1){
						/* head going west */
						vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_headed_west_width, image_snake_headed_west_palette, image_snake_headed_west, IMAGE_snake_headed_west_MAX_BYTES, TRANSPARENT_COLOR);
					}
					if(valueWest == value + 1){
						/* head going east */
						vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_headed_east_width, image_snake_headed_east_palette, image_snake_headed_east, IMAGE_snake_headed_east_MAX_BYTES, TRANSPARENT_COLOR);
					}
					if(valueNorth == value + 1){
						/* head going south */
						vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_headed_south_width, image_snake_headed_south_palette, image_snake_headed_south, IMAGE_snake_headed_south_MAX_BYTES, TRANSPARENT_COLOR);
					}
					if(valueSouth == value + 1){
						/* head going north */
						vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_headed_north_width, image_snake_headed_north_palette, image_snake_headed_north, IMAGE_snake_headed_north_MAX_BYTES, TRANSPARENT_COLOR);
					}
				}
				else if(value == TAIL){
					draw_background(x, y);
					if(valueEast == value - 1){
						/* tail going east */
						vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_tail_east_width, image_snake_tail_east_palette, image_snake_tail_east, IMAGE_snake_tail_east_MAX_BYTES, TRANSPARENT_COLOR);
					}
					if(valueWest == value - 1){
						/* tail going west */
						vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_tail_west_width, image_snake_tail_west_palette, image_snake_tail_west, IMAGE_snake_tail_west_MAX_BYTES, TRANSPARENT_COLOR);
					}
					if(valueNorth == value - 1){
						/* tail going north */
						vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_tail_north_width, image_snake_tail_north_palette, image_snake_tail_north, IMAGE_snake_tail_north_MAX_BYTES, TRANSPARENT_COLOR);
					}
					if(valueSouth == value - 1){
						/* tail going south */
						vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_tail_south_width, image_snake_tail_south_palette, image_snake_tail_south, IMAGE_snake_tail_south_MAX_BYTES, TRANSPARENT_COLOR);
					}
				}
				else if(value > HEAD && value < TAIL){
					if(valueEast == value + 1){
						if(valueWest == value - 1){
							/* body to west */
							vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_body_west_width, image_snake_body_west_palette, image_snake_body_west, IMAGE_snake_body_west_MAX_BYTES);
						}
						if(valueNorth == value - 1){
							/* corner east to north */
							vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_corner_en_width, image_snake_corner_en_palette, image_snake_corner_en, IMAGE_snake_corner_en_MAX_BYTES, TRANSPARENT_COLOR);
						}
						if(valueSouth == value - 1){
							/* corner east to south */
							vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_corner_es_width, image_snake_corner_es_palette, image_snake_corner_es, IMAGE_snake_corner_es_MAX_BYTES, TRANSPARENT_COLOR);
						}
					}
					if(valueWest == value + 1){
						if(valueEast == value - 1){
							/* body to east */
							vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_body_east_width, image_snake_body_east_palette, image_snake_body_east, IMAGE_snake_body_east_MAX_BYTES);
						}
						if(valueNorth == value - 1){
							/* corner from west to north */
							vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_corner_wn_width, image_snake_corner_wn_palette, image_snake_corner_wn, IMAGE_snake_corner_wn_MAX_BYTES, TRANSPARENT_COLOR);
						}
						if(valueSouth == value - 1){
							/* corner from west to south */
							vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_corner_ws_width, image_snake_corner_ws_palette, image_snake_corner_ws, IMAGE_snake_corner_ws_MAX_BYTES, TRANSPARENT_COLOR);

						}
					}
					if(valueNorth == value + 1)
					{
						if(valueEast == value - 1){
							/* corner from north to east */
							vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_corner_ne_width, image_snake_corner_ne_palette, image_snake_corner_ne, IMAGE_snake_corner_ne_MAX_BYTES, TRANSPARENT_COLOR);
						}
						if(valueWest == value - 1){
							/* corner from north to west */
							vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_corner_nw_width, image_snake_corner_nw_palette, image_snake_corner_nw, IMAGE_snake_corner_nw_MAX_BYTES, TRANSPARENT_COLOR);
						}
						if(valueSouth == value - 1){
							/* body to south */
							vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_body_south_width, image_snake_body_south_palette, image_snake_body_south, IMAGE_snake_body_south_MAX_BYTES);

						}
					}
					if(valueSouth == value + 1)
					{
						if(valueEast == value - 1){
							/* corner from south to east */
							vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_corner_se_width, image_snake_corner_se_palette, image_snake_corner_se, IMAGE_snake_corner_se_MAX_BYTES, TRANSPARENT_COLOR);
						}
						if(valueWest == value - 1){
							/* corner from south to west */
							vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_corner_sw_width, image_snake_corner_sw_palette, image_snake_corner_sw, IMAGE_snake_corner_sw_MAX_BYTES, TRANSPARENT_COLOR);
						}
						if(valueNorth == value - 1){
							/* body to north */
							vga_draw_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_snake_body_north_width, image_snake_body_north_palette, image_snake_body_north, IMAGE_snake_body_north_MAX_BYTES);

						}
					}
				}
			}
			else if(value == APPLE) {
				vga_draw_transparent_image(x * PIXEL_SIZE + SCREEN_OFFSET, y * PIXEL_SIZE, image_apple_width, image_apple_palette, image_apple, IMAGE_apple_MAX_BYTES, TRANSPARENT_COLOR);
			}
		}
	}
}

void grow_snake(GRID_ARG, Snake* snake) {
	for (int x = 0; x < GRID_SIZE_X; x++) {
		for (int y = 0; y < GRID_SIZE_Y; y++) {
			int value = grid[x][y];
			if (value != APPLE && value != IGNORE && value != DRAWBACKGROUND) {
				// Do increments.
				if (value < snake->length) {
					grid[x][y] = value + 1;
				} else {
					grid[x][y] = DRAWBACKGROUND;
				}
			}
			// No apples?
		}
	}
}

void game_over(Snake* snake, GRID_ARG) {
	snake->state = Paused;
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
	if (snake->head_x >= GRID_SIZE_X) {
		return game_over(snake, grid);
	}
	if (snake->head_x < 0) {
		return game_over(snake, grid);
	}
	if (snake->head_y >= GRID_SIZE_Y) {
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

	vga_draw_rect(0, 0, 48, GRID_SIZE_Y * 16, RGB(264, 264, 264));
	vga_draw_rect(48 + (GRID_SIZE_X - 1) * 16, 0, 48, GRID_SIZE_Y * 16, RGB(264, 264, 264));
	for (int x = 0; x < GRID_SIZE_X; x++){
		for (int y = 0; y < GRID_SIZE_Y; y++){
			grid[x][y] = 0;
			draw_background(x, y);
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

		    draw_grid(grid, &snake);
        }
	}
	return 0;
}
