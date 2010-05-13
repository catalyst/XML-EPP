package XML::EPP::Host::Notification;

use Moose;
use PRANG::Graph;
sub root_element { "panData" }

with
	'XML::EPP::Host::RS',
	'XML::EPP::Host::Node',
	;

use XML::EPP::Host::Notification::Result;
has_element 'name_result' =>
	is => "ro",
	isa => "XML::EPP::Host::Notification::Result",
	handles => [qw(name approved)],
	xml_nodeName => "name",
	;

has_element 'tx_id' =>
	is => "ro",
	isa => "XML::EPP::TrID",
	xml_nodeName => "paTRID",
	;

has_element 'tx_when' =>
	is => "ro",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "paDate",
	;

1;

=head1 NAME

XML::EPP::Host::Notification - implement panDataType

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
      <element name="name" type="host:paNameType"/>
      <element name="paTRID" type="epp:trIDType"/>
      <element name="paDate" type="dateTime"/>
    </sequence>
  </complexType>

=cut
