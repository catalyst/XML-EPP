
package XML::EPP::Greeting;

# based on epp-1.0.xsd:greetingType

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;
our $PKG = "XML::EPP::Greeting";
our $SCHEMA_PKG = "XML::EPP";

has_element 'server_name' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::sIDType",
	xml_nodeName => "svID",
	required => 1,
	;

has_element 'server_time' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	coerce => 1,
	xml_nodeName => "svDate",
	required => 1,
	;

use XML::EPP::SvcMenu;
has_element 'services' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::svcMenuType",
	xml_nodeName => "svcMenu",
	coerce => 1,
	required => 1,
	;

has_element 'dcp' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::DCP",
	coerce => 1,
	required => 1,
	;

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::greetingType"
	=> as __PACKAGE__;

sub is_command { 1 }

1;

__END__

=head1 NAME

XML::EPP::Greeting - a server greeting message

=head1 SYNOPSIS

 use MooseX::TimestampTZ qw(gmtimestamptz);

 my $greeting = XML::EPP::Greeting->new(
     server_name => "myhostname",
     current_time => gmtimestamptz,
     services => "auto",
     dcp => {
         access => "personalAndOther",
         statement => {
             purpose => "prov",
             recipient => "ours",
             retention => "business",
         },
         expiry => "PY1",
     },
     );

=head1 DESCRIPTION

This class represents the C<epp:greetingType> defined in RFC5730.
Messages of this type are returned by the server on a new connection,
or in response to a C<hello> message (see L<XML::EPP::Hello>).

The following properties are defined;

=over

=item B<server_name>

(Str; XML: C<svID>) "the name of the server"

=item B<server_time>

(Str; XML: C<svDate>) "the server's current date and time in Universal
Coordinated Time (UTC).

=item B<services>

(L<XML::EPP::SvcMenu>; XML: C<svcMenu>) "identifies the services
supported by the server" - essentially a protocol feature/version
negotiation property.  Set to C<auto> on the server for automagic
setting of values based on globals defined in L<XML::EPP>.

=item B<dcp>

(L<XML::EPP::DCP>) describes "the server's privacy policy for data
collection and management".

=back

=head1 SEE ALSO

L<XML::EPP>, L<XML::EPP::Response>, L<XML::EPP::DCP>

=head1 AUTHOR AND LICENSE

Development commissioned by NZ Registry Services, and carried out by
Catalyst IT - L<http://www.catalyst.net.nz/>

Copyright 2009, 2010, NZ Registry Services.  This module is licensed
under the Artistic License v2.0, which permits relicensing under other
Free Software licenses.

=cut

