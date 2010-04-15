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


1;
