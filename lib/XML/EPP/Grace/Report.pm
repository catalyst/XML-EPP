
package XML::EPP::Grace::Report;

use Moose;
use PRANG::Graph;

use XML::EPP::Grace::MixedData;

# the below elements are "processContents='lax'"; PRANG should support
# use of, eg 'PRANG::Graph' as a role which maps this.
has_element "pre" =>
	is => "ro",
	isa => "XML::EPP::Grace::MixedData",
	xml_nodeName => "preData",
	;

has_element "post" =>
	is => "ro",
	isa => "XML::EPP::Grace::MixedData",
	xml_nodeName => "postData",
	;

use PRANG::XMLSchema::Types;

has_element "deleted" =>
	is => "ro",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "delTime",
	;

has_element "restored" =>
	is => "ro",
	isa => "PRANG::XMLSchema::dateTime",
	xml_nodeName => "resTime",
	;

use XML::EPP::Grace::MixedMsg;
has_element "reason" =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Grace::MixedMsg]",
	xml_max => 2,
	xml_nodeName => "resReason",
	;

has_element "statement" =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Grace::MixedMsg]",
	xml_max => 2,
	;

has_element "other" =>
	is => "ro",
	isa => "XML::EPP::Grace::MixedData",
	;

use Moose::Util::TypeConstraints;
subtype 'XML::EPP::Grace::reportType'
	=> as __PACKAGE__;

1;
