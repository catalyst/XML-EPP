package XML::EPP::Domain::Status;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Domain::Node';

use PRANG::XMLSchema::Types;

has_element 'value' =>
	is => 'ro',
	isa => "PRANG::XMLSchema::normalizedString",
	xml_nodeName => '',
	;

has_attr 'status' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::statusValueType',
    required => 1,
    xml_name => 's',
	;

has_attr "lang" =>
    is => "ro",
    isa => "PRANG::XMLSchema::language",
    default => "en",
    ;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Domain::statusType" => as __PACKAGE__;

1;

=head2 XML Schema Definition

<!--
Status is a combination of attributes and an optional
human-readable message that may be expressed in languages other
than English.
-->
<complexType name="statusType">
 <simpleContent>
   <extension base="normalizedString">
     <attribute name="s" type="domain:statusValueType"
      use="required"/>
     <attribute name="lang" type="language"
      default="en"/>
   </extension>
 </simpleContent>
</complexType>

=cut
