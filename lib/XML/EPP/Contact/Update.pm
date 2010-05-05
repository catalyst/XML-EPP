
package XML::EPP::Contact::Update;

use Moose;
use PRANG::Graph;

sub root_element { 'update' }

with 'XML::EPP::Contact::RQ', 'XML::EPP::Contact::Node';

has_element 'id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

use XML::EPP::Contact::AddRem;
has_element 'add' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::AddRem',
	xml_required => 0,
	;

has_element 'remove' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::AddRem',
	xml_required => 0,
	xml_nodeName => 'rem',
	;

has_element 'change' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::Change',
	xml_required => 0,
	xml_nodeName => 'chg',
	;

1;

=head2 XML Schema Definition

<!--
Child elements of the <update> command.
-->
 <complexType name="updateType">
   <sequence>
     <element name="id" type="eppcom:clIDType"/>
     <element name="add" type="contact:addRemType"
      minOccurs="0"/>
     <element name="rem" type="contact:addRemType"
      minOccurs="0"/>
     <element name="chg" type="contact:chgType"
      minOccurs="0"/>
   </sequence>
 </complexType>

=cut
