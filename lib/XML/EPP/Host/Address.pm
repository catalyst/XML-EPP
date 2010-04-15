package XML::EPP::Host::Address;
use Moose;
use PRANG::Graph;
with 'XML::EPP::Host::Node';
has_element "name" =>
	is => "ro",
	isa => "XML::EPP::Host::addrStringType",
	xml_nodeName => "",
	coerce => 1,
	;

has_attr "ip" =>
	is => "ro",
	isa => "XML::EPP::Host::ipType",
	default => "v4",
	;

1;
