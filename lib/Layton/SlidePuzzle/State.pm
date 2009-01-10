package Layton::SlidePuzzle::State;
use strict;
use warnings;

use overload '""' => 'as_string';

our $DATA_COL   = 0;
our $X_COL      = 1;
our $Y_COL      = 2;

our $BASE = ord('a');

# static function
sub data_from_table{
	my $table = shift;

	my $x = undef;
	my $y = @$table;
	foreach(0 .. $y - 1){
		$x = @{ $table->[$_] } unless defined $x;
		$x == @{ $table->[$_] } or die;
	}

	my $data = join('', map {join('', map {chr($_ + $BASE)} @$_)} @$table);
	return $data, $x, $y;
}

sub new{
	my $class = shift;
	my ($data, $x, $y) = @_;

	bless [$data, $x, $y], $class;
}

sub as_string{
	my $self = shift;
	my $ret = '';
	foreach my $y(0 .. $self->[$Y_COL] - 1){
		foreach my $x(0 .. $self->[$X_COL] - 1){
			$ret .= sprintf(
				'%2d ', 
				$self->get($x, $y),
			);
		}
		$ret .= "\n";
	}
	return $ret;
}

sub set{
	my $self = shift;
	my ($x, $y, $val) = @_;

	my $chr = chr($val + $BASE);

	substr($self->[$DATA_COL], $y * $self->[$X_COL] + $x, 1) = $chr;
}

sub get{
	my $self = shift;
	my ($x, $y) = @_;

	my $chr = substr($self->[$DATA_COL], $y * $self->[$X_COL] + $x, 1);

	return ord($chr) - $BASE;
}

sub id{
	my $self = shift;
	return $self->[$DATA_COL];
}

1;
