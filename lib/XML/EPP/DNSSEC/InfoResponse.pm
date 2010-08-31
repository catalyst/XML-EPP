package XML::EPP::DNSSEC::InfoResponse;

use Moose;
use PRANG::Graph;

sub root_element {'infData'}

with 'XML::EPP::DNSSEC', 'XML::EPP::DNSSEC::Node';

has_element 'ds_data' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::DNSSEC::DSData]',
	required => 1,
	xml_nodeName => 'dsData',
	;

1;
