package XML::EPP::Contact::AddRem;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Contact::Node';

use PRANG::XMLSchema::Types;

has_element 'status' =>
	is => 'rw',
	isa => 'ArrayRef[XML::EPP::Contact::Status]',
	xml_max => 7,
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
     <element name="status" type="contact:statusType"
      maxOccurs="7"/>
   </sequence>
 </complexType>

=cut
