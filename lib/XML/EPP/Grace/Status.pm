
package XML::EPP::Grace::Status;

use Moose;
use PRANG::Graph;
use PRANG::XMLSchema::Types;

has_element "description" =>
	is => "ro",
	isa => "PRANG::XMLSchema::normalizedString",
	xml_nodeName => "",
	;

has_attr "value" =>
	is => "ro",
	isa => "XML::EPP::Grace::statusValueType",
	required => 1,
	xml_name => "s",  # yep, "s"
	;

has_attr "lang" =>
	is => "ro",
	isa => "PRANG::XMLSchema::language",
	default => "en",
	;

with 'XML::EPP::Grace::Node';

1;
