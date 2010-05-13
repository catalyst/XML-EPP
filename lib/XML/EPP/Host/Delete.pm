package XML::EPP::Host::Delete;
use Moose;
use PRANG::Graph;
sub root_element { "delete" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	'XML::EPP::Host::Item';

1;

=head1 NAME

XML::EPP::Host::Delete - implement sNameType

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
