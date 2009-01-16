use strict;
use warnings;
use inc::Module::Install;

name 'Layton-PuzzleSolver';
all_from 'lib/Layton/PuzzleSolver.pm';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';

{
	no strict 'subs';
	use_test_base;
}
auto_include;

# makemaker_args 'DIR' => ['state'];

# cc_inc_paths '.';
cc_files 'state.c', 'board.c', 'XS.c';

WriteAll;
