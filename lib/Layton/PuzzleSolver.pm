package Layton::PuzzleSolver;

use strict;
use warnings;
use Layton::Phase;
use base qw/Class::Accessor::Fast/;
our $VERSION = '0.01';

__PACKAGE__->mk_accessors(qw/puzzle/);

sub new{
	my $class = shift;

	my $self = $class->SUPER::new({
		puzzle => undef,
		@_,
	});

	return $self;
}

sub run{
	my $self = shift;

	my $puzzle = $self->puzzle;
	my $first_phase = Layton::Phase->new(state => $puzzle->initial_state);
	my $goal_func   = $puzzle->goal_func;

	my %done;
	$done{ $first_phase->state->id } = 1;
	my @current = ( $first_phase );

	my $ans = undef;
	LOOP: while(@current){
		print(scalar keys %done, "\n");
		my @next_phase;
		foreach my $phase (@current) {
			if ( $goal_func->($phase->state) ) {
				$ans = $phase;
				last LOOP;
			}
			foreach my $next_state( $puzzle->next_states($phase->state) ) {
				next if exists $done{$next_state->id};
				$done{$next_state->id} = undef;
				push @next_phase, Layton::Phase->new(
					state => $next_state, 
					before => $phase
				);
			}
		}
		@current = @next_phase;

		# last if $main::DEBUG++ > 15;
	}

	return () unless $ans;

	my @ans;
	for (my $p = $ans; $p; $p = $p->before) {
		unshift @ans, $p->state;
	}

	return @ans;
}



=for comment

package main;
use strict;
use warnings;
my $board = Board->new(
	table => [
		[-1,-1, 0, 1, 1,-1,-1],
		[ 0, 0, 0, 0, 1, 2,-1],
		[ 0, 8, 0, 2, 2, 2, 0],
		[ 8, 8, 0, 6, 0, 3, 3],
		[ 8, 7, 0, 5, 0, 3, 4],
		[-1, 7, 7, 5, 5, 4, 4],
		[-1,-1, 0, 5, 0,-1,-1],
	],
);

sub goal{
	my $table = shift;
	foreach my $x(1 .. 5){
		foreach my $y(1 .. 5){
			return 0 if Table::get($table, $x, $y) <= 0;
		}
	}
	return 1;
}

# my $board = Board->new(
# 	table => [
# 		[14, 1, 7, 8],
# 		[ 4, 0, 6, 9],
# 		[15, 5, 2,12],
# 		[ 3,11,13,10],
# 	]
# );

# sub goal{
# 	my $table = shift;
# 	foreach my $x(0 .. 3){
# 		foreach my $y(0 .. 3){
# 			return 0 unless $table->get($x, $y) == $x * 4 + $y;
# 		}
# 	}
# 	return 1;
# }


my $file = 'result' . time . '.txt';
open my $out, '>', $file;
foreach(@ans){
	print $out "$_\n";
	print $out "#################\n";
}
close($out);

__END__
print $board, "\n";
print $board->id, "\n";
print $board->width, "\n";
print $board->height, "\n";

=cut


1;
__END__

=head1 NAME

Layton::SlidePuzzleSolver -

=head1 SYNOPSIS

  use Layton::SlidePuzzleSolver;

=head1 DESCRIPTION

Layton::SlidePuzzleSolver is

=head1 AUTHOR

Masahiro Honma E<lt>hira.tara {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
