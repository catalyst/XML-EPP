package XML::EPP::Host::Item;
# <!--
# Child elements of the <delete> and <info> commands.
# -->
#  <complexType name="sNameType">
#    <sequence>
#      <element name="name" type="eppcom:labelType"/>
#    </sequence>
#  </complexType>
#
use Moose::Role;
with 'XML::EPP::Host::Node';
use PRANG::Graph;
has_element 'value' =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
        xml_nodeName => "name",
	;
1;
