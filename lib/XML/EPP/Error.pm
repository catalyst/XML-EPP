package XML::EPP::Error;

# I've called this class 'error' - extErrValueType is a stupid name.

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

our $SCHEMA_PKG = "XML::EPP";

use XML::EPP::Msg;
use PRANG::XMLSchema::Whatever;

# PRANG::XMLSchema::Whatever means that the object within will
# effectively be an unparsed XML fragment
subtype "${SCHEMA_PKG}::errValueType"
	=> as "PRANG::XMLSchema::Whatever";

with 'XML::EPP::Node';

has_element 'value' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::errValueType",
	coerce => 1,
	required => 1,
	xmlns => &xmlns,
	;

has_element 'reason' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::msgType",
	required => 1,
	coerce => 1,
	;

subtype "${SCHEMA_PKG}::extErrValueType"
	=> as __PACKAGE__;

1;
