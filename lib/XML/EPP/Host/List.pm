package XML::EPP::Host::List;
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
has_element 'items' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Common::labelType]",
        xml_nodeName => "name",
	;
1;
