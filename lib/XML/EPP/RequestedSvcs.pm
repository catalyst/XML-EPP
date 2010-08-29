
package XML::EPP::RequestedSvcs;

# FIXME: make a ::ServiceList role; this is very similar to SvcMenu

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

our $SCHEMA_PKG = "XML::EPP";

has_element 'services' =>
	is => "rw",
	isa => "ArrayRef[PRANG::XMLSchema::anyURI]",
	required => 1,
	xml_nodeName => "objURI",
	auto_deref => 1,
	;

has_element 'ext_services' =>
	is => "rw",
	isa => "XML::EPP::ExtURI",
	predicate => "has_ext_services",
	xml_nodeName => "svcExtension",
	handles => ["extensions"],
	;

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::loginSvcType"
	=> as __PACKAGE__;

1;
