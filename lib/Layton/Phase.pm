package Layton::Phase;
use strict;
use warnings;
use overload '""' => 'as_string';
use base qw/Class::Accessor::Fast/;
__PACKAGE__->mk_accessors(qw/state before/);

sub new{
	my $class = shift;
	my $self = $class->SUPER::new({
		state   => undef,
		before  => undef,
		@_,
	});

	return $self;
}

sub as_string{
	my $self = shift;
	return "" . $self->state;
}

1;
