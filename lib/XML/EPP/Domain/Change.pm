package XML::EPP::Domain::Change;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Domain::Node';

use PRANG::XMLSchema::Types;

has_element 'registrant' =>
	is => 'rw',
	isa => 'XML::EPP::Domain::clIDChgType',
	required => 0,
	;

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AuthInfo',
	xml_required => 0,
	xml_nodeName => 'authInfo',
	;

1;

=head2 XML Schema Definition

<!--
Data elements that can be changed.
-->
<complexType name="chgType">
 <sequence>
   <element name="registrant" type="domain:clIDChgType"
    minOccurs="0"/>
   <element name="authInfo" type="domain:authInfoChgType"
    minOccurs="0"/>
 </sequence>
</complexType>

=cut
