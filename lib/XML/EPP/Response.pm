
package XML::EPP::Response;

use Moose;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

our $SCHEMA_PKG = "XML::EPP";
our $PKG = __PACKAGE__;

use XML::EPP::Result;
has_element 'result' =>
	is => "rw",
	isa => "ArrayRef[${SCHEMA_PKG}::resultType]",
	;

use XML::EPP::MsgQ;
has_element 'msgQ' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::msgQType",
	predicate => "has_msgQ",
	;

use XML::EPP::SubResponse;

has_element 'response' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::SubResponse",
	predicate => "has_response",
	xml_nodeName => "resData",
	;

has_element 'extension' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::extAnyType",
	predicate => "has_extension",
	;

has_element 'tx_id' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::trIDType",
	xml_nodeName => "trID",
	;

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::responseType"
	=> as __PACKAGE__;

sub is_command { 0 }

1;
