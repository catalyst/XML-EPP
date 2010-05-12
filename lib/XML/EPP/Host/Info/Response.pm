package XML::EPP::Host::Info::Response;

use Moose;
use PRANG::Graph;
sub root_element { "infData" }

with
	'XML::EPP::Host::RS',
	'XML::EPP::Host::Node',
	;

has_element 'name' =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
	;

has_element 'roid' =>
	is => "ro",
	isa => "XML::EPP::Common::roidType",
	;

use XML::EPP::Host::Status;
has_element 'status' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Host::Status]",
	xml_max => 7,
	;

use XML::EPP::Host::Address;
has_element 'addresses' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Host::Address]",
	xml_min => 0,
	xml_nodeName => "addr",
	;

has_element 'client_id' =>
	is => "ro",
	isa => "XML::EPP::Common::clIDType",
	xml_nodeName => "clID",
	;

has_element 'creator_id' =>
	is => "ro",
	isa => "XML::EPP::Common::clIDType",
	xml_nodeName => "crID",
	;

has_element 'created' =>
	is => "ro",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "crDate",
	;

has_element 'updated_by_id' =>
	is => "ro",
	isa => "XML::EPP::Common::clIDType",
	xml_nodeName => "upID",
	xml_min => 0,
	;

has_element 'updated' =>
	is => "ro",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "upDate",   # lol... see also man date
	predicate => "has_updated",
	;

has_element 'transferred' =>
	is => "ro",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "trDate",
	xml_min => 1,
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
 <info> response elements.
 -->
  <complexType name="infDataType">
    <sequence>
      <element name="name" type="eppcom:labelType"/>
      <element name="roid" type="eppcom:roidType"/>
      <element name="status" type="host:statusType"
       maxOccurs="7"/>
      <element name="addr" type="host:addrType"
       minOccurs="0" maxOccurs="unbounded"/>
      <element name="clID" type="eppcom:clIDType"/>
      <element name="crID" type="eppcom:clIDType"/>
      <element name="crDate" type="dateTime"/>
      <element name="upID" type="eppcom:clIDType"
       minOccurs="0"/>
      <element name="upDate" type="dateTime"
       minOccurs="0"/>
      <element name="trDate" type="dateTime"
       minOccurs="0"/>
    </sequence>
  </complexType>

=cut
