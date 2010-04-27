package XML::EPP::Domain::Transfer;

use Moose;
use PRANG::Graph;

sub root_element { 'transfer' }

with
	'XML::EPP::Domain::RQ',
	'XML::EPP::Domain::Node',
	;

use XML::EPP::Domain::Info::Name;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Common::labelType',
	;

use XML::EPP::Domain::Period;
has_element 'period' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::Period',
	xml_required => 0,
	;

#use XML::EPP::Domain;
#has_element 'period' =>
#	is => 'ro',
#	isa => 'XML::EPP::Domain::pLimitType',
#	xml_required => 0,
#	;

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AuthInfo',
	xml_required => 0,
	xml_nodeName => 'authInfo',
	;

1;
