package XML::EPP::Host::RS;
use Moose::Role;
with qw(XML::EPP::Host);
sub is_command { 0 }
1;
