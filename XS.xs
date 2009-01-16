#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <stdio.h>
#include "state.h"
#include "board.h"
/* #include "ppport.h" */

MODULE = Layton::PuzzleSolver PACKAGE = Layton::SlidePuzzle::State PREFIX=State_

Layton_SlidePuzzle_State *State_new(char *class, char *data, int len)

void State_DESTROY(Layton_SlidePuzzle_State *state)

char *State_id(Layton_SlidePuzzle_State *self)



MODULE = Layton::PuzzleSolver PACKAGE = Layton::SlidePuzzle::Board PREFIX=Board_

Layton_SlidePuzzle_Board *Board_new(char *class, int x, int y)

void Board_DESTROY(Layton_SlidePuzzle_Board *board)

AV* Board_next_states(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state)

int Board_get_from_state(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state, U8 x, U8 y)

void Board_set_to_state(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state, U8 x, U8 y, int val)
