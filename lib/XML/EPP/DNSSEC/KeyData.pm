package XML::EPP::DNSSEC::KeyData;

use Moose;
use PRANG::Graph;

sub root_element {'keyData'}

with 'XML::EPP::DNSSEC::Node';

has_element 'flags' =>
	is => 'ro',
	isa => 'Int',
	required => 1,
	;

has_element 'protocol' =>
	is => 'ro',
	isa => 'Int',
	required => 1,
	;
	
has_element 'alg' =>
	is => 'ro',
	isa => 'Int',
	required => 1,
	;
	
has_element 'pubKey' =>
	is => 'ro',
	isa => 'Str',
	required => 1,
	;
	
1;