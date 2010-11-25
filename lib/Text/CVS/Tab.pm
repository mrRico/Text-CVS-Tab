package Text::CVS::Tab;

use 5.010;
use strict;
use warnings;

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Text::CVS::Tab', $VERSION);

1;
__END__

=head1 NAME

Text::CVS::Tab - parser for cvs file over tab separated

=head1 SYNOPSIS
    
    my $tcvs = Text::CVS::Tab->parse('/path/to/file') or die $!;
    
    my $arr_ref = $tcvs->fields;
    
    while(my $hash_ref = $tcvs->next) {
            print $hash_ref->{'some_fields'},"\n";
    };
    

=head1 DESCRIPTION

Simple example of PerlXS

=head1 METHODS

=head2 new($file_path)

create an object and read first line as fields name

=head2 fields()

return array ref fields

=head2 next()

return hash ref, where key are fields

=cut
