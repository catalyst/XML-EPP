package XML::EPP::Domain::Contact;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Domain::Node';

has_element 'value' =>
	is => 'ro',
	isa => 'XML::EPP::Common::clIDType',
	xml_nodeName => '',
	;

has_attr 'type' =>
    is => "ro",
    isa => "XML::EPP::Domain::contactAttrType",
    ;

#use Moose::Util::TypeConstraints;
#subtype "XML::EPP::Domain::statusType" => as __PACKAGE__;

1;

=head2 XML Schema Definition

<complexType name="contactType">
 <simpleContent>
 <extension base="eppcom:clIDType">
     <attribute name="type" type="domain:contactAttrType"/>
   </extension>
 </simpleContent>
</complexType>

=cut
