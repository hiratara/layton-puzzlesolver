#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <stdio.h>
/* #include "ppport.h" */

typedef struct _Layton_SlidePuzzle_State{
    char *data;
    U8 x;
    U8 y;
} Layton_SlidePuzzle_State;


MODULE = Layton::PuzzleSolver PACKAGE = Layton::SlidePuzzle::State

Layton_SlidePuzzle_State *new(char *class, char *data, U8 x, U8 y)
      PREINIT:
          int n;
          Layton_SlidePuzzle_State *state;
      CODE:
          state = (Layton_SlidePuzzle_State *) 
                                     malloc( sizeof(Layton_SlidePuzzle_State) );
          state->data = data;
          state->x    = x;
          state->y    = y;
          RETVAL = state;
      OUTPUT:
          RETVAL

int get(Layton_SlidePuzzle_State *self, U8 x, U8 y)
      CODE:

          RETVAL = self->data[self->x * y + x] - 'a';
      OUTPUT:
          RETVAL

int set(Layton_SlidePuzzle_State *self, U8 x, U8 y, int val)
      CODE:
          self->data[self->x * y + x] = (char)( 'a' + val );

void DESTROY(Layton_SlidePuzzle_State *state) 
     PPCODE:
         free(state);

int x(Layton_SlidePuzzle_State *self)
      CODE:
          RETVAL = self->x;
      OUTPUT:
          RETVAL

int y(Layton_SlidePuzzle_State *self)
      CODE:
          RETVAL = self->y;
      OUTPUT:
          RETVAL
