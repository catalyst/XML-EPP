package XML::EPP::DNSSEC::InfoResponse;

use Moose;
use PRANG::Graph;

sub root_element {'infData'}

with 'XML::EPP::DNSSEC', 'XML::EPP::DNSSEC::Node';

with 'XML::EPP::DNSSEC::Elements';

1;
