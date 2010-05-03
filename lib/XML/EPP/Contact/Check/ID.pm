package XML::EPP::Contact::Check::ID;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Contact::Node';

has_attr 'available' =>
	is => 'ro',
	isa => 'PRANG::XMLSchema::boolean',
	coerce => 1,
	xml_name => 'avail',
	;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	xml_nodeName => '',
	;

1;

=head2 XML Schema Definition

 <complexType name="checkIDType">
   <simpleContent>
     <extension base="eppcom:clIDType">
       <attribute name="avail" type="boolean"
        use="required"/>
     </extension>
   </simpleContent>
 </complexType>

=cut
