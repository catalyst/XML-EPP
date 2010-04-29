
package XML::EPP::Domain::Delete;

use Moose;
use PRANG::Graph;

sub root_element { 'delete' }

with 'XML::EPP::Domain::RQ', 'XML::EPP::Domain::Node';

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

1;

=head2 XML Schema Definition

<!--
Child element of commands that require a single name.
-->
<complexType name="sNameType">
 <sequence>
   <element name="name" type="eppcom:labelType"/>
 </sequence>
</complexType>

=cut
