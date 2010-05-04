package XML::EPP::Contact::Status;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Contact::Node';

use PRANG::XMLSchema::Types;

has_element 'value' =>
	is => 'ro',
	isa => "PRANG::XMLSchema::normalizedString",
	xml_nodeName => '',
	;

has_attr 'status' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::statusValueType',
	required => 1,
	xml_name => 's',
	;

has_attr "lang" =>
    is => "ro",
    isa => "PRANG::XMLSchema::language",
    default => "en",
    ;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Contact::statusType" => as __PACKAGE__;

1;

=head2 XML Schema Definition

<!--
Status is a combination of attributes and an optional human-readable
message that may be expressed in languages other than English.
-->
 <complexType name="statusType">
   <simpleContent>
     <extension base="normalizedString">
       <attribute name="s" type="contact:statusValueType"
        use="required"/>
       <attribute name="lang" type="language"
        default="en"/>
     </extension>
   </simpleContent>
 </complexType>

=cut
