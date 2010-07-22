
package XML::EPP::Domain::Renew;

use Moose;
use PRANG::Graph;

sub root_element { 'renew' }

with 'XML::EPP::Domain::RQ', 'XML::EPP::Domain::Node';

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

has_element 'expiry_date' =>
	is => 'ro',
	isa => 'PRANG::XMLSchema::date',
	xml_nodeName => 'curExpDate',
	required => 1,
	;

use XML::EPP::Domain::Period;
has_element 'period' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::Period',
	required => 1,
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
 Child elements of the <renew> command.
 -->
 <complexType name="renewType">
  <sequence>
    <element name="name" type="eppcom:labelType"/>
    <element name="curExpDate" type="date"/>
    <element name="period" type="domain:periodType"
     minOccurs="0"/>
  </sequence>
 </complexType>

=cut
