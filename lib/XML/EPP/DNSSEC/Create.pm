package XML::EPP::DNSSEC::Create;

use Moose;
use PRANG::Graph;

sub root_element {'create'}

with 'XML::EPP::DNSSEC', 'XML::EPP::DNSSEC::Node';

with 'XML::EPP::DNSSEC::Elements';

1;
