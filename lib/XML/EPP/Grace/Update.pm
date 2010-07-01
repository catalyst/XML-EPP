
package XML::EPP::Grace::Update;

use Moose;
use PRANG::Graph;

sub root_element { 'update' }

with 'XML::EPP::Grace', 'XML::EPP::Grace::Node';

use XML::EPP::Grace::Restore;
has_element 'restore' =>
	is => 'ro',
	isa => 'XML::EPP::Grace::Restore',
	;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Grace::updateType"
	=> as __PACKAGE__;

1;
