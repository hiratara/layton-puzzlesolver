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
          state->data = (char *)malloc( data_size );
          memcpy(state->data, data, data_size);
          state->x = x;
          state->y = y;
          RETVAL = state;
      OUTPUT:
          RETVAL

Layton_SlidePuzzle_State *clone(Layton_SlidePuzzle_State *self)
      PREINIT:
         Layton_SlidePuzzle_State *new;
         int data_size;
      CODE:
          new = (Layton_SlidePuzzle_State *) 
                                     malloc( sizeof(Layton_SlidePuzzle_State) );
          data_size = sizeof( char ) * self->x * self->y;
          new->x = self->x;
          new->y = self->y;
          new->data = (char *) malloc( data_size );
          memcpy(new->data, self->data, data_size);
          RETVAL = new;
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
          char *id;
          int  len;
      CODE:
          len = self->x * self->y;
          id = malloc( sizeof( char ) * (len + 1) );
          strncpy(id, self->data, len);
          id[len] = '\0';
          RETVAL = id;
      OUTPUT:
          RETVAL
