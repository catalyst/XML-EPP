package XML::EPP::Domain::NS;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Domain::Node';

has_element 'host_objs' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Common::labelType]',
	xml_nodeName => 'hostObj',
	;

has_attr 'host_attrs' =>
    is => 'ro',
    isa => 'ArrayRef[XML::EPP::Domain::HostAttr]',
    ;

1;

=head2 XML Schema Definition

<!--
Name servers are either host objects or attributes.
-->

<complexType name="nsType">
 <choice>
   <element name="hostObj" type="eppcom:labelType"
    maxOccurs="unbounded"/>
   <element name="hostAttr" type="domain:hostAttrType"
    maxOccurs="unbounded"/>
 </choice>
</complexType>

=cut
