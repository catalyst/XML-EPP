package XML::EPP::Host::Create::Response;

use Moose;
use PRANG::Graph;
sub root_element { "creData" }

with
	'XML::EPP::Host::RS',
	'XML::EPP::Host::Node',
	;

has_element 'name' =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
	;

has_element 'created' =>
	is => "ro",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "crDate",
	;

1;

=head2 XML Schema Definition

 <!--
 <create> response elements.
 -->
  <complexType name="creDataType">
    <sequence>
      <element name="name" type="eppcom:labelType"/>
      <element name="crDate" type="dateTime"/>
    </sequence>
  </complexType>

=cut
