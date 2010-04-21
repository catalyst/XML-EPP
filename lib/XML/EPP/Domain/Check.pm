
package XML::EPP::Domain::Check;

use Moose;
use PRANG::Graph;

sub root_element { 'check' }

with
	'XML::EPP::Domain::RQ',
	'XML::EPP::Domain::Node',
	;

has_element 'names' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Common::labelType]',
	xml_nodeName => 'name',
	;

1;
