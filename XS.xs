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
          int n, data_size;
          Layton_SlidePuzzle_State *state;
      CODE:
          state = (Layton_SlidePuzzle_State *) 
                                     malloc( sizeof(Layton_SlidePuzzle_State) );
          data_size = sizeof( char ) * x * y;
          state->data = malloc( data_size + 1);
          memcpy(state->data, data, data_size);
          state->data[0];
          state->x = x;
          state->y = y;
          RETVAL = state;
      OUTPUT:
          RETVAL

void DESTROY(Layton_SlidePuzzle_State *state) 
     PPCODE:
         free(state->data);
         free(state);

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
      PREINIT:
#          char *id;
#          int  data_size;
      CODE:
          RETVAL = self->data;
#          data_size = sizeof( char ) * self->x * self->y;
#          id = malloc( data_size + 1);
#          strncpy(id, self->data, data_size);
#          id[data_size] = '\0';
#          printf("%p %p %p\n", self, self->data, id);
#          RETVAL = id;
      OUTPUT:
          RETVAL
