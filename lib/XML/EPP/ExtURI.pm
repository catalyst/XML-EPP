
package XML::EPP::ExtURI;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
our $SCHEMA_PKG = "XML::EPP";

use PRANG::Graph;

has_element 'extensions' =>
	is => "rw",
	isa => "ArrayRef[PRANG::XMLSchema::anyURI]",
	required => 1,
	xml_nodeName => "extURI",
	auto_deref => 1,
	;

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::extURIType"
	=> as __PACKAGE__;

1;
