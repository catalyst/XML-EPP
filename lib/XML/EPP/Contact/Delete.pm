
package XML::EPP::Contact::Delete;

use Moose;
use PRANG::Graph;

sub root_element { 'delete' }

with 'XML::EPP::Contact::RQ', 'XML::EPP::Contact::Node';

has_element 'id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
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
 Child element of commands that require only an identifier.
 -->
 <complexType name="sIDType">
   <sequence>
     <element name="id" type="eppcom:clIDType"/>
   </sequence>
 </complexType>

=cut
