
package XML::EPP::Contact::RQ;

use Moose::Role;

with qw(XML::EPP::Contact);

sub is_command { 1 }

1;
