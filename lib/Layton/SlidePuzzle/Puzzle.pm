package Layton::SlidePuzzle::Puzzle;
use strict;
use warnings;
use base qw/Class::Accessor::Fast/;
use Layton::SlidePuzzle::State;
__PACKAGE__->mk_accessors(qw/initial_state goal_func/);

sub new{
	my $class = shift;
	my $self = $class->SUPER::new({
		initial_state => undef,
		goal_func     => sub {1},
		@_,
	});

	return $self;
}

sub _next_with{
	my $self    = shift;
	my ($state, $ref_block, $move_func) = @_;

# 	{
# 		id => 1,
# 		points => [{x => , y => }],
# 	}

#	ref $state or die;

	my ($w, $h) = (
		$state->x,
		$state->y,
	);
	my $block_id = $ref_block->{id};

	my (@move_to, @move_from);

	foreach my $ref_point ( @{ $ref_block->{points} } ){
		my ($x, $y) = ($ref_point->{x}, $ref_point->{y});
		next if Layton::SlidePuzzle::State::get($state, $x, $y) != $block_id;
		my ($x2, $y2) = $move_func->($x, $y);
		return () if $x2 < 0 || $x2 >= $w 
		          || $y2 < 0 || $y2 >= $h;
		my $block_move_to = Layton::SlidePuzzle::State::get($state, $x2, $y2);
		return () if $block_move_to != 0
		          && $block_move_to != $block_id;
		push @move_from, {x => $x , y => $y };
		push @move_to  , {x => $x2, y => $y2};
	}

	my $next = Layton::SlidePuzzle::State->new(
		$state->id, $state->x, $state->y
	);
	foreach(@move_from){
		Layton::SlidePuzzle::State::set($next, $_->{x}, $_->{y}, 0);
	}

	foreach(@move_to){
		Layton::SlidePuzzle::State::set($next, $_->{x}, $_->{y}, $block_id);
	}

	return $next;
}

sub next_states{
	my $self = shift;
	my ($state) = @_;

	my %blocks;
	foreach my $y (0 .. $state->y - 1){
		foreach my $x (0 .. $state->x - 1){
			next if Layton::SlidePuzzle::State::get($state, $x, $y) <= 0;
			push @{ $blocks{Layton::SlidePuzzle::State::get($state, $x, $y)} }, 
			     {x => $x, y => $y};
		}
	}

	my @next_states;
	foreach my $block_num (keys %blocks){
		my $ref_block = {id => $block_num, points => $blocks{$block_num}};
		push @next_states, $self->_next_with($state, $ref_block, 
		                                     sub {$_[0] + 1, $_[1]}  ),
		                   $self->_next_with($state, $ref_block, 
		                                     sub {$_[0] - 1, $_[1]}  ),
		                   $self->_next_with($state, $ref_block, 
		                                     sub {$_[0], $_[1] + 1}  ),
		                   $self->_next_with($state, $ref_block, 
		                                     sub {$_[0], $_[1] - 1}  );
	}
	return @next_states;
}


1;
