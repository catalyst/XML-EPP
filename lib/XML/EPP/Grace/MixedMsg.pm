
package XML::EPP::Grace::MixedMsg;

use Moose;
use PRANG::Graph;

extends 'XML::EPP::Grace::MixedData';

has_attr 'lang' =>
	is => "rw",
	isa => "PRANG::XMLSchema::language",
	default => "en",
	;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Grace::mixedMsgType"
	=> as __PACKAGE__;

1;
