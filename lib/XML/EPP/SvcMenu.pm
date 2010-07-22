
package XML::EPP::SvcMenu;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

our $SCHEMA_PKG = "XML::EPP";

has_element 'version' =>
	is => "rw",
	isa => "ArrayRef[${SCHEMA_PKG}::versionType]",
	required => 1,
	;

has_element 'lang' =>
	is => "rw",
	isa => "ArrayRef[PRANG::XMLSchema::language]",
	required => 1,
	;

has_element 'objURI' =>
	is => "rw",
	isa => "ArrayRef[PRANG::XMLSchema::anyURI]",
	required => 1,
	;

has_element 'svcExtension' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::ExtURI",
	predicate => "has_svcExtension",
	;

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::svcMenuType"
	=> as __PACKAGE__;

subtype "${SCHEMA_PKG}::svcMenuType::auto"
	=> as "Str"
	=> where { $_ eq "auto" };

coerce "${SCHEMA_PKG}::svcMenuType"
	=> from "${SCHEMA_PKG}::svcMenuType::auto"
	=> via {
		__PACKAGE__->new(
			version => \@XML::EPP::epp_versions,
			lang => \@XML::EPP::epp_lang,
			objURI => [ keys %XML::EPP::obj_uris ],
			( keys %XML::EPP::ext_uris ?
				  (svcExtension => [ keys %XML::EPP::ext_uris ])
					  : () ),
		       );
	};

1;
