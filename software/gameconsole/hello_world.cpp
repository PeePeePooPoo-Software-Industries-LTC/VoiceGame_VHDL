
#include <stdio.h>

#define SDRAM_BASE ((int*)0x00000000)
#define WRITE_SDRAM(offset, value) *(SDRAM_BASE + offset) = value;
#define READ_SDRAM(offset) (*(SDRAM_BASE + offset))

int main()
{
	WRITE_SDRAM(1, 69);
	printf("%i", READ_SDRAM(1));
	printf("\n");
	printf("%i", READ_SDRAM(0));
	printf("\n");
	printf("%i", READ_SDRAM(2));
	printf("\n");
	printf("%i", READ_SDRAM(3));
}
