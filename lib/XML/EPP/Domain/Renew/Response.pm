package XML::EPP::Domain::Renew::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'renData' }

with
	'XML::EPP::Domain::RS',
	'XML::EPP::Domain::Node',
	;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

has_element 'expiry_date' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_required => 0,
	xml_nodeName => 'exDate',
	;

1;

=head2 XML Schema Definition

<!--
<renew> response elements.
-->
<complexType name="renDataType">
<sequence>
 <element name="name" type="eppcom:labelType"/>
 <element name="exDate" type="dateTime"
  minOccurs="0"/>
</sequence>
</complexType>

=cut
