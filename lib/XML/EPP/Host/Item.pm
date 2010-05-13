package XML::EPP::Host::Item;

use Moose::Role;
with 'XML::EPP::Host::Node';
use PRANG::Graph;
has_element 'value' =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
        xml_nodeName => "name",
	;
1;

=head1 NAME

XML::EPP::Host::Item - implement sNameType

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

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
