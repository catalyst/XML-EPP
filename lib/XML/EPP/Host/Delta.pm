package XML::EPP::Host::Delta;

use Moose;
with 'XML::EPP::Host::Node';
use PRANG::Graph;

use XML::EPP::Host::Address;
has_element 'addr' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Host::Address]",
	xml_min => 0,
	;

use XML::EPP::Host::Status;
has_element 'status' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Host::Status]",
	xml_min => 0,
	xml_max => 7,
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
     <element name="addr" type="host:addrType"
      minOccurs="0" maxOccurs="unbounded"/>
     <element name="status" type="host:statusType"
      minOccurs="0" maxOccurs="7"/>
   </sequence>
 </complexType>

=cut
