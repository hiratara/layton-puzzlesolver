use strict;
use warnings;

use Layton::PuzzleSolver;
use Layton::SlidePuzzle::Puzzle;
use Layton::SlidePuzzle::State;

my $puzzle = Layton::SlidePuzzle::Puzzle->new(
	initial_state => [
		[-1,-1, 0, 1, 1,-1,-1],
		[ 0, 0, 0, 0, 1, 2,-1],
		[ 0, 8, 0, 2, 2, 2, 0],
		[ 8, 8, 0, 6, 0, 3, 3],
		[ 8, 7, 0, 5, 0, 3, 4],
		[-1, 7, 7, 5, 5, 4, 4],
		[-1,-1, 0, 5, 0,-1,-1],
	],
	goal_func => sub {
		my ($table, $puzzle) = @_;
# 		foreach my $x(1 .. 5){
# 			foreach my $y(1 .. 5){
# 				return 0 
# 				        if Layton::SlidePuzzle::State::get($table, $x, $y) <= 0;
# 			}
# 		}
		my $board = $puzzle->board;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 2, 0) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 3, 0) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 4, 0) and return 0;

		Layton::SlidePuzzle::Board::get_from_state($board, $table, 0, 1) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 0, 2) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 0, 3) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 0, 4) and return 0;

		Layton::SlidePuzzle::Board::get_from_state($board, $table, 6, 2) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 6, 3) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 6, 4) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 6, 5) and return 0;

		Layton::SlidePuzzle::Board::get_from_state($board, $table, 2, 6) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 3, 6) and return 0;
		Layton::SlidePuzzle::Board::get_from_state($board, $table, 4, 6) and return 0;
		return 1;
	},
);

my $solver = Layton::PuzzleSolver->new(puzzle => $puzzle);
my @answer = $solver->run;

my $file = 'result' . time . '.txt';
open my $out, '>', $file;
foreach(@answer){
  print $out "$_\n";
  print $out "#################\n";
}
close($out);

__END__

#     [14, 1, 7, 8],
#     [ 4, 0, 6, 9],
#     [15, 5, 2,12],
#     [ 3,11,13,10],
 
# sub {
#   my $table = shift;
#   foreach my $x(0 .. 3){
#     foreach my $y(0 .. 3){
#       return 0 unless $table->get($x, $y) == $x * 4 + $y;
#     }
#   }
#   return 1;
# }
