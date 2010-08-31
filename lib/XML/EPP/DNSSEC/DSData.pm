package XML::EPP::DNSSEC::DSData;

use Moose;
use PRANG::Graph;

sub root_element {'dsData'}

with 'XML::EPP::DNSSEC::Node';

has_element 'key_tag' =>
	is => 'ro',
	isa => 'Int',
	required => 1,
	xml_nodeName => 'keyTag',
	;
	
has_element 'alg' =>
	is => 'ro',
	isa => 'Int',
	required => 1,
	;

has_element 'digest_type' =>
	is => 'ro',
	isa => 'Int',
	required => 1,
	xml_nodeName => 'digestType',	
	;

has_element 'digest' =>
	is => 'ro',
	isa => 'Str',
	required => 1,
	;

1;
