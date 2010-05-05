
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

use XML::EPP::Contact::Check::Response;
use XML::EPP::Contact::Info::Response;
use XML::EPP::Contact::Transfer::Response;
use XML::EPP::Contact::Create::Response;

1;
