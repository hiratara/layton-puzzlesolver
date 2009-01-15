use strict;
use warnings;
use Test::More tests => 5;

use Layton::PuzzleSolver;
use Layton::SlidePuzzle::Puzzle;
use Layton::SlidePuzzle::State;


my $puzzle = Layton::SlidePuzzle::Puzzle->new(
	initial_state => Layton::SlidePuzzle::State->new(
		Layton::SlidePuzzle::State::data_from_table([
			[-1, 0, 1],
			[ 2, 2, 0],
			[ 2, 0, 0],
		])
	),
	goal_func => sub {
		my $state = shift;
		return 0 unless $state->get(2, 0) == 2;
		return 0 unless $state->get(0, 2) == 1;
		return 1;
	},
);

my $solver = Layton::PuzzleSolver->new(puzzle => $puzzle);
my @answer = $solver->run;

is(scalar( @answer ), 7, 'min answer');
my $start = $answer[0];
is( $start->get(2, 0), 1, 'START(1)');
is( $start->get(0, 2), 2, 'START(2)');

my $end   = $answer[-1];
is( $end->get(2, 0), 2, 'END(1)');
is( $end->get(0, 2), 1, 'END(2)');

diag join("###########\n", @answer);
