#include <stdio.h>
#include <system.h>
#include <sys/alt_irq.h>
#include <altera_avalon_pio_regs.h>
#include <io.h>
#include <unistd.h>

#define DEBUG

void init_pio_interrupt(void);
static void pio_request_isr(void* context, alt_u32 id);

volatile int edge_capture;
volatile int flag_1 = 0;

int main(void)
{
	init_pio_interrupt();
	IOWR(PIO_PIXEL_COLOR_BASE,0,0);

	while(1) {
		usleep(1000000);
		printf("edge_capture value: %i\n",edge_capture);
		if(edge_capture > 0) {
			printf("Interrupted!\n");
			edge_capture = 0;
		}
	}
}

void init_pio_interrupt(void)
{
	// Register ISR with HAL cus pain
	// List of commands
	/*
	 * alt_irq_register()
	 * alt_irq_disable()
	 * alt_irq_enable()
	 * alt_irq_enable_all()
	 * alt_irq_disable_all()
	 * alt_irq_interruptible()
	 * alt_irq_non_interruptible()
	 * alt_ic_irq_enabled()
	 */
	void* edge_capture_ptr = (void*) &edge_capture;
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_REQUEST_BASE,1); // Set IRQ mask for the 1 pin.
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE,0); // Reset edge capture register.
	alt_irq_register(PIO_REQUEST_IRQ,edge_capture_ptr,pio_request_isr); // Register IRQ with HAL.

#ifdef DEBUG
	printf("PIO Request Pin Value: %i (Should be 0)\n",(IORD(PIO_REQUEST_BASE,0)));
	printf("PIO IRQ Mask value: %i (Should be 1)\n",(IORD(PIO_REQUEST_BASE,2)));
	printf("PIO Edge Capture value: %i (Should be 0)\n",(IORD(PIO_REQUEST_BASE,3)));
#endif
}

static void pio_request_isr(void* context, alt_u32 id)
{
	volatile int* edge_capture_ptr = (volatile int*) context; // Cast context to edge capture's type, and put it in there
	*edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE); // Write edge cap register to edge cap pointer var memory adress.
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE,0); // Now there is escape for u

	IOWR(PIO_PIXEL_COLOR_BASE,0,0x00FFFF02);
#ifdef DEBUG
	printf("Interrupted (from ISR)\n");
#endif

}
