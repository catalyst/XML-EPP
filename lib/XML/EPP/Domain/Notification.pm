package XML::EPP::Domain::Notification;

use Moose;
use PRANG::Graph;

sub root_element { 'panData' }

with
	'XML::EPP::Domain::RS',
	'XML::EPP::Domain::Node',
	;

use XML::EPP::Domain::Notification::Name;
has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::Notification::Name',
	;

has_element 'tx_id' =>
	is => 'ro',
	isa => 'XML::EPP::TrID',
	xml_nodeName => 'paTRID',
	;

has_element 'completed' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "paDate",
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
 Pending action notification response elements.
 -->
 <complexType name="panDataType">
  <sequence>
    <element name="name" type="domain:paNameType"/>
    <element name="paTRID" type="epp:trIDType"/>
    <element name="paDate" type="dateTime"/>
  </sequence>
 </complexType>

=cut
