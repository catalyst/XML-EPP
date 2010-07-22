
package XML::EPP::TrID;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

our $SCHEMA_PKG = "XML::EPP";

has_element 'client_id' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::trIDStringType",
	predicate => "has_client_id",
	xml_nodeName => "clTRID",
	;

has_element 'server_id' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::trIDStringType",
	xml_nodeName => "svTRID",
	required => 1,
	;

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::trIDType"
	=> as __PACKAGE__;

1;

=head2 XMLSchema definition

  <complexType name="trIDType">
    <sequence>
      <element name="clTRID" type="epp:trIDStringType"
       minOccurs="0"/>
      <element name="svTRID" type="epp:trIDStringType"/>
    </sequence>
  </complexType>

=cut
