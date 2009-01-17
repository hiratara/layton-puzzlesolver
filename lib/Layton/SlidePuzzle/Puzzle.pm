package Layton::SlidePuzzle::Puzzle;
use strict;
use warnings;
use base qw/Class::Accessor::Fast/;
use Layton::SlidePuzzle::State;
__PACKAGE__->mk_accessors(qw/initial_state goal_func board/);

sub new{
	my $class = shift;
	my $self = $class->SUPER::new({
		initial_state => undef,
		board         => undef,
		goal_func     => sub {1},
		@_,
	});

	# parse board data.
	my ($data, $x, $y) = Layton::SlidePuzzle::State::data_from_table(
		$self->initial_state
	);
	my %blocks = map {$_ => 1} 
	             grep {$_ > 0} ( map { @{$_} } @{ $self->initial_state } );
	my $blocks = join('', map {chr($_)} keys %blocks);

	$self->board( Layton::SlidePuzzle::Board->new($x, $y, $blocks) );
	$self->initial_state(Layton::SlidePuzzle::State->new($data, length($data)));

	return $self;
}

sub next_states{
	my $self = shift;
	my @ret = @{ $self->board->next_states(@_) };
	# print 'NEXTS:', scalar @ret, "\n";
	# print map {$_->id, "\n"} @ret;
	return @ret;
}


# sub _next_with{
# 	my ($state, $ref_block, $move_func) = @_;

# # 	{
# # 		id => 1,
# # 		points => [{x => , y => }],
# # 	}

# #	ref $state or die;

# 	my ($w, $h) = (
# 		Layton::SlidePuzzle::State::x($state),
# 		Layton::SlidePuzzle::State::y($state),
# 	);
# 	my $block_id = $ref_block->{id};

# 	my (@move_to, @move_from);

# 	foreach my $ref_point ( @{ $ref_block->{points} } ){
# 		my ($x, $y)   = @$ref_point;
# 		my ($x2, $y2) = $move_func->($x, $y);
# 		return () if $x2 < 0 || $x2 >= $w 
# 		          || $y2 < 0 || $y2 >= $h;
# 		my $block_move_to = Layton::SlidePuzzle::State::get($state, $x2, $y2);
# 		return () if $block_move_to != 0
# 		          && $block_move_to != $block_id;
# 		push @move_from, [$x , $y ];
# 		push @move_to  , [$x2, $y2];
# 	}

# 	my $next = Layton::SlidePuzzle::State::clone($state);
# 	foreach(@move_from){
# 		Layton::SlidePuzzle::State::set($next, @$_, 0);
# 	}

# 	foreach(@move_to){
# 		Layton::SlidePuzzle::State::set($next, @$_, $block_id);
# 	}

# 	return $next;
# }

# sub _right{ $_[0] + 1, $_[1]     };
# sub _left { $_[0] - 1, $_[1]     };
# sub _down { $_[0]    , $_[1] + 1 };
# sub _up   { $_[0]    , $_[1] - 1 };


# sub next_states{
# 	my $self = shift;
# 	my ($state) = @_;

# 	my %blocks;
# 	my ($w, $h) = (
# 		Layton::SlidePuzzle::State::x($state),
# 		Layton::SlidePuzzle::State::y($state),
# 	);
# 	foreach my $y (0 .. $h - 1){
# 		foreach my $x (0 .. $w - 1){
# 			my $b = Layton::SlidePuzzle::State::get($state, $x, $y);
# 			next if $b <= 0;
# 			push @{ $blocks{$b} }, [$x, $y];
# 		}
# 	}

# 	my @next_states;
# 	foreach my $block_num (keys %blocks){
# 		my $ref_block = {id => $block_num, points => $blocks{$block_num}};
# 		push @next_states, _next_with($state, $ref_block, \&_right),
# 		                   _next_with($state, $ref_block, \&_left ),
# 		                   _next_with($state, $ref_block, \&_down ),
# 		                   _next_with($state, $ref_block, \&_up   );
# 	}
# 	return @next_states;
# }


1;
