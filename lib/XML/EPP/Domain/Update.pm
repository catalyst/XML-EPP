
package XML::EPP::Domain::Update;

use Moose;
use PRANG::Graph;

sub root_element { 'update' }

with 'XML::EPP::Domain::RQ', 'XML::EPP::Domain::Node';

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

use XML::EPP::Domain::AddRem;
has_element 'add' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AddRem',
	;

has_element 'remove' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AddRem',
    xml_nodeName => 'rem',
	;

has_element 'change' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::Change',
    xml_nodeName => 'chg',
	;

1;

=head2 XML Schema Definition

<!--
Child elements of the <update> command.
-->

<complexType name="updateType">
 <sequence>
   <element name="name" type="eppcom:labelType"/>
   <element name="add" type="domain:addRemType"
    minOccurs="0"/>
   <element name="rem" type="domain:addRemType"
    minOccurs="0"/>
   <element name="chg" type="domain:chgType"
    minOccurs="0"/>
 </sequence>
</complexType>

=cut
