
package XML::EPP::Contact::Check;

use Moose;
use PRANG::Graph;

sub root_element { 'check' }

with 'XML::EPP::Contact::RQ', 'XML::EPP::Contact::Node';

has_element 'ids' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Common::clIDType]',
	xml_nodeName => 'id',
	;

1;

=head2 XML Schema Definition

<!--
Child element of commands that accept multiple identifiers.
-->
 <complexType name="mIDType">
   <sequence>
     <element name="id" type="eppcom:clIDType"
      maxOccurs="unbounded"/>
   </sequence>
 </complexType>

=cut
