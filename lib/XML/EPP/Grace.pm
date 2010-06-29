
package XML::EPP::Grace;
use Moose::Role;

with qw(XML::EPP::Extension::Type PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;
use XML::EPP::Common;

our $PKG;

BEGIN {
	$PKG = "XML::EPP::Grace";
}

#use XML::EPP::Domain::Update;

1;
