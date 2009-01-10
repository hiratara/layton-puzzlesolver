package Layton::PuzzleSkel::Puzzle;
use strict;
use warnings;
use Layton::PuzzleSkel::State;

sub new{
	my $class = shift;
	bless {}, $class;
}

sub initial_state{
	return Layton::PuzzleSkel::State->new;
}

sub _goal{
	my $state = shift;
	return UNIVERSAL::isa($state, 'Layton::PuzzleSkel::State');
}

sub goal_func{
	my $self = shift;
	return \&_goal;
}

sub next_states{
	my $self = shift;
	my ($state) = @_;

	return Layton::PuzzleSkel::State->new, Layton::PuzzleSkel::State->new;
}

1;
