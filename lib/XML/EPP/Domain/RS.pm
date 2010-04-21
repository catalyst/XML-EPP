
package XML::EPP::Domain::RS;

use Moose::Role;

with qw(XML::EPP::Domain);

sub is_command { 0 }

1;
