package XML::EPP::Host::Rename;

use Moose;
with 'XML::EPP::Host::Node';
use PRANG::Graph;

use XML::EPP::Common;
has_element 'name' =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
	;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Host::chgType" => as __PACKAGE__;

1;

=head1 NAME

XML::EPP::Host::Rename - implement host:chgType

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

=head2 XML Schema definition

 <!--
 Data elements that can be changed.
 -->
 <complexType name="chgType">
   <sequence>
     <element name="name" type="eppcom:labelType"/>
   </sequence>
 </complexType>

=cut
