
package XML::EPP::Contact::Transfer;

use Moose;
use PRANG::Graph;

sub root_element { 'transfer' }

with 'XML::EPP::Contact::RQ', 'XML::EPP::Contact::Node';

has_element 'id' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	;

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::AuthInfo',
	xml_required => 0,
	xml_nodeName => 'authInfo',
	;

1;

=head2 XML Schema Definition

<!--
Child elements of the <info> and <transfer> commands.
-->
 <complexType name="authIDType">
   <sequence>
     <element name="id" type="eppcom:clIDType"/>
     <element name="authInfo" type="contact:authInfoType"
      minOccurs="0"/>
   </sequence>
 </complexType>

=cut
