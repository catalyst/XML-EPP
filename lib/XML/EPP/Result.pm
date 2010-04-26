
package XML::EPP::Result;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

use XML::EPP::Error;

our $SCHEMA_PKG = "XML::EPP";
our $PKG = __PACKAGE__;

# grep '^ *[0-9][0-9][0-9][0-9]  *' rfc5730.txt
our %result_codes = map { m/^\s*(\d{4})\s+"(.*)"$/ } split /\n/, <<CODES;
      1000    "Command completed successfully"
      1001    "Command completed successfully; action pending"
      1300    "Command completed successfully; no messages"
      1301    "Command completed successfully; ack to dequeue"
      1500    "Command completed successfully; ending session"
      2000    "Unknown command"
      2001    "Command syntax error"
      2002    "Command use error"
      2003    "Required parameter missing"
      2004    "Parameter value range error"
      2005    "Parameter value syntax error"
      2100    "Unimplemented protocol version"
      2101    "Unimplemented command"
      2102    "Unimplemented option"
      2103    "Unimplemented extension"
      2104    "Billing failure"
      2105    "Object is not eligible for renewal"
      2106    "Object is not eligible for transfer"
      2200    "Authentication error"
      2201    "Authorization error"
      2202    "Invalid authorization information"
      2300    "Object pending transfer"
      2301    "Object not pending transfer"
      2302    "Object exists"
      2303    "Object does not exist"
      2304    "Object status prohibits operation"
      2305    "Object association prohibits operation"
      2306    "Parameter value policy error"
      2307    "Unimplemented object service"
      2308    "Data management policy violation"
      2400    "Command failed"
      2500    "Command failed; server closing connection"
      2501    "Authentication error; server closing connection"
      2502    "Session limit exceeded; server closing connection"
CODES

has_element 'msg' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::msgType",
	;

sub BUILD {
	my $self = shift;
	my $msg = $self->msg;
	if ( !$msg and ($msg = $result_codes{$self->code}) ) {
		$self->msg($msg);
	}
}

subtype "${PKG}::choice0"
	=> as join("|", map { "${SCHEMA_PKG}::$_" }
			   qw(errValueType extErrValueType)),
	;

has_element 'errs' =>
	is => "rw",
	isa => "ArrayRef[${PKG}::choice0]",
	predicate => "has_errs",
	xmlns => XML::EPP::Node::xmlns(),
	xml_nodeName => {
		"value" => "PRANG::XMLSchema::Whatever",
		"extValue" => "${SCHEMA_PKG}::Error",
	},
	xml_min => 0,
	;

subtype "${SCHEMA_PKG}::resultCodeType"
	=> as "Int"
	=> where {
		exists $result_codes{$_};
	};

has_attr 'code' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::resultCodeType",
	;

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::resultType"
	=> as __PACKAGE__;

sub is_command { 0 }

1;
