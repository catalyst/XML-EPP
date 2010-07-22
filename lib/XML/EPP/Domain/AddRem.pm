package XML::EPP::Domain::AddRem;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Domain::Node';

use PRANG::XMLSchema::Types;

has_element 'ns' =>
	is => 'rw',
	isa => 'XML::EPP::Domain::NS',
	xml_required => 0,
	;

has_element 'contact' =>
	is => 'rw',
	isa => 'ArrayRef[XML::EPP::Domain::Contact]',
	xml_min => 0,
	xml_required => 0,
	;

has_element 'status' =>
	is => 'rw',
	isa => 'ArrayRef[XML::EPP::Domain::Status]',
	xml_min => 0,
	xml_max => 11,
	required => 1,
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
 Data elements that can be added or removed.
 -->
 <complexType name="addRemType">
  <sequence>
    <element name="ns" type="domain:nsType"
     minOccurs="0"/>
    <element name="contact" type="domain:contactType"
     minOccurs="0" maxOccurs="unbounded"/>
    <element name="status" type="domain:statusType"
     minOccurs="0" maxOccurs="11"/>
  </sequence>
 </complexType>

=cut
