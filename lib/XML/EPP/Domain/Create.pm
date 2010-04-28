
package XML::EPP::Domain::Create;

use Moose;
use PRANG::Graph;

sub root_element { 'create' }

with 'XML::EPP::Domain::RQ', 'XML::EPP::Domain::Node';

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

use XML::EPP::Domain::Period;
has_element 'period' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::Period',
	xml_required => 0,
	;

use XML::EPP::Domain::NS::List;
has_element 'ns' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::NS::List',
	xml_required => 0,
	;

has_element 'registrant' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
    xml_required => 0,
	;

has_element 'contact' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Domain::Contact]',
	xml_min => 0,
	;

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AuthInfo',
	xml_nodeName => 'authInfo',
	;

1;

=head2 XML Schema Definition

<!--
Child elements of the <create> command.
-->
<complexType name="createType">
 <sequence>
   <element name="name" type="eppcom:labelType"/>
   <element name="period" type="domain:periodType"
    minOccurs="0"/>
   <element name="ns" type="domain:nsType"
    minOccurs="0"/>
   <element name="registrant" type="eppcom:clIDType"
    minOccurs="0"/>
   <element name="contact" type="domain:contactType"
    minOccurs="0" maxOccurs="unbounded"/>
   <element name="authInfo" type="domain:authInfoType"/>
 </sequence>
</complexType>

=cut
