package XML::EPP::Host::Create;
use Moose;
use PRANG::Graph;
sub root_element { "create" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	;

has_element 'name' =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
	;

use XML::EPP::Host::Address;

has_element 'addr' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Host::Address]",
	xml_min => 0,
	coerce => 1,
	;

1;
