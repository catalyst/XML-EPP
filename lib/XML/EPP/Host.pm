package XML::EPP::Host;
use Moose::Role;
use XML::EPP::Host::Check;
use XML::EPP::Host::Delete;
use XML::EPP::Host::Info;
with qw(XML::EPP::Plugin PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;

BEGIN {
	subtype "XML::EPP::Host::addrStringType"
		=> as "PRANG::XMLSchema::token"
		=> where { length $_ >= 3 and length $_ <= 45 };

	enum "XML::EPP::Host::ipType" => qw(v4 v6);
}

use XML::EPP::Host::Create;

1;
