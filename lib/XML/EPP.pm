
package XML::EPP;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use MooseX::StrictConstructor;

use constant XSI_XMLNS => "http://www.w3.org/2001/XMLSchema-instance";

use XML::EPP::Common;

our $VERSION = "0.05_02";

our $PKG;
BEGIN{ $PKG = "XML::EPP" };

#=====================================================================
#  epp-1.0.xsd mapping to types
#=====================================================================
# as this module describes the message format (ie, epp-1.0.xsd), it
# contains all of the types from that namespace, as well as the
# definition of the node.

# in principle, this should be generated programmatically; however
# this is a manual conversion based on a set of principles which are
# outlined in the comments.

# rule 1. simpleTypes become subtypes of basic types.  We need an
# XMLSchema type library for the 'built-in' XMLSchema types, I'll put
# them for the time being in:
use PRANG::XMLSchema::Types;

BEGIN {
	subtype "${PKG}::sIDType"
		=> as "PRANG::XMLSchema::normalizedString"
		=> where {
			length($_) >= 3 and length($_) <= 64;
		};

	subtype "${PKG}::versionType"
		=> as "PRANG::XMLSchema::token"
		=> where {
			m{^[1-9]+\.[0-9]+$} and $_ eq "1.0";
		};

	subtype "${PKG}::trIDStringType"
		=> as "PRANG::XMLSchema::token"
		=> where {
			length($_) >= 3 and length($_) <= 64;
		};

	subtype "${PKG}::pwType"
		=> as "PRANG::XMLSchema::token"
		=> where {
			length($_) >= 6 and length($_) <= 16;
		};
}

# rule 2.  ALL elements get converted to MessageNode types, with
# classes preferably named after the name of the element
use XML::EPP::Hello;

# however, as 'extURIType' is used in multiple places, with different
# element names, it gets a name based on its type.
use XML::EPP::ExtURI;
use XML::EPP::SvcMenu;
use XML::EPP::DCP;
use XML::EPP::Greeting;
use XML::EPP::CredsOptions;
use XML::EPP::RequestedSvcs;
use XML::EPP::Login;
use XML::EPP::Poll;
use XML::EPP::SubCommand;
use XML::EPP::Transfer;

# first rule: map complexTypes to classes.  Where types are only used
# in one place, the name of the class is the name of the *element* in
# which it is used.
use XML::EPP::Command;
use XML::EPP::TrID;
use XML::EPP::Extension;
use XML::EPP::Msg;
use XML::EPP::Result;
use XML::EPP::Response;

#=====================================================================
#  'epp' node definition
#=====================================================================
use PRANG::Graph;

# Now we have all of the type constraints from the XMLSchema
# definition defined, we can implement the 'epp' node.

# there is a 'choice' - this item has no name in the schema to use, so
# we call it 'choice0'
subtype "${PKG}::choice0" =>
	=> as join("|", map { "${PKG}::$_" }
			   qw(greetingType Hello commandType
			      responseType extAnyType) );

# but we map it to the object property 'message'; again this comes
# under 'schema customisation'
has_element 'message' =>
	is => "rw",
	isa => "${PKG}::choice0",
	required => 1,
	xml_nodeName => {
		"greeting" => "${PKG}::Greeting",
		"command" => "${PKG}::Command",
		"response" => "${PKG}::Response",
		"extension" => "${PKG}::Extension",
		"hello" => "${PKG}::Hello",
	       },
	handles => ["is_response"],
	;

method root_element { "epp" }

# this class implements a Message format - ie, a root of a schema - as
# well as a node - the documentRoot
with "PRANG::Graph", "XML::EPP::Node";

method is_command() {
	$self->message->is_command;
}

method is_response() {
	!$self->message->is_command;
}

sub _reg {
	shift if eval { $_[0]->isa(__PACKAGE__) };
	my $hash = shift;
	my $uri = shift;
	my $pkg_space = shift || 1;
	$hash->{$uri} = $pkg_space;
}
our @epp_versions = "1.0";
our @epp_lang = "en";
our %obj_uris;
our %ext_uris;
sub register_obj_uri {
}

sub register_ext_uri {
}

1;

=head1 NAME

XML::EPP - an implementation of the EPP XML language

=head1 SYNOPSIS

 use XML::EPP;

 my $foo_create = XML::EPP->new(
         message => XML::EPP::Command->new(
             action => "create",
             argument => XML::EPP::SubCommand->new(
                 payload => XML::EPP::Obj::create->new(
                     ...
                 ),
             ),
             clTRID => "xml_epp_".time."_$$",
         ),
 );

 print $foo_create->to_xml;

=head1 DESCRIPTION

This module is an implementation of the XML protocol used by most
major domain registries around the world.  This protocol was developed
between 2002 and 2004, using XML standards which were at the time very
new, such as XML Namespaces and XML Schema.  It saw several
incompatible revisions until the 1.0 version which became RFC3730.

This module hopes to create a Free Software, complete, user-friendly
and standards compliant interface to both client and server sides of
the EPP specification.

=head2 WARNING: SITE^WMODULE UNDER CONSTRUCTION

The classes which are present, while enough to be able to parse the
RFC, are not fixed in API terms until they are documented and tested.
Please consider any attribute which is not yet at least documented to
be under review and subject to rename.  This is thought to lead to a
clearer implementation than fixing attribute names to the somewhat
random (though well-known) names used in the EPP XML.  Use of C<sub
BUILDARGS { }> to allow either may be considered; patches welcome.

Similarly with undocumented portions of the implementation.  If you
would like to make sure that the code you write against it doesn't
need rewriting, please send a patch/pull request!

This module currently implements the XML part of the protocol only;
converting this into an actual EPP session is currently TO-DO.  Also,
none of the mappings for essential registry types, such as domain,
contact or host are yet implemented.  This is a preview release.

=head1 PARSING AN EPP MESSAGE

This part currently works very well.  Feed in some valid XML
I<thusly>;

  use XML::EPP;
  my $message = XML::EPP->parse( $xml );

If you can find B<any> RFC5730-valid document (including RFC5731,
RFC5732 or RFC5733) this doesn't parse, then you win a bag of
chocolate fish.  Similarly if you find an RFC-invalid document that
this module accepts blindly.  Please log an RT ticket and contact the
author privately for delivery of the chocolate.

=head1 CREATING AN EPP MESSAGE

There is an example in the C<SYNOPSIS>, but essentially the regular
Moose constructor is all that is provided in this module.

=head2 HINTS

Look out for convenience construction interfaces.  These are primarily
useful C<coerce> rules (see L<Moose::Util::TypeConstraints>).

For example, instead of writing (in the middle of constructing a
L<XML::EPP::DCP> stack):

    recipient => XML::EPP::DCP::Recipient->new(
            same => 1,
            ours => [
                 XML::EPP::DCP::Ours->new( name => "SomeCo Ltd" ),
                 XML::EPP::DCP::Ours->new( name => "Partner Ltd" ),
            ],
        ),

Coerce rules are defined to make this work:

    recipient => [ qw(same), "SomeCo Ltd", "Partner Ltd" ];

Both construct the same stack of objects, and would serialize to:

  <recipient xmlns="urn:ietf:params:xml:ns:epp-1.0">
    <ours><recDesc>SomeCo Ltd</recDesc></ours>
    <ours><recDesc>Parnet Ltd</recDesc></ours>
    <same/>
  </recipient>

For this to be most useful, the rules are hand-written for each class.

=head1 GLOBALS / CLASS METHODS

=head2 C<@XML::EPP::epp_versions>

The list of EPP versions implemented by this module.  Default value is
C<("1.0", )>.

=head2 C<@XML::EPP::epp_lang>

The list of EPP languages implemented by this module.  Default value
is C<("en", )>.

=head2 register_obj_uri( $uri[, $namespace])

Register the namespace C<$namespace> as corresponding to the C<$uri>
URI.  Object types such as L<XML::EPP::Domain>, etc will use this to
register themselves.  The loaded object types are available in the
global variable C<@XML::EPP::obj_uris>

=head2 register_ext_uri( $uri[, $namespace])

Exactly the same as the above, but the URI will be advertised as an
extension, not an object type.

=head1 SOURCE, SUBMISSIONS, SUPPORT

Source code is available from Catalyst:

  git://git.catalyst.net.nz/XML-EPP.git

And Github:

  git://github.com/catalyst/XML-EPP.git

Please see the file F<SubmittingPatches> for information on preferred
submission formats.

Suggested avenues for support:

=over

=item *

The DNRS forum on SourceForge -
L<http://sourceforge.net/projects/dnrs/forums>

=item *

Contact the author and ask either politely or commercially for help.

=item *

Log a ticket on L<http://rt.cpan.org/>

=back

=head1 SEE ALSO

L<XML::EPP::Changes> for what has most recently been added to
L<XML::EPP>.

L<XML::EPP::Domain> - an implementation of the RFC5731 domain mapping

L<XML::EPP::Host> - an implementation of the RFC5732 host mapping

L<XML::EPP::Contact> - an implementation of the RFC5733 contact
mapping

=head1 AUTHOR AND LICENCE

Development commissioned by NZ Registry Services, and carried out by
Catalyst IT - L<http://www.catalyst.net.nz/>

Copyright 2009, 2010, NZ Registry Services.  This module is licensed
under the Artistic License v2.0, which permits relicensing under other
Free Software licenses.

=cut

