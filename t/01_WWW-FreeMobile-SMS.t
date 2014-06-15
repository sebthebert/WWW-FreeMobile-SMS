use strict;
use warnings;

use FindBin; 
use Test::More;

use lib "$FindBin::Bin/../lib/";

use_ok 'WWW::FreeMobile::SMS';

#
# checks new() function
#
my $sms = WWW::FreeMobile::SMS->new();
ok(! defined $sms, "WWW::FreeMobile::SMS->new() => undef");

done_testing(2);