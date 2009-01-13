typedef struct _Layton_SlidePuzzle_State{
    char *data;
    U8 x;
    U8 y;
} Layton_SlidePuzzle_State;

Layton_SlidePuzzle_State *State_new(char *class, char *data, U8 x, U8 y);

Layton_SlidePuzzle_State *State_clone(Layton_SlidePuzzle_State *self);

void State_DESTROY(Layton_SlidePuzzle_State *state);

int State_get(Layton_SlidePuzzle_State *self, U8 x, U8 y);

void State_set(Layton_SlidePuzzle_State *self, U8 x, U8 y, int val);

int State_x(Layton_SlidePuzzle_State *self);

int State_y(Layton_SlidePuzzle_State *self);

char *State_id(Layton_SlidePuzzle_State *self);
