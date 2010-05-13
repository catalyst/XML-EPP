package XML::EPP::Host::Info;
use Moose;
use PRANG::Graph;
sub root_element { "info" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	'XML::EPP::Host::Item';

1;

=head1 NAME

XML::EPP::Host::Info

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
