#include <stdio.h>
#include <system.h>
#include <sys/alt_irq.h>
#include <altera_avalon_pio_regs.h>

void init_pio_interrupt(void);
static void pio_request_isr(void* context, alt_u32 id);

volatile int edge_capture;
volatile int flag_1 = 0;

int main(void)
{
	int funni = 0;
	init_pio_interrupt();

	while(1) {
		if (flag_1 > 0) {
			printf("Flag triggered!");
			flag_1 = 0;
		} else {
			funni++;
			if (funni > 100) { funni = 0; }
			IOWR(PIO_PIXEL_COLOR_BASE,0,funni);
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

	printf("Pain");

	void* edge_capture_ptr = (void*) &edge_capture;
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_REQUEST_BASE,0xf);
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE,0x0);
	alt_irq_register(PIO_REQUEST_IRQ,edge_capture_ptr,pio_request_isr);
}

static void pio_request_isr(void* context, alt_u32 id)
{
	//volatile int* edge_capture_ptr = (volatile int*) context;
	//*edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE);
	flag_1 = 1;
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE,0x0);
	IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE);
	IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE);
	IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_REQUEST_BASE);
	return;
}
