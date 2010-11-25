use ExtUtils::testlib;
use Test::More;
BEGIN { use_ok('Text::CVS::Tab') };

my $file = 'example/test.cvs';

SKIP: {
    skip "POSIX not installed", 'no_plan' unless -e $file;
    my $tcvs = Text::CVS::Tab->parse($file);
    is(defined $tcvs ? 1 : 0,1,"check succeful create object");
    my $fields = $tcvs->fields;
    is(ref $fields,'ARRAY',"check succeful fields - 1");
    my $hash = $tcvs->next;
    is(ref $hash,'HASH',"check succeful fields - 1");
};

done_testing();
