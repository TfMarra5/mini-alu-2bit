// Behavioral demonstration of the Verilog ALU, not an RTL synthesis.
#include "wokwi-api.h"
#include <stdlib.h>

typedef struct { pin_t in[7], out[5]; } chip_state_t;
static void update(chip_state_t *s) {
  unsigned a = pin_read(s->in[0]) | (pin_read(s->in[1]) << 1);
  unsigned b = pin_read(s->in[2]) | (pin_read(s->in[3]) << 1);
  unsigned op = pin_read(s->in[4]) | (pin_read(s->in[5]) << 1) | (pin_read(s->in[6]) << 2);
  unsigned r = 0, carry = 0, borrow = 0;
  switch (op) {
    case 0: r = a + b; carry = r > 3; break;
    case 1: r = a & b; break;
    case 2: r = a | b; break;
    case 3: r = a ^ b; break;
    case 4: r = a + 4 - b; borrow = a < b; break;
    case 5: r = ~a; break;
    case 6: r = a << 1; break;
    case 7: r = a >> 1; break;
  }
  r &= 3;
  pin_write(s->out[0], r & 1);
  pin_write(s->out[1], (r >> 1) & 1);
  pin_write(s->out[2], carry);
  pin_write(s->out[3], borrow);
  pin_write(s->out[4], r == 0);
}
static void changed(void *data, pin_t pin, uint32_t value) {
  (void)pin; (void)value;
  update(data);
}
void chip_init(void) {
  chip_state_t *s = malloc(sizeof(*s));
  const char *inputs[] = {"A0", "A1", "B0", "B1", "OP0", "OP1", "OP2"};
  const char *outputs[] = {"R0", "R1", "CARRY", "BORROW", "ZERO"};
  for (int i = 0; i < 7; i++) s->in[i] = pin_init(inputs[i], INPUT_PULLDOWN);
  for (int i = 0; i < 5; i++) s->out[i] = pin_init(outputs[i], OUTPUT_LOW);
  pin_watch_config_t watch = {.edge = BOTH, .pin_change = changed, .user_data = s};
  for (int i = 0; i < 7; i++) pin_watch(s->in[i], &watch);
  update(s);
}
