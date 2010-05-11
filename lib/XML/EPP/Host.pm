package XML::EPP::Host;
use Moose::Role;
with qw(XML::EPP::Plugin PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;
use XML::EPP::Common;

BEGIN {
	subtype "XML::EPP::Host::addrStringType"
		=> as "PRANG::XMLSchema::token"
		=> where { length $_ >= 3 and length $_ <= 45 };

	enum "XML::EPP::Host::ipType" => qw(v4 v6);

	enum "XML::EPP::Host::statusValueType" =>
		qw(clientDeleteProhibited clientUpdateProhibited
		   linked ok pendingCreate pendingDelete
		   pendingTransfer pendingUpdate
		   serverDeleteProhibited serverUpdateProhibited
		 );
}

use XML::EPP::Host::Create;
use XML::EPP::Host::Check;
use XML::EPP::Host::Delete;
use XML::EPP::Host::Info;
use XML::EPP::Host::Update;

use XML::EPP::Host::Check::Response;
use XML::EPP::Host::Info::Response;
use XML::EPP::Host::Create::Response;

use XML::EPP::Host::Notification;

# load up all other classes under XML::EPP::Host
use XML::EPP::Host::Address;
use XML::EPP::Host::Delta;
use XML::EPP::Host::Item;
use XML::EPP::Host::List;
use XML::EPP::Host::Node;
use XML::EPP::Host::Rename;
use XML::EPP::Host::RQ;
use XML::EPP::Host::RS;
use XML::EPP::Host::Status;

1;
