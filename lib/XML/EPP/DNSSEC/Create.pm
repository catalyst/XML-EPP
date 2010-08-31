package XML::EPP::DNSSEC::Create;

use Moose;
use PRANG::Graph;

sub root_element {'create'}

with 'XML::EPP::DNSSEC', 'XML::EPP::DNSSEC::Node';

has_element 'ds_data' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::DNSSEC::DSData]',
	required => 1,
	xml_nodeName => 'dsData',
	;

1;
