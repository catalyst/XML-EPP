
package XML::EPP::Domain::Notification::Name;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Domain::Node';

has_element 'value' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	xml_nodeName => '',
	;

has_attr 'result' =>
	is => 'ro',
	isa => 'PRANG::XMLSchema::boolean',
    xml_name => 'paResult',
	;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="paNameType">
  <simpleContent>
    <extension base="eppcom:labelType">
      <attribute name="paResult" type="boolean"
       use="required"/>
    </extension>
  </simpleContent>
 </complexType>

=cut
