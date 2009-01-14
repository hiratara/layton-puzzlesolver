#include "EXTERN.h"
#include "perl.h"
#include "state.h"
#include "string.h"

Layton_SlidePuzzle_State *State_new(char *class, char *data, int len){
  Layton_SlidePuzzle_State *state;
  New(NULL, state, 1, Layton_SlidePuzzle_State);
  New(NULL, state->data, len + 1, char);
  memcpy(state->data, data, len);
  state->data[len] = '\0';
  return state;
}

void State_DESTROY(Layton_SlidePuzzle_State *state) {
  Safefree(state->data);
  Safefree(state);
}

char *State_id(Layton_SlidePuzzle_State *self){
  return self->data;
}
