package XML::EPP::Host::Update;
use Moose;
use PRANG::Graph;
sub root_element { "update" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	;

has_element 'name' =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
	;

use XML::EPP::Host::Delta;
has_element 'add' =>
	is => "ro",
	isa => "XML::EPP::Host::Delta",
	predicate => "has_add",
	coerce => 1,
	;

has_element 'remove' =>
	is => "ro",
	isa => "XML::EPP::Host::Delta",
	predicate => "has_remove",
	xml_nodeName => "rem",
	coerce => 1,
	;

use XML::EPP::Host::Rename;
has_element 'rename' =>
	is => "ro",
	isa => "XML::EPP::Host::Rename",
	xml_nodeName => "chg",
	predicate => "has_rename",
	coerce => 1,
	;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Host::updateType" => as __PACKAGE__;

1;

