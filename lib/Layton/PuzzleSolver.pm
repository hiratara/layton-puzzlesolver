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

our $MAX = 10;
sub run{
	my $self = shift;

	my $puzzle = $self->puzzle;
	my $goal_func   = $puzzle->goal_func;

	my %branch;
	my %min_turn;
	my @ans = ($puzzle->initial_state);

	LOOP: while(@ans){
		my $current = $ans[-1];

		if ( $goal_func->($current) ) {
			last LOOP;
		}

		if(@ans >= $MAX){
			# no way...
			$branch{$current->id} and die;  #DEBUG
			pop @ans;
			next;
		}

		if(! exists $branch{$current->id}){
			# first visited.
			$branch{$current->id} = [ 
				grep { ! exists $branch{$_->id} }
				$puzzle->next_states($current) 
			];
		}

		if(! @{ $branch{$current->id} }){
			# no way...
			delete $branch{$current->id};  # retry(maybe more fast turn)
			pop @ans;
		}else{
			my $next = shift @{ $branch{$current->id} };
			push @ans, $next ;
		}
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
