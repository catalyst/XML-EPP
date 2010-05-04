package XML::EPP::Contact::Transfer::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'trnData' }

with
	'XML::EPP::Contact::RS',
	'XML::EPP::Contact::Node',
	;

has_element 'id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	;


has_element 'trStatus' =>
	is => 'ro',
	isa => 'XML::EPP::Common::trStatusType',
	;


has_element 'requester' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
    xml_nodeName => 'reID',
	;

has_element 'requested' =>
	is => 'rw',
	isa => 'PRANG::XMLSchema::dateTime',
	xml_nodeName => 'reDate',
	;

has_element 'action_id' =>
	is => 'rw',
	isa => 'XML::EPP::Common::clIDType',
	xml_nodeName => 'acID',
	;

has_element 'action_date' =>
	is => 'rw',
	isa => 'PRANG::XMLSchema::dateTime',
	xml_nodeName => 'acDate',
	;

=head2 XML Schema Definition

<!--
<transfer> response elements.
-->
 <complexType name="trnDataType">
   <sequence>
     <element name="id" type="eppcom:clIDType"/>
     <element name="trStatus" type="eppcom:trStatusType"/>
     <element name="reID" type="eppcom:clIDType"/>
     <element name="reDate" type="dateTime"/>
     <element name="acID" type="eppcom:clIDType"/>
     <element name="acDate" type="dateTime"/>
   </sequence>
 </complexType>

=cut
