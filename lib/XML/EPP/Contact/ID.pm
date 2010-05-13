
package XML::EPP::Contact::ID;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Contact::Node';

has_element 'value' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	xml_nodeName => '',
	;

has_attr 'result' =>
	is => 'ro',
	isa => 'PRANG::XMLSchema::boolean',
	xml_name => 'paResult',
	;

1;

=head1 NAME

XML::EPP::Contact::ID - implement paCLIDType

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="paCLIDType">
   <simpleContent>
     <extension base="eppcom:clIDType">
       <attribute name="paResult" type="boolean"
        use="required"/>
     </extension>
   </simpleContent>
 </complexType>

=cut
