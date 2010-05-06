package XML::EPP::Contact::Notification;

use Moose;
use PRANG::Graph;

sub root_element { 'panData' }

with
	'XML::EPP::Contact::RS',
	'XML::EPP::Contact::Node',
	;

use XML::EPP::Contact::ID;
has_element 'id' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::ID',
	;

has_element 'tx_id' =>
	is => 'ro',
	isa => 'XML::EPP::TrID',
	xml_nodeName => 'paTRID',
	;

has_element 'completed' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "paDate",
	;

1;

=head2 XML Schema Definition

<!--
Pending action notification response elements.
-->
 <complexType name="panDataType">
   <sequence>
     <element name="id" type="contact:paCLIDType"/>
     <element name="paTRID" type="epp:trIDType"/>
     <element name="paDate" type="dateTime"/>
   </sequence>
 </complexType>

=cut
