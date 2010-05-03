
package XML::EPP::Contact;
use Moose::Role;

with qw(XML::EPP::Plugin PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;
use XML::EPP::Common;

our $PKG;

BEGIN {
	$PKG = "XML::EPP::Contact";
}

use XML::EPP::Contact::Check;

use XML::EPP::Contact::Check::Response;

1;
