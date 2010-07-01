
package XML::EPP::Grace::Restore;

use Moose;
use PRANG::Graph;
use PRANG::XMLSchema::Types;
use Moose::Util::TypeConstraints;

enum "XML::EPP::Grace::rgpOpType" => qw(request report);

has_attr 'op' =>
	is => "ro",
	isa => "XML::EPP::Grace::rgpOpType",
	required => 1,
	;

has_element "report" =>
	is => "ro",
	isa => "XML::EPP::Grace::Report",
	xml_required => 0,
	;

with 'XML::EPP::Grace::Node';

subtype 'XML::EPP::Grace::restoreType'
	=> as __PACKAGE__;

1;
