/**
 * @file
 * @brief The module responsible for reading and managing audio input
 */

#ifndef __AUDIO_H__
#define __AUDIO_H__

/**
 * Configures the audio device. Should only be invoked once
 *
 * @return 0 - If audio setup has properly been setup
 * @return 1 - If failed to open configuration devices
 */
int audio_init();

/**
 * Calculates the average audio sample of the samples in the current FIFO buffer
 *
 * It is not possible to know over how many samples this average was calculated,
 * however it is gauranteed to be within 1 and 128 samples
 *
 * @note If the sample size within the FIFO is below 1, a negative integer will
 * be returned
 *
 * @return The average audio sample
 */
int audio_get_average();

#endif
