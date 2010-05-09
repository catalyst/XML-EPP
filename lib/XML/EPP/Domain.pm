
package XML::EPP::Domain;
use Moose::Role;

with qw(XML::EPP::Plugin PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;
use XML::EPP::Common;

our $PKG;

BEGIN {
	$PKG = "XML::EPP::Domain";

	enum "${PKG}::hostsType" => qw( all del none sub );

	enum "${PKG}::statusValueType" => qw (
		clientDeleteProhibited
		clientHold
		clientRenewProhibited
		clientTransferProhibited
		clientUpdateProhibited
		inactive
		ok
		pendingCreate
		pendingDelete
		pendingRenew
		pendingTransfer
		pendingUpdate
		serverDeleteProhibited
		serverHold
		serverRenewProhibited
		serverTransferProhibited
		serverUpdateProhibited
	);

	enum "${PKG}::contactAttrType" => qw( admin billing tech );

	subtype "${PKG}::pLimitType" =>
		=> as "PRANG::XMLSchema::short"
		=> where { $_ >= 1 and $_ <= 99 };

	enum "${PKG}::pUnitType" => qw( y m );

	subtype "${PKG}::clIDChgType"
		=> as "PRANG::XMLSchema::token"
		=> where {
			length($_) <= 16;
		};
}

use XML::EPP::Domain::Check;
use XML::EPP::Domain::Info;
use XML::EPP::Domain::Transfer;
use XML::EPP::Domain::Create;
use XML::EPP::Domain::Delete;
use XML::EPP::Domain::Renew;
use XML::EPP::Domain::Update;

use XML::EPP::Domain::Check::Response;
use XML::EPP::Domain::Info::Response;
use XML::EPP::Domain::Transfer::Response;
use XML::EPP::Domain::Create::Response;
# no response needed for 'Delete', already covered
use XML::EPP::Domain::Renew::Response;
# no response needed for 'Update', already covered
use XML::EPP::Domain::Notification;

# load up all other classes under XML::EPP::Domain
use XML::EPP::Domain::AddRem;
use XML::EPP::Domain::AuthInfo;
use XML::EPP::Domain::Change;
use XML::EPP::Domain::Check::Name;
use XML::EPP::Domain::Check::Status;
use XML::EPP::Domain::Contact;
use XML::EPP::Domain::HostAttr;
use XML::EPP::Domain::Info::Name;
use XML::EPP::Domain::Node;
use XML::EPP::Domain::Notification::Name;
use XML::EPP::Domain::NS::List;
use XML::EPP::Domain::NS;
use XML::EPP::Domain::Period;
use XML::EPP::Domain::RQ;
use XML::EPP::Domain::RS;
use XML::EPP::Domain::Status;

1;
