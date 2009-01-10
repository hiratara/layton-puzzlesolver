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
          Layton_SlidePuzzle_State state;
      CODE:
          state.data = data;
          state.x    = x;
          state.y    = y;
#          state.data = SvPV_nolen(data);
#          state.x    = SvIV(x);
#          state.y    = SvIV(y);
          RETVAL = &state;
          printf("%p %d %d\n", &state, state.x, state.y);
      OUTPUT:
          RETVAL

char get(Layton_SlidePuzzle_State *self, U8 x, U8 y)
      CODE:
          printf("%p %d %d %d %d\n", self, x, y, self->x, self->y);
          RETVAL = self->data[self->x * y + x];
      OUTPUT:
          RETVAL
