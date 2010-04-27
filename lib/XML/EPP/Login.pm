
package XML::EPP::Login;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

our $PKG = "XML::EPP::Login";
our $SCHEMA_PKG = "XML::EPP";

use XML::EPP;
use XML::EPP::Common;

has_element 'client_id' =>
	is => "rw",
	isa => "XML::EPP::Common::clIDType",
	xml_nodeName => "clID",
	;

has_element 'password' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::pwType",
	xml_nodeName => "pw",
	;

has_element 'new_password' =>
	is => "rw",
	predicate => "has_new_password",
	isa => "${SCHEMA_PKG}::pwType",
	xml_nodeName => "newPW",
	;

has_element 'options' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::credsOptionsType",
	;

has_element 'services' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::loginSvcType",
	xml_nodeName => "svcs",
	;

with 'XML::EPP::Node';

# based on epp-1.0.xsd:loginType
subtype "${SCHEMA_PKG}::loginType" =>
	as __PACKAGE__;

1;
