/**
 * @file
 * @brief The main module managing the internal input management
 *
 * This module is relatively small, it manages all input related to the game.
 * The input_preframe() **MUST** be invoked before the main game logic executes,
 * and the input_preframe() **MUST** be invoked after the main game logic
 */

#ifndef __BUTTONS_H__
#define __BUTTONS_H__

/**
 * Checks if a certain bit has been set
 *
 * @warning This does __NOT__ return boolean values, if you want to have a definive 1 or 0, use GET_BIT(n, bit)
 */
#define IS_SET(n, bit) (n & (1 << bit))
/**
 * Returns 1 if a certain bit has been set, otherwise 0
 */
#define GET_BIT(n, bit) ((n & (1 << bit)) >> bit)

/**
 * The main input struct
 *
 * This struct contains all the information related to user input
 *
 * Most of the fields are read-only flags, however, there is one speed property
 * used throughout the game to determine the snakes movement speed
 */
typedef struct {
  unsigned int
      left; /* Read-only, if set to 1, the left button was pressed this frame */
  unsigned int right; /* Read-only, if set to 1, the right button was pressed
                         this frame */
  unsigned int reset; /* Read-only, if set to 1, the reset button was pressed
                         this frame */
  unsigned int speed; /* The speed of the snake, the higher the number, the
                         faster the snake moves */
} Input;

/**
 * Creates an user input struct
 *
 * Only one of these should be created
 *
 * @return The main input struct
 */
Input input_init();
/**
 * Handles the user input logic, must be invoked **BEFORE** the main game logic
 * gets ran
 *
 * @param buttons A pointer to the user input struct
 */
void input_preframe(Input *buttons);
/**
 * Handles the user input logic, must be invoked **AFTER** the main game logic
 * gets ran
 *
 * @param buttons A pointer to the user input struct
 */
void input_postframe(Input *buttons);

#endif
