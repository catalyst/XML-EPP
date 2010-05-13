package XML::EPP::Host::Check;
use Moose;
use PRANG::Graph;
sub root_element { "check" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	'XML::EPP::Host::List';

1;

=head1 NAME

XML::EPP::Host::Check

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
