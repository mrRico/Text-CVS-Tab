#!/usr/bin/perl
use strict;
use warnings;

use ExtUtils::testlib; 
use lib 'lib';
use Text::CVS::Tab;

my $file = 'example/test.cvs';

sub my_parse {
    my $tcvs = Text::CVS::Tab->parse($file);
    while($tcvs->next) {
        1;
    }
};

sub st_parse {
    open(TXT,"<".$file);
    while(<TXT>) {
        s/[\r|\n]+$//;
        next unless $_;
        my @ee = split("\t",$_);
        1;        
    }
}

use Benchmark qw(:all);

    cmpthese(1000, {
        'New' => sub{my_parse()},
        'Old' => sub{st_parse()}
    });



1;
exit;
__DATA__
