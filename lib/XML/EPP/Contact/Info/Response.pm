package XML::EPP::Contact::Info::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'infData' }

with
	'XML::EPP::Contact::RS',
	'XML::EPP::Contact::Node',
	;

has_element 'id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	;

has_element 'roid' =>
	is => 'ro',
	isa => 'XML::EPP::Common::roidType'
	;

use XML::EPP::Contact::Status;
has_element 'status' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Contact::Status]',
	xml_min => 0,
	xml_max => 7,
	;

use XML::EPP::Contact::PostalInfo;
has_element 'postal_info' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Contact::PostalInfo]',
	xml_nodeName => "postalInfo",
	xml_min => 0,
	xml_max => 2,
	;

has_element 'voice' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::E164',
	required => 0,
	;

has_element 'fax' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::E164',
	required => 0,
	;

has_element 'email' =>
	is => 'ro',
	isa => 'XML::EPP::Common::minTokenType',
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

has_element 'trDate' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_required => 0,
	;

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::AuthInfo',
	xml_required => 0,
	xml_nodeName => 'authInfo',
	;

has_element 'disclose' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::Disclose',
	required => 0,
	;

1;

=head2 XML Schema Definition

<!--
<info> response elements.
-->
 <complexType name="infDataType">
   <sequence>
     <element name="id" type="eppcom:clIDType"/>
     <element name="roid" type="eppcom:roidType"/>
     <element name="status" type="contact:statusType"
      maxOccurs="7"/>
     <element name="postalInfo" type="contact:postalInfoType"
      maxOccurs="2"/>
     <element name="voice" type="contact:e164Type"
      minOccurs="0"/>
     <element name="fax" type="contact:e164Type"
      minOccurs="0"/>
     <element name="email" type="eppcom:minTokenType"/>
     <element name="clID" type="eppcom:clIDType"/>
     <element name="crID" type="eppcom:clIDType"/>
     <element name="crDate" type="dateTime"/>
     <element name="upID" type="eppcom:clIDType"
      minOccurs="0"/>
     <element name="upDate" type="dateTime"
      minOccurs="0"/>
     <element name="trDate" type="dateTime"
      minOccurs="0"/>
     <element name="authInfo" type="contact:authInfoType"
      minOccurs="0"/>
     <element name="disclose" type="contact:discloseType"
      minOccurs="0"/>
   </sequence>
 </complexType>

=cut
