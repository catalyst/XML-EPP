package XML::EPP::DNSSEC::Update;

use Moose;
use PRANG::Graph;

sub root_element {'update'}

with 'XML::EPP::DNSSEC', 'XML::EPP::DNSSEC::Node';

has_element 'rem' =>
	is => 'ro',
	isa => 'XML::EPP::DNSSEC::AddRem',
	xml_required => 0,
	xml_nodeName => 'rem',
	;
	
has_element 'add' =>
	is => 'ro',
	isa => 'XML::EPP::DNSSEC::AddRem',
	xml_required => 0,
	xml_nodeName => 'add',
	;
	
has_element 'chg' =>
	is => 'ro',
	isa => 'XML::EPP::DNSSEC::Chg',
	xml_required => 0,
	xml_nodeName => 'chg',
	;
	
has_attr 'urgent' =>
	is => 'ro',
	isa => 'Str',
	xml_required => 0,
	;

package XML::EPP::DNSSEC::AddRem;

use Moose;
use PRANG::Graph;

with 'XML::EPP::DNSSEC::Node';

has_element 'all' =>
	is => 'ro',
	isa => 'Str',
	xml_required => 0,
	;

with 'XML::EPP::DNSSEC::Elements';

package XML::EPP::DNSSEC::Chg;

use Moose;
use PRANG::Graph;

with 'XML::EPP::DNSSEC::Node';

has_element 'max_sig_life' =>
	is => 'ro',
	isa => 'Int',
	xml_required => 0,
	xml_nodeName => 'maxSigLife',
	;

1;
