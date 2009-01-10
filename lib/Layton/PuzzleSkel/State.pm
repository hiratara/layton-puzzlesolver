package Layton::PuzzleSkel::State;
use strict;
use warnings;

sub new{
	my $class = shift;
	bless {}, $class;
}

sub id{
	my $self = shift;
	return $self + 0;
}

1;
