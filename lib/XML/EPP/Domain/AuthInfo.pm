package XML::EPP::Domain::AuthInfo;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Domain::Node';

has_element 'pw' =>
	is => 'ro',
	isa => 'XML::EPP::Common::Password',
	;

1;
