
package XML::EPP::Host::Notification::Result;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Host::Node';

has_element "name" =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
	xml_nodeName => "",
	;

has_attr "approved" =>
	is => "ro",
	isa => "PRANG::XMLSchema::boolean",
	required => 1,
	xml_name => "paResult",
	;

1;

=head1 NAME

XML::EPP::Host::Notification::Result - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="paNameType">
   <simpleContent>
     <extension base="eppcom:labelType">
       <attribute name="paResult" type="boolean"
        use="required"/>
     </extension>
   </simpleContent>
 </complexType>

=cut
