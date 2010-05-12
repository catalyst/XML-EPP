
package XML::EPP::Contact::Create;

use Moose;
use PRANG::Graph;

sub root_element { 'create' }

with 'XML::EPP::Contact::RQ', 'XML::EPP::Contact::Node';

has_element 'id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	;

use XML::EPP::Contact::PostalInfo;
has_element 'postal_info' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Contact::PostalInfo]',
	xml_nodeName => "postalInfo",
	xml_min => 0,
	xml_max => 2,
	;

use XML::EPP::Contact::E164;
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

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::AuthInfo',
	xml_nodeName => 'authInfo',
	;

has_element 'disclose' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::Disclose',
	required => 0,
	;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <!--
 Child elements of the <create> command.
 -->
 <complexType name="createType">
   <sequence>
     <element name="id" type="eppcom:clIDType"/>
     <element name="postalInfo" type="contact:postalInfoType"
      maxOccurs="2"/>
     <element name="voice" type="contact:e164Type"
      minOccurs="0"/>
     <element name="fax" type="contact:e164Type"
      minOccurs="0"/>
     <element name="email" type="eppcom:minTokenType"/>
     <element name="authInfo" type="contact:authInfoType"/>
     <element name="disclose" type="contact:discloseType"
      minOccurs="0"/>
   </sequence>
 </complexType>

=cut
