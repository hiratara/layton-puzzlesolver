use strict;
use warnings;
# use Test::More tests => 4;
use Test::More tests => 1;
BEGIN{ use_ok 'Layton::SlidePuzzle::State' };

__END__
# my $state = State->new('aaaabaaaabbb', 3, 4, [0, 1]);

my $state = Layton::SlidePuzzle::State->new(
	Layton::SlidePuzzle::State::data_from_table([
		[0, 0, 0],
		[0, 1, 0],
		[0, 0, 0],
		[1, 1, 1],
	])
);
diag $state;

is($state->get(2, 3), 1, 'get');

is($state->get(0, 2), 0, 'before set');
$state->set(0, 2, 1);
is($state->get(0, 2), 1, 'after set');

diag $state;
