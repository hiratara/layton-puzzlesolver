#ifndef LAYTON_SLIDEPUZZLE_STATE_H
#define LAYTON_SLIDEPUZZLE_STATE_H

typedef struct _Layton_SlidePuzzle_State{
    char *data;
} Layton_SlidePuzzle_State;

Layton_SlidePuzzle_State *State_new(char *class, char *data, int len);

void State_DESTROY(Layton_SlidePuzzle_State *state);

char *State_id(Layton_SlidePuzzle_State *self);

#endif
