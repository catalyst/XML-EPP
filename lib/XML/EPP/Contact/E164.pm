
package XML::EPP::Contact::E164;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;
use PRANG::XMLSchema::Types;

our $SCHEMA_PKG = "XML::EPP::Contact";

has_attr 'x' =>
	is => 'rw',
	isa => 'PRANG::XMLSchema::token',
	;

has_element 'content' =>
	is => 'rw',
	isa => 'XML::EPP::Contact::e164StringType',
	xml_nodeName => '',
	;

with 'XML::EPP::Common::Node';

subtype "${SCHEMA_PKG}::pwAuthInfoType"
	=> as __PACKAGE__;

1;
