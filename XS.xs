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
          int n, len;
          Layton_SlidePuzzle_State *state;
      CODE:
          New(NULL, state, 1, Layton_SlidePuzzle_State);
          len = x * y;
          New(NULL, state->data, len + 1, char);
          memcpy(state->data, data, len);
          state->data[len] = '\0';
          state->x = x;
          state->y = y;
          RETVAL = state;
      OUTPUT:
          RETVAL

Layton_SlidePuzzle_State *clone(Layton_SlidePuzzle_State *self)
      PREINIT:
         Layton_SlidePuzzle_State *new;
         int len;
      CODE:
          New(NULL, new, 1, Layton_SlidePuzzle_State);
          len = self->x * self->y;
          new->x = self->x;
          new->y = self->y;
          New(NULL, new->data, len + 1, char);
          memcpy(new->data, self->data, len);
          new->data[len] = '\0';
          RETVAL = new;
      OUTPUT:
          RETVAL


void DESTROY(Layton_SlidePuzzle_State *state) 
     PPCODE:
         Safefree(state->data);
         Safefree(state);

int get(Layton_SlidePuzzle_State *self, U8 x, U8 y)
      CODE:
          RETVAL = self->data[self->x * y + x] - 'a';
      OUTPUT:
          RETVAL

int set(Layton_SlidePuzzle_State *self, U8 x, U8 y, int val)
      CODE:
          self->data[self->x * y + x] = (char)( 'a' + val );

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

char *id(Layton_SlidePuzzle_State *self)
#      PREINIT:
#          char *id;
#          int  len;
      CODE:
#          len = self->x * self->y;
#          id = malloc( sizeof( char ) * (len + 1) );
#          strncpy(id, self->data, len);
#          id[len] = '\0';
#          RETVAL = id;
          RETVAL = self->data;
      OUTPUT:
          RETVAL
