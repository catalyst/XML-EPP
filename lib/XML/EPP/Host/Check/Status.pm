package XML::EPP::Host::Check::Status;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Host::Node';

use XML::EPP::Host::Check::Name;
has_element 'name_status' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Host::Check::Name]",
	xml_nodeName => "name",
	handles => [qw(available name)],
	;

has_element "reason" =>
	is => "ro",
	isa => "XML::EPP::Common::Reason",
	predicate => "has_reason",
	xmlns => &xmlns,
	;

1;

=head2 XML Schema Definition

 <complexType name="checkType">
   <sequence>
     <element name="name" type="host:checkNameType"/>
     <element name="reason" type="eppcom:reasonType"
      minOccurs="0"/>
   </sequence>
 </complexType>

=cut
