
package XML::EPP::Domain::Check;

use Moose;
use PRANG::Graph;

sub root_element { 'check' }

with 'XML::EPP::Domain::RQ', 'XML::EPP::Domain::Node';

has_element 'names' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Common::labelType]',
	xml_nodeName => 'name',
	auto_deref => 1,
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
 Child element of commands that accept multiple names.
 -->
 <complexType name="mNameType">
  <sequence>
    <element name="name" type="eppcom:labelType"
     maxOccurs="unbounded"/>
  </sequence>
 </complexType>

=cut
