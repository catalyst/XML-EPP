package XML::EPP::Contact::Change;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Contact::Node';

use PRANG::XMLSchema::Types;

use XML::EPP::Contact::ChangePostalInfo;
has_element 'postal_info' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::ChangePostalInfo',
	xml_nodeName => 'postalInfo',
	;

use XML::EPP::Contact::E164;
has_element 'voice' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::E164',
	xml_required => 0,
	;

has_element 'fax' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::E164',
	xml_required => 0,
	;

has_element 'email' =>
	is => 'ro',
	isa => 'XML::EPP::Common::minTokenType',
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
	xml_required => 0,
	;

1;

=head2 XML Schema Definition

<!--
Data elements that can be changed.
-->
 <complexType name="chgType">
   <sequence>
     <element name="postalInfo" type="contact:chgPostalInfoType"
      minOccurs="0" maxOccurs="2"/>
     <element name="voice" type="contact:e164Type"
      minOccurs="0"/>
     <element name="fax" type="contact:e164Type"
      minOccurs="0"/>
     <element name="email" type="eppcom:minTokenType"
      minOccurs="0"/>
     <element name="authInfo" type="contact:authInfoType"
      minOccurs="0"/>
     <element name="disclose" type="contact:discloseType"
      minOccurs="0"/>
   </sequence>
 </complexType>

=cut
