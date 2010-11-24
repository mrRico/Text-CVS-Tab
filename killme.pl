#!/usr/bin/perl
use strict;
use warnings;

use ExtUtils::testlib; 
use lib 'lib';
use Text::CVS::Tab;

my $tcvs = Text::CVS::Tab->new('example/test.cvs');

1;
exit;
__DATA__
