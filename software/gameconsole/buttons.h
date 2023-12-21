
#ifndef __BUTTONS_H__
#define __BUTTONS_H__

#define IS_SET(n, bit) (n & (1 << bit))
#define GET_BIT(n, bit) ((n & (1 << bit)) >> bit)

typedef struct {
    unsigned int left;
    unsigned int right;
    unsigned int reset;
} InputButtons;

void buttons_preframe(InputButtons* buttons);
void buttons_postframe(InputButtons* buttons);

#endif

