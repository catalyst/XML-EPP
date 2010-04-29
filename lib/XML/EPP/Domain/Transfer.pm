package XML::EPP::Domain::Transfer;

use Moose;
use PRANG::Graph;

sub root_element { 'transfer' }

with
	'XML::EPP::Domain::RQ',
	'XML::EPP::Domain::Node',
	;

use XML::EPP::Domain::Info::Name;

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

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AuthInfo',
	xml_required => 0,
	xml_nodeName => 'authInfo',
	;

1;


=head2 XML Schema Definition

<!--
Child elements of the <transfer> command.
-->
<complexType name="transferType">
 <sequence>
   <element name="name" type="eppcom:labelType"/>
   <element name="period" type="domain:periodType"
    minOccurs="0"/>
   <element name="authInfo" type="domain:authInfoType"
    minOccurs="0"/>
 </sequence>
</complexType>

=cut
