package XML::EPP::DNSSEC::Create;

use Moose;
use PRANG::Graph;

sub root_element {'create'}

with 'XML::EPP::DNSSEC', 'XML::EPP::DNSSEC::Node';

has_element 'max_sig_life' =>
	is => 'ro',
	isa => 'Int',
	xml_required => 0,
	xml_nodeName => 'maxSigLife',
	;

with 'XML::EPP::DNSSEC::Elements';

1;
