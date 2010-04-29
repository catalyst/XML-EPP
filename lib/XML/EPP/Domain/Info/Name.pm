
package XML::EPP::Domain::Info::Name;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Domain::Node';

has_element 'value' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	xml_nodeName => '',
	;

has_attr 'hosts' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::hostsType',
	default => 'all',
	;

1;

=head2 XML Schema Definition

<complexType name="infoNameType">
 <simpleContent>
   <extension base = "eppcom:labelType">
     <attribute name="hosts" type="domain:hostsType"
      default="all"/>
   </extension>
 </simpleContent>
</complexType>

=cut
