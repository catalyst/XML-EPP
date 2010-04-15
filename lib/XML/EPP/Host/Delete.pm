package XML::EPP::Host::Delete;
use Moose;
use PRANG::Graph;
sub root_element { "delete" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	'XML::EPP::Host::Item';

1;
