
package XML::EPP::Grace::MixedData;

use Moose;
use PRANG::Graph;

has_element 'contents' =>
	is => "rw",
	isa => "ArrayRef[XML::EPP::Grace::MixedData|Str]",
	xml_nodeName => { "" => "Str", "*" => "XML::EPP::Grace::MixedData" },
	xml_nodeName_attr => "nodenames",
	xml_min => 0,
	;

has 'nodenames' =>
	is => "rw",
	isa => "ArrayRef[Maybe[Str]]",
	;

has_attr 'attributes' =>
	is => "rw",
	isa => "HashRef[Str|ArrayRef[Str]]",
	xml_name => "*",
	predicate => 'has_attributes',
	;

use Moose::Util::TypeConstraints;
subtype "XML::EPP::Grace::mixedType"
	=> as __PACKAGE__;

1;
