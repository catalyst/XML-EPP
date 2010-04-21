
package XML::EPP::Domain::RQ;

use Moose::Role;

with qw(XML::EPP::Domain);

sub is_command { 1 }

1;
