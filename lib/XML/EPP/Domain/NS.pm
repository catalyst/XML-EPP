package XML::EPP::Domain::NS;

use Moose;
use PRANG::Graph;

sub root_element {'infData'}

use XML::EPP::Domain::HostAttr;

has_element 'ns' =>
	is => 'ro',
	isa =>
	'ArrayRef[XML::EPP::Domain::HostAttr|XML::EPP::Common::labelType]',
	xml_min => 0,
	xml_nodeName => {
	hostAttr => 'XML::EPP::Domain::HostAttr',
	hostObj  => 'XML::EPP::Common::labelType',
	},
	;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <!--
 Name servers are either host objects or attributes.
 -->
 <complexType name="nsType">
  <choice>
    <element name="hostObj" type="eppcom:labelType"
     maxOccurs="unbounded"/>
    <element name="hostAttr" type="domain:hostAttrType"
     maxOccurs="unbounded"/>
  </choice>
 </complexType>

=cut
