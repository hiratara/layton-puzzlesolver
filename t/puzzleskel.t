use strict;
use warnings;
use Test::More tests => 1;

use Layton::PuzzleSolver;
use Layton::PuzzleSkel::Puzzle;
use Layton::PuzzleSkel::State;


my $puzzle = Layton::PuzzleSkel::Puzzle->new;

my $solver = Layton::PuzzleSolver->new(puzzle => $puzzle);
my @answer = $solver->run;

is(scalar( @answer ), 1, 'got an answer');
