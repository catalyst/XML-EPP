package XML::EPP::Host::List;

use Moose::Role;
with 'XML::EPP::Host::Node';
use PRANG::Graph;
has_element 'items' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Common::labelType]",
        xml_nodeName => "name",
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
 Child elements of the <delete> and <info> commands.
 -->
 <complexType name="sNameType">
   <sequence>
     <element name="name" type="eppcom:labelType"/>
   </sequence>
 </complexType>

=cut
