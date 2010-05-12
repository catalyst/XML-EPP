package XML::EPP::Domain::Create::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'creData' }

with
	'XML::EPP::Domain::RS',
	'XML::EPP::Domain::Node',
	;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

has_element 'created' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "crDate",
	;

has_element 'expiry_date' =>
	is => 'rw',
	isa => 'PRANG::XMLSchema::dateTime',
	xml_nodeName => 'exDate',
	required => 0,
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
 <create> response elements.
 -->
 <complexType name="creDataType">
  <sequence>
    <element name="name" type="eppcom:labelType"/>
    <element name="crDate" type="dateTime"/>
    <element name="exDate" type="dateTime"
     minOccurs="0"/>
  </sequence>
 </complexType>

=cut
