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
