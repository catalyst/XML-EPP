
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

has_element 'services' =>
	is => "rw",
	isa => "ArrayRef[PRANG::XMLSchema::anyURI]",
	required => 1,
	xml_nodeName => "objURI",
	auto_deref => 1,
	;

has_element 'ext_services' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::ExtURI",
	predicate => "has_ext_services",
	xml_nodeName => "svcExtension",
	handles => [qw( extensions )],
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
		services => [ keys %XML::EPP::obj_uris ],
		(   keys %XML::EPP::ext_uris
			? (ext_services => XML::EPP::ExtURI->new(
				extensions => [ keys %XML::EPP::ext_uris ],
			))
			: ()
		),
	);
	};

1;
