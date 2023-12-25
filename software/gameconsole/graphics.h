/**
 * @file
 * @brief The graphics driver for the VGA screen configured for the VoiceGame
 * project
 *
 * Do **NOT** use the internal device drivers and this module at the same time
 * In general, you should use this module over the internal device drivers, as
 * this module exposes some higher level functions with better performance
 */

#ifndef __GRAPHIC_H__
#define __GRAPHIC_H__

#include "altera_up_avalon_video_pixel_buffer_dma.h"

/**
 * The color type. This is simply just a 32 bit number. However color itself is
 * only 30 bits wide. This means two bits go unused. The ingored bits are the
 * two most significant bits. The color uses the RGB format, where each channel
 * is 10 bits wide
 */
typedef int Color;

/**
 * The main handle to drive the screen. This should not be created manually and
 * not modified. This handle is created automatically by vga_init()
 */
typedef struct {
  alt_up_pixel_buffer_dma_dev
      *device; /** The VGA device driver, set automatically by vga_init() */
  unsigned int current_buffer; /** The backbuffer number to render too. Mostly
                                  ignored. Set automatically by vga_init() */
} VgaBuffer;

/**
 * Initializes the VGA driver.
 *
 * Using any other function in this module will be undefined and most likely
 * result into crashes
 *
 * @return 0 - For success
 * @return 1 - Failed to open VGA device
 */
int vga_init();

/**
 * Swaps the buffer currently used to draw to the screen
 * This function blocks until the operation is done
 *
 * One should draw all you want to the screen using this modules other
 * functions, then invoke this to display it all to the screen at once
 */
void vga_swap_buffers();

/**
 * Clears the entire screen to black
 */
void vga_clear();

/**
 * Draws a single pixel to a specified coordinate
 *
 * No bounds checking is performed, make sure all arguments are proper or
 * out-of-bounds memory writes will be performed!
 *
 * @param x The x position of the pixel
 * @param y The y position of the pixel
 * @param color The 30-bit color of the pixel
 */
void vga_draw_pixel(unsigned int x, unsigned int y, Color color);

/**
 * Draws a rectangle to the screen
 *
 * No bounds checking is performed, make sure all arguments are proper or
 * out-of-bounds memory writes will be performed!
 *
 * @param x The topleft corner x position
 * @param y The topleft corner y position
 * @param w The width of the rectangle
 * @param h The height of the rectangle
 * @param color The 30-bit color of the pixel
 */
void vga_draw_rect(int x, int y, int w, int h, Color color);

/**
 * Draws a vertical line
 *
 * No bounds checking is performed, make sure all arguments are proper or
 * out-of-bounds memory writes will be performed!
 *
 * @param x The top corner x position
 * @param y The top corner y position
 * @param height The height of the line
 * @param color The 30-bit color of the pixel
 */
void vga_draw_vertical_line(int x, int y, int height, Color color);

/**
 * Draws an image to the screen
 *
 * No bounds checking is performed, make sure all arguments are proper or
 * out-of-bounds memory writes will be performed!
 *
 * @param x The topleft corner x position
 * @param y The topleft corner y position
 * @param w The width of the image
 * @param palette A pointer to a color array
 * @param image A pointer to the image data array
 * @param max_bytes The length of the image data array
 *
 * @warning The palette pointer must point to an array with a length of 8. Each
 * entry must be 32 bits wide and each entry contains a 30-bit color.
 *
 * @note The image height is not needed, as the combination of `width` and
 * `max_bytes` is enough to draw the image at it's appropiate height
 *
 * @note The image is an encoded image format. There is a tool available on our
 * repository to convert PNGs into this encoded image format
 */
void vga_draw_image(int x, int y, unsigned char w, unsigned int *palette,
                    unsigned char *image, unsigned int max_bytes);

/**
 * Checks wether of not an image contains any transparent pixels or not
 *
 * No bounds checking is performed, make sure all arguments are proper or
 * out-of-bounds memory writes will be performed!
 *
 * @param palette A pointer to a color array
 * @param image A pointer to the image data array
 * @param max_bytes The length of the image data array
 * @param mask The mask indicating which pixel is transparent
 * @return 0 - If the image contains **no** transparent pixels
 * @return 1 - If the image contains transparent pixels
 *
 * @warning The color mask is the 30-bit color! **NOT** the index to the color
 * palette. If the color is not found within the image, no pixel will be
 * transparent
 *
 * @warning The palette pointer must point to an array with a length of 8. Each
 * entry must be 32 bits wide and each entry contains a 30-bit color.
 *
 * @note The image is an encoded image format. There is a tool available on our
 * repository to convert PNGs into this encoded image format
 */
unsigned char vga_contains_transparent_pixels(unsigned int *palette,
                                              unsigned char *image,
                                              unsigned int max_bytes,
                                              Color mask);
/**
 * Draws a pixel, if it not equal to the provided mask
 *
 * No bounds checking is performed, make sure all arguments are proper or
 * out-of-bounds memory writes will be performed!
 *
 * @param x The x position of the pixel
 * @param y The y position of the pixel
 * @param color The 30-bit color of the pixel
 * @param mask The 30-bit color of the mask, if this is equal to the color,
 * nothing will be drawn to the screen
 */
void vga_draw_transparent_pixel(unsigned int x, unsigned int y, Color color,
                                Color mask);
/**
 * Draws an image to the screen, supporting transparency
 *
 * No bounds checking is performed, make sure all arguments are proper or
 * out-of-bounds memory writes will be performed!
 *
 * @param x The topleft corner x position
 * @param y The topleft corner y position
 * @param w The width of the image
 * @param palette A pointer to a color array
 * @param image A pointer to the image data array
 * @param max_bytes The length of the image data array
 * @param mask The mask indicating which pixel is transparent
 *
 * @warning The color mask is the 30-bit color! **NOT** the index to the color
 * palette. If the color is not found within the image, no pixel will be
 * transparent
 *
 * @warning The palette pointer must point to an array with a length of 8. Each
 * entry must be 32 bits wide and each entry contains a 30-bit color.
 *
 * @note The image height is not needed, as the combination of `width` and
 * `max_bytes` is enough to draw the image at it's appropiate height
 *
 * @note The image is an encoded image format. There is a tool available on our
 * repository to convert PNGs into this encoded image format
 */
void vga_draw_transparent_image(int x, int y, unsigned char w,
                                unsigned int *palette, unsigned char *image,
                                unsigned int max_bytes, Color mask);

#endif
