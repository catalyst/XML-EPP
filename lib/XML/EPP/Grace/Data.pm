
package XML::EPP::Grace::Data;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Grace::Node';

use XML::EPP::Grace::Status;
has_element 'statuses' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Grace::Status]',
	xml_nodeName => "rgpStatus",
	;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Grace::respDataType"
	=> as __PACKAGE__;

1;
