
package XML::EPP::Grace;
use Moose::Role;

with qw(XML::EPP::Extension::Type PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;
use XML::EPP::Common;

our $PKG;

BEGIN {
	enum "XML::EPP::Grace::statusValueType" =>
		qw( addPeriod autoRenewPeriod renewPeriod
		    transferPeriod pendingDelete pendingRestore
		    redemptionPeriod );

	enum "XML::EPP::Grace::rgpOpType" => qw(request report);

	$PKG = "XML::EPP::Grace";
}

use XML::EPP::Grace::Info;
use XML::EPP::Grace::Update;
use XML::EPP::Grace::Update::Response;

1;
