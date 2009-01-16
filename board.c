#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "state.h"
#include "board.h"

Layton_SlidePuzzle_Board *Board_new(char *class, int x, int y){
  Layton_SlidePuzzle_Board *board;
  New(NULL, board, 1, Layton_SlidePuzzle_Board);
  board->x = x;
  board->y = y;
  return board;
}

void Board_DESTROY(Layton_SlidePuzzle_Board *board) {
  Safefree(board);
}

AV* Board_next_states(Layton_SlidePuzzle_Board *board, Layton_SlidePuzzle_State *state){
  AV *ret = newAV();
  SV *st  = newSV(0);

  /* typemapな定義使えないのかなあ？ */
  sv_setref_pv(st, "Layton::SlidePuzzle::State", (void *) state);
  av_push(ret, st);
  return ret;
}

int Board_get_from_state(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state, U8 x, U8 y){
  return state->data[self->x * y + x] - 'a';
}

void Board_set_to_state(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state, U8 x, U8 y, int val){
  state->data[self->x * y + x] = (char)( 'a' + val );
}
