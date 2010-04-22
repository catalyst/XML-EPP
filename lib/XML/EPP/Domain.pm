
package XML::EPP::Domain;
use Moose::Role;

with qw(XML::EPP::Plugin PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;
use XML::EPP::Common;

BEGIN {
	enum "XML::EPP::Domain::hostsType" => qw( all del none sub );
}

use XML::EPP::Domain::Check;
use XML::EPP::Domain::Info;

#use XML::EPP::Domain::Create;
#use XML::EPP::Domain::Delete;
#use XML::EPP::Domain::Update;

use XML::EPP::Domain::Check::Response;
use XML::EPP::Domain::Info::Response;
#use XML::EPP::Domain::Create::Response;

#use XML::EPP::Domain::Notification;

1;
