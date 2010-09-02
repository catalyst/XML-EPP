package XML::EPP::DNSSEC::Elements;

# Role containing the elements used in all DNSSEC requests/responses

use Moose::Role;
use PRANG::Graph;

has_element 'ds_data' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::DNSSEC::DSData]',
	xml_required => 0,
	xml_nodeName => 'dsData',
	;
	
has_element 'key_data' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::DNSSEC::KeyData]',
	xml_required => 0,
	xml_nodeName => 'keyData',
	;