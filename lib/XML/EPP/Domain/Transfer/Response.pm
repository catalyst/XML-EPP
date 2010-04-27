package XML::EPP::Domain::Transfer::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'trnData' }

with
	'XML::EPP::Domain::RS',
	'XML::EPP::Domain::Node',
	;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

#has_element 'transfer_status' =>
#	is => 'ro',
#	isa => 'XML::EPP::Common::trStatusType',
#	xml_nodeName => 'trStatus',
#	;

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

has_element 'expiry_date' =>
	is => 'rw',
	isa => 'PRANG::XMLSchema::dateTime',
	xml_nodeName => 'exDate',
	required => 0,
	;

1;

=head2 XML Schema Definition

<!--
<transfer> response elements.
-->
<complexType name="trnDataType">
<sequence>
 <element name="name" type="eppcom:labelType"/>
 <element name="trStatus" type="eppcom:trStatusType"/>
 <element name="reID" type="eppcom:clIDType"/>
 <element name="reDate" type="dateTime"/>
 <element name="acID" type="eppcom:clIDType"/>
 <element name="acDate" type="dateTime"/>
 <element name="exDate" type="dateTime"
  minOccurs="0"/>
</sequence>
</complexType>

=cut
