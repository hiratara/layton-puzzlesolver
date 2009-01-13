#include "EXTERN.h"
#include "perl.h"
#include "state.h"

Layton_SlidePuzzle_State *State_new(char *class, char *data, U8 x, U8 y){
  int n, len;
  Layton_SlidePuzzle_State *state;

  New(NULL, state, 1, Layton_SlidePuzzle_State);
  len = x * y;
  New(NULL, state->data, len + 1, char);
  memcpy(state->data, data, len);
  state->data[len] = '\0';
  state->x = x;
  state->y = y;
  return state;
}

Layton_SlidePuzzle_State *State_clone(Layton_SlidePuzzle_State *self){
  Layton_SlidePuzzle_State *new;
  int len;
  New(NULL, new, 1, Layton_SlidePuzzle_State);
  len = self->x * self->y;
  new->x = self->x;
  new->y = self->y;
  New(NULL, new->data, len + 1, char);
  memcpy(new->data, self->data, len);
  new->data[len] = '\0';
  return new;
}

void State_DESTROY(Layton_SlidePuzzle_State *state) {
  Safefree(state->data);
  Safefree(state);
}

int State_get(Layton_SlidePuzzle_State *self, U8 x, U8 y){
  return self->data[self->x * y + x] - 'a';
}

void State_set(Layton_SlidePuzzle_State *self, U8 x, U8 y, int val){
  self->data[self->x * y + x] = (char)( 'a' + val );
}

int State_x(Layton_SlidePuzzle_State *self){
  return self->x;
}

int State_y(Layton_SlidePuzzle_State *self){
  return self->y;
}

char *State_id(Layton_SlidePuzzle_State *self){
  return self->data;
}
