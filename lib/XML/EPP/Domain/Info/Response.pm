package XML::EPP::Domain::Info::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'infData' }

with
	'XML::EPP::Domain::RS',
	'XML::EPP::Domain::Node',
	;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

has_element 'roid' =>
	is => 'ro',
	isa => 'XML::EPP::Common::roidType'
	;

use XML::EPP::Domain::Status;
has_element 'status' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Domain::Status]',
	xml_min => 0,
	xml_max => 11,
	;

has_element 'registrant' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
    xml_required => 0,
	;

has_element 'contact' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Domain::Contact]',
	xml_min => 0,
	;

use XML::EPP::Domain::NS::List;
has_element 'ns' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::NS::List',
	xml_required => 0,
	;

has_element 'host' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Common::labelType]',
	xml_min => 0,
	;

has_element 'client_id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	xml_nodeName => 'clID',
	;

has_element 'creator_id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	xml_nodeName => "crID",
	xml_required => 0,
	;

has_element 'created' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "crDate",
	xml_required => 0,
	;

has_element 'updated_by_id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	xml_nodeName => 'upID',
	xml_required => 0,
	;

has_element 'updated' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => 'upDate',
	xml_required => 0,
	;

has_element 'expiry_date' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_required => 0,
	xml_nodeName => 'exDate',
	;

has_element 'trDate' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_required => 0,
	;

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AuthInfo',
	xml_required => 0,
	xml_nodeName => 'authInfo',
	;

1;

=head2 XML Schema Definition

<!--
<info> response elements.
-->
<complexType name="infDataType">
 <sequence>
   <element name="name" type="eppcom:labelType"/>
   <element name="roid" type="eppcom:roidType"/>
   <element name="status" type="domain:statusType"
    minOccurs="0" maxOccurs="11"/>
   <element name="registrant" type="eppcom:clIDType"
    minOccurs="0"/>
   <element name="contact" type="domain:contactType"
    minOccurs="0" maxOccurs="unbounded"/>
   <element name="ns" type="domain:nsType"
    minOccurs="0"/>
   <element name="host" type="eppcom:labelType"
    minOccurs="0" maxOccurs="unbounded"/>
   <element name="clID" type="eppcom:clIDType"/>
   <element name="crID" type="eppcom:clIDType"
    minOccurs="0"/>
   <element name="crDate" type="dateTime"
    minOccurs="0"/>
   <element name="upID" type="eppcom:clIDType"
    minOccurs="0"/>
   <element name="upDate" type="dateTime"
    minOccurs="0"/>
   <element name="exDate" type="dateTime"
    minOccurs="0"/>
   <element name="trDate" type="dateTime"
    minOccurs="0"/>
   <element name="authInfo" type="domain:authInfoType"
    minOccurs="0"/>
 </sequence>
</complexType>

=cut
