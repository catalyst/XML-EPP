package XML::EPP::Domain::Info;

use Moose;
use PRANG::Graph;

sub root_element { 'info' }

with 'XML::EPP::Domain::RQ', 'XML::EPP::Domain::Node';

use XML::EPP::Domain::Info::Name;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::Info::Name',
	;

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AuthInfo',
	xml_required => 0,
	xml_nodeName => 'authInfo',
	;

1;
