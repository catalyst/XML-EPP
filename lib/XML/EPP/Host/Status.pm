package XML::EPP::Host::Status;

# <!--
# Status is a combination of attributes and an optional human-readable
# message that may be expressed in languages other than English.
# -->
#  <complexType name="statusType">
#    <simpleContent>
#      <extension base="normalizedString">
#        <attribute name="s" type="host:statusValueType"
#         use="required"/>
#        <attribute name="lang" type="language"
#         default="en"/>
#      </extension>
#    </simpleContent>
# </complexType>

use Moose;
use PRANG::Graph;
with 'XML::EPP::Host::Node';

use PRANG::XMLSchema::Types;

has_attr "status" =>
	is => "ro",
	isa => "XML::EPP::Host::statusValueType",
	required => 1,
	xml_name => "s",
	;

has_attr "lang" =>
	is => "ro",
	isa => "PRANG::XMLSchema::language",
	default => "en",
	;

has_element "description" =>
	is => "ro",
	isa => "PRANG::XMLSchema::normalizedString",
	xml_nodeName => "",
	;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Host::statusType" => as __PACKAGE__;

1;
