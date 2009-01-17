#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "state.h"
#include "board.h"

Layton_SlidePuzzle_Board *Board_new(char *class, int x, int y, char* blocks){
  int block_num;
  Layton_SlidePuzzle_Board *board;
  New(NULL, board, 1, Layton_SlidePuzzle_Board);
  board->x = x;
  board->y = y;

  block_num = strlen(blocks);
  New(NULL, board->blocks, block_num + 1, char);
  strncpy(board->blocks, blocks, block_num);
  board->blocks[block_num] = 0;

  New(NULL, board->move_from_buf, x * y, Point);
  New(NULL, board->move_to_buf  , x * y, Point);
  New(NULL, board->data_buf     , x * y, char);

  return board;
}

void Board_DESTROY(Layton_SlidePuzzle_Board *board) {
  Safefree(board->blocks);
  Safefree(board->move_from_buf);
  Safefree(board->move_to_buf);
  Safefree(board->data_buf);
  Safefree(board);
}


int Board_move_block(Layton_SlidePuzzle_Board *board, Layton_SlidePuzzle_State *state, char *next_data, char block, Point (*move)(Point)){
  int x, y;
  Point p1, p2;
  char block_cur;
  char block_move_to;
  int mfptr = 0, mtptr = 0;

  for(y = 0; y < board->y; y++){
    for(x = 0; x < board->x; x++){
      p1.x = x;
      p1.y = y;
      block_cur = (char) Board_get_from_state(board, state, p1.x, p1.y);
      if(block_cur != block) continue;

      // move check
      p2 = move(p1);
      if(p2.x < 0 || p2.x >= board->x ||
         p2.y < 0 || p2.y >= board->y) return 0;
      // move check
      block_move_to = (char) Board_get_from_state(board, state, p2.x, p2.y);
      if(block_move_to != 0 && block_move_to != block) return 0;

      board->move_from_buf[mfptr++] = p1;
      board->move_to_buf[mtptr++] = p2;
    }
  }

  // copy current state to next state
  memcpy(next_data, state->data, x * y);

  //  printf(" START: %s\n", next_data);

  // remove block
  while(--mfptr >= 0){
    p1 = board->move_from_buf[mfptr];
    Board_set_to_state(board, (Layton_SlidePuzzle_State*)&next_data, p1.x, p1.y, 0);
  }

  //  printf("REMOVE: %s\n", next_data);

  // move block
  while(--mtptr >= 0){
    p2 = board->move_to_buf[mtptr];
    Board_set_to_state(board, (Layton_SlidePuzzle_State*)&next_data, p2.x, p2.y, block);
  }

  //  printf(" MOVED: %s\n", next_data);

  return 1;
}

Point move_up(Point p){
  Point p2;
  p2.x = p.x;
  p2.y = p.y - 1;
  return p2;
}
Point move_right(Point p){
  Point p2;
  p2.x = p.x + 1;
  p2.y = p.y;
  return p2;
}
Point move_left(Point p){
  Point p2;
  p2.x = p.x - 1;
  p2.y = p.y;
  return p2;
}
Point move_down(Point p){
  Point p2;
  p2.x = p.x;
  p2.y = p.y + 1;
  return p2;
}


AV* Board_next_states(Layton_SlidePuzzle_Board *board, Layton_SlidePuzzle_State *state){
  AV *ret = newAV();
  SV *st;
  char *ptr;
  int r;
  Layton_SlidePuzzle_State *new_state;

  for(ptr = board->blocks; *ptr != 0; ptr++){
    r = Board_move_block(board, state, board->data_buf, *ptr, move_up);
    if(r){
      /* typemapな定義使えないのかなあ？ */
      st  = newSV(0);
      new_state = State_new(NULL, board->data_buf, board->x * board->y);
      sv_setref_pv(st, "Layton::SlidePuzzle::State", (void *) new_state);
      av_push(ret, st);
    }
    r = Board_move_block(board, state, board->data_buf, *ptr, move_down);
    if(r){
      /* typemapな定義使えないのかなあ？ */
      st  = newSV(0);
      new_state = State_new(NULL, board->data_buf, board->x * board->y);
      sv_setref_pv(st, "Layton::SlidePuzzle::State", (void *) new_state);
      av_push(ret, st);
    }
    r = Board_move_block(board, state, board->data_buf, *ptr, move_left);
    if(r){
      /* typemapな定義使えないのかなあ？ */
      st  = newSV(0);
      new_state = State_new(NULL, board->data_buf, board->x * board->y);
      sv_setref_pv(st, "Layton::SlidePuzzle::State", (void *) new_state);
      av_push(ret, st);
    }
    r = Board_move_block(board, state, board->data_buf, *ptr, move_right);
    if(r){
      /* typemapな定義使えないのかなあ？ */
      st  = newSV(0);
      new_state = State_new(NULL, board->data_buf, board->x * board->y);
      sv_setref_pv(st, "Layton::SlidePuzzle::State", (void *) new_state);
      av_push(ret, st);
    }
  }

  return ret;
}

int Board_get_from_state(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state, U8 x, U8 y){
  return state->data[self->x * y + x] - 'a';
}

void Board_set_to_state(Layton_SlidePuzzle_Board *self, Layton_SlidePuzzle_State *state, U8 x, U8 y, int val){
  state->data[self->x * y + x] = (char)( 'a' + val );
}
