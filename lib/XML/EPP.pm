
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

 my $epp = XML::EPP->new(
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

 print $epp->to_xml;

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

In order to get the most out of this set of modules, look out for the
following;

=head3 SIMPLE ATTRIBUTE/ELEMENT NAMES

The names of elements and attributes in the XML Schema specification
are typically arbitrarily abbreviated, and usually in CamelCase.
Sometimes the connection between what you would normally call the item
in plain English and the term chosen in the RFC are quite far removed
from each other.  Instead, in this module you can expect more plain
terms, and words lower case and separated by underscores.

Currently the declarations (ie source) are the best place to look for
normative information on what XML tags were renamed to what in this
module, but we hope soon to have this information all on the man
pages, too.

=head3 COERCE RULES AND CONSTRUCTOR MAGIC

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

=head3 USEFUL DELEGATION AND ACCESSORS

B<TODO>: currently there are very few of these defined, but the idea
is to use delegation to avoid the excessive level of indirection which
results from a direct translation of XML structure to class structure
required by PRANG.

For example, to retrieve the requested username from a C<login>
message, you currently have to use:

 my $username = $epp->message->argument->client_id;

Using delegation it would be quite easy to have shortcuts;

 my $username = $epp->argument->client_id;

Specialist delegation that throws a more helpful error is also a
potential idea;

 my $username = $epp->login->client_id;

The above should throw a message such as "code treated the message as
a login, but it is a hello" or some such.  This is an I<asserting>
version of delegation.

For core actions such as creating domains, the path is very long
indeed; assuming C<$epp> represents a C<domain:check> message;

  my @domains = $epp->message->argument->payload->names;

That could easily be;

  my @domains = $epp->payload->names;

Or an asserting version;

  my @domains = $epp->check->names;

=head1 DEFINED TYPES

As well as being a concrete message type, this module corresponds to
the C<urn:ietf:params:xml:ns:epp-1.0> XML namespace; all of the types
which are defined in L<rfc5730/4.1. Base Schema> land as types in this
module.  The modules as defined in the RFC have names such as
C<eppType>, C<greetingType>, etc.

Simple types in the EPP spec are mapped to C<Str> sub-types, whereas
Complex types become full classes.  These will normally be called
C<XML::EPP::Foo>, where C<Foo> is some suitable translation of the
type in the XML Schema to a reasonable class name.

Extensions, such as L<XML::EPP::Domain>, L<XML::EPP::Host>, are
described separately.

As the complex types are far more interesting than the simple types,
we'll start with those first.

=head2 COMPLEX TYPES

In these examples, an example location in terms of dereferencing from
an C<XML::EPP> object, C<$epp> is provided for illustration.  As these
are types, they can often appear in many different places, so these
examples should not be considered exhaustive.

=over

=item C<eppType>

This is the root node type; it's the C<$epp>.  Given that this is also
this class, there is no better place to reproduce the XML Schema
definition;

 <!--
 An EPP XML instance must contain a greeting, hello, command,
 response, or extension.
 -->
   <complexType name="eppType">
     <choice>
       <element name="greeting" type="epp:greetingType"/>
       <element name="hello"/>
       <element name="command" type="epp:commandType"/>
       <element name="response" type="epp:responseType"/>
       <element name="extension" type="epp:extAnyType"/>
     </choice>
   </complexType>

=item C<greetingType>

Found at C<$epp-E<gt>message>, and implemented in
L<XML::EPP::Greeting> class, the connection response message from the
server, which lists capabilities.  This can also be returned in
response to a C<hello> command, which does not have a type in the XML
Schema but gets its own class anyway for consistency; see
L<XML::EPP::Hello>.

=item C<commandType>

(C<$epp-E<gt>message>, L<XML::EPP::Command>) The second of the major
types of EPP message; all of the core commands are wrapped in one of
these.

=item C<responseType>

(C<$epp-E<gt>message>, L<XML::EPP::Response>) An answer to an EPP
command.

=item C<extAnyType>

(C<$epp-E<gt>extension>, C<$epp-E<gt>command-E<gt>extension>,
C<$epp-E<gt>response-E<gt>extension>; L<XML::EPP::Extension>) Part of
what makes this protocol "extensible", this type is for wrapping
arbitrary communications on the message wrapper, or a command or
response message.

(C<$epp-E<gt>response-E<gt>response; L<XML::EPP::SubResponse>) This
type is also used for the return type, instead of a new type like
C<readWriteType>, this is mapped to a different class so that they
don't get confused with real extensions.

=item C<svcMenuType>

(C<$epp-E<gt>message-E<gt>services>: Greeting messages only,
L<XML::EPP::SvcMenu>) A list of available object services.

=item C<extURIType>

(C<$epp-E<gt>message-E<gt>services-E<gt>extensions>: Greeting messages,
C<$epp-E<gt>message-E<gt>payload-E<gt>argument-E<gt>services-E<gt>extensions>:
Login messages; L<XML::EPP::ExtURI>) A I<list> of extension URIs used
during login and for the greeting message.

=item C<dcpType>

=item C<dcpExpiryType>

=item C<dcpRecipientType>

=item C<dcpOursType>

=item C<dcpRecDescType>

=item C<dcpAccessType>

=item C<dcpPurposeType>

=item C<dcpRetentionType>

=item C<dcpStatementType>

This collection of types are used for the Data Control Policy part of
the protocol; these are informative tags which codify how data is
stored and treated, and can in princple be used to implement privacy
rules.  See L<XML::EPP::DCP>.

=item C<readWriteType>

(C<$epp-E<gt>command-E<gt>argument or just C<$epp-E<gt>argument>;
L<XML::EPP::SubCommand>) this is an intermediate type which indicates
that this message carries an object manipulation or query payload.

=item C<loginType>

(C<$epp-E<gt>message-E<gt>argument or just C<$epp-E<gt>login>;
L<XML::EPP::Login>) for the login command; contains credentials and a
list of requested object services/extensions.

=item C<pollType>

(C<$epp-E<gt>message-E<gt>argument or just C<$epp-E<gt>poll>;
L<XML::EPP::Poll>) the command which polls or acks messages in the
server-side message queue.

=item C<transferType>

(C<$epp-E<gt>command-E<gt>argument or just C<$epp-E<gt>transfer>;
L<XML::EPP::Transfer>), a bit like the C<readWriteType> except it also
indicates the transfer operation type; request, query etc.

=item C<credsOptionsType>

(..., L<XML::EPP::CredsOptions>)

=item C<errValueType>

(..., L<PRANG::XMLSchema::Whatever>)

=item C<extErrValueType>

(..., L<XML::EPP::Error>)

=item C<msgType>

(..., L<XML::EPP::Msg>)

=item C<mixedMsgType>

(..., L<XML::EPP::MixedMsg>)

=item C<msgQType>

(..., L<XML::EPP::MsgQ>)

=item C<trIDType>

(..., L<XML::EPP::TrID>)

=item C<resultType>

(..., L<XML::EPP::Result>)

=back

=head2 SIMPLE TYPES

=over

=item C<sIDType>

This is a type which is used for server names.  The RFC example value
is C<Example EPP server epp.example.com>

 <!--
 Server IDs are strings with minimum and maximum length restrictions.
 -->
   <simpleType name="sIDType">
     <restriction base="normalizedString">
       <minLength value="3"/>
       <maxLength value="64"/>
     </restriction>
   </simpleType>

=item C<versionType>

During the C<hello> / C<greeting> exchange, a version number is
passed.  This type declares the convention for these and might one day
allow other values than "1.0";

 <!--
 An EPP version number is a dotted pair of decimal numbers.
 -->
   <simpleType name="versionType">
     <restriction base="token">
       <pattern value="[1-9]+\.[0-9]+"/>
       <enumeration value="1.0"/>
     </restriction>
   </simpleType>

=item C<trIDStringType>

This type is used in the various transaction identifier elements, see
L</trIDType>.

  <simpleType name="trIDStringType">
    <restriction base="token">
      <minLength value="3"/>
      <maxLength value="64"/>
    </restriction>
  </simpleType>

=item C<pwType>

Used for C<login> passwords.

  <simpleType name="pwType">
    <restriction base="token">
      <minLength value="6"/>
      <maxLength value="16"/>
    </restriction>
  </simpleType>

=back


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

