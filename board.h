#ifndef LAYTON_SLIDEPUZZLE_BOARD_H
#define LAYTON_SLIDEPUZZLE_BOARD_H

#include "EXTERN.h"
#include "perl.h"
#include "state.h"

typedef struct _Layton_SlidePuzzle_Board{
    int x;
    int y;
} Layton_SlidePuzzle_Board;

Layton_SlidePuzzle_Board *Board_new(char *class, int x, int y);

void Board_DESTROY(Layton_SlidePuzzle_Board *board);

AV* Board_next_states(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state);

int Board_get_from_state(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state, U8 x, U8 y);

void Board_set_to_state(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state, U8 x, U8 y, int val);

#endif
