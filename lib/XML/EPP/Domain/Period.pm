package XML::EPP::Domain::Period;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

has_element 'value' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::pLimitType',
    xml_nodeName => ''
	;

has_attr 'unit' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::pUnitType',
	coerce => 1,
	;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="periodType">
  <simpleContent>
    <extension base="domain:pLimitType">
      <attribute name="unit" type="domain:pUnitType"
       use="required"/>
    </extension>
  </simpleContent>
 </complexType>

=cut
