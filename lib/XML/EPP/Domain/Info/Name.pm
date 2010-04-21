
package XML::EPP::Domain::Info::Name;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Domain::Node';

has_element 'value' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	xml_nodeName => '',
	;

has_attr 'hosts' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::hostsType',
	default => 'all',
	;

1;
