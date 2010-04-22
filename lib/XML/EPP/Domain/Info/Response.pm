package XML::EPP::Domain::Info::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'chkDat' }

with
        'XML::EPP::Domain::RS',
        'XML::EPP::Domain::Node',
        ;


1;
