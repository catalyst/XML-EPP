
package XML::EPP::Contact;
use Moose::Role;

with qw(XML::EPP::Plugin PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;
use XML::EPP::Common;

our $PKG;

BEGIN {
	$PKG = 'XML::EPP::Contact';

	enum "${PKG}::statusValueType" => qw (
		clientDeleteProhibited
		clientTransferProhibited
		clientUpdateProhibited
		linked
		ok
		pendingCreate
		pendingDelete
		pendingTransfer
		pendingUpdate
		serverDeleteProhibited
		serverTransferProhibited
		serverUpdateProhibited
	);

	enum "${PKG}::postalInfoEnumType" => qw (
		loc
		int
    );

	subtype "${PKG}::postalLineType"
		=> as 'Str'
		=> where {
			length($_) >= 1 and length($_) <= 255;
		};

	subtype "${PKG}::optPostalLineType"
		=> as 'Str'
		=> where {
			length($_) <= 255;
		};

	subtype "${PKG}::ccType"
		=> as "PRANG::XMLSchema::token"
		=> where {
			length($_) == 2;
		};

	subtype "${PKG}::e164StringType"
		=> as "PRANG::XMLSchema::token"
		=> where {
            length($_) <= 17 and $_ =~ m{(\+[0-9]{3}\.[0-9]{1,14})?}xms;
		};
}

use XML::EPP::Contact::Check;
use XML::EPP::Contact::Info;
use XML::EPP::Contact::Transfer;
use XML::EPP::Contact::Create;
use XML::EPP::Contact::Delete;
use XML::EPP::Contact::Update;
use XML::EPP::Contact::Notification;

use XML::EPP::Contact::Check::Response;
use XML::EPP::Contact::Info::Response;
use XML::EPP::Contact::Transfer::Response;
use XML::EPP::Contact::Create::Response;

# load up all other classes under XML::EPP::Contact
use XML::EPP::Contact::AddRem;
use XML::EPP::Contact::Addr;
use XML::EPP::Contact::AuthInfo;
use XML::EPP::Contact::Change;
use XML::EPP::Contact::ChangePostalInfo;
use XML::EPP::Contact::Create;
use XML::EPP::Contact::Disclose;
use XML::EPP::Contact::E164;
use XML::EPP::Contact::ID;
use XML::EPP::Contact::Location;
use XML::EPP::Contact::Node;
use XML::EPP::Contact::PostalInfo;
use XML::EPP::Contact::RQ;
use XML::EPP::Contact::RS;
use XML::EPP::Contact::Status;

1;
