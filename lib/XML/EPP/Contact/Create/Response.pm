package XML::EPP::Contact::Create::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'creData' }

with
	'XML::EPP::Contact::RS',
	'XML::EPP::Contact::Node',
	;

has_element 'id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	;

has_element 'created' =>
	is => "rw",
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
     <element name="id" type="eppcom:clIDType"/>
     <element name="crDate" type="dateTime"/>
   </sequence>
 </complexType>

=cut
