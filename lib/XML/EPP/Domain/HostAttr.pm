package XML::EPP::Domain::HostAttr;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Domain::Node';

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	xml_nodeName => 'hostName',
	;

has_attr 'addrs' =>
    is => 'ro',
    isa => 'ArrayRef[XML::EPP::Host::Address]',
    xml_required => 0,
    ;

#use Moose::Util::TypeConstraints;
#subtype "XML::EPP::Domain::statusType" => as __PACKAGE__;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <!--
 If attributes, addresses are optional and follow the
 structure defined in the host mapping.
 -->
 <complexType name="hostAttrType">
  <sequence>
    <element name="hostName" type="eppcom:labelType"/>
    <element name="hostAddr" type="host:addrType"
     minOccurs="0" maxOccurs="unbounded"/>
  </sequence>
 </complexType>

=cut
