
package XML::EPP::Host::Notification::Result;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Host::Node';

has_element "name" =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
	xml_nodeName => "",
	;

has_attr "approved" =>
	is => "ro",
	isa => "PRANG::XMLSchema::boolean",
	required => 1,
	xml_name => "paResult",
	;

1;
