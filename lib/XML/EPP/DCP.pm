
package XML::EPP::DCP::Expiry;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;
use PRANG::XMLSchema::Types;

our $SCHEMA_PKG = "XML::EPP";

# hmm, choice with simpleTypes can't be mapped quite the same..
has 'absolute' =>
	is => "rw",
	isa => "PRANG::XMLSchema::dateTime",
	predicate => "has_absolute",
	clearer => "clear_absolute",
	trigger => sub { $_[0]->is_abs_or_rel("absolute") },
	;

has 'relative' =>
	is => "rw",
	isa => "PRANG::XMLSchema::duration",
	predicate => "has_relative",
	clearer => "clear_relative",
	trigger => sub { $_[0]->is_abs_or_rel("relative") },
	;

has_element 'abs_or_rel' =>
	is => "rw",
	isa => "PRANG::XMLSchema::duration|PRANG::XMLSchema::dateTime",
	xml_nodeName => {
		"absolute" => "PRANG::XMLSchema::dateTime",
		"relative" => "PRANG::XMLSchema::duration",
	},
	xml_nodeName_attr => "is_abs_or_rel",
	;

method is_abs_or_rel( Str $abs_or_rel? where { m{^(relative|absolute)$} } ) {
	if ( defined $abs_or_rel ) {
		if ( $abs_or_rel eq "relative" ) {
			$self->clear_absolute;
		}
		else {
			$self->clear_relative;
		}
	}
	else {
		if ( $self->has_relative ) {
			"relative";
		}
		elsif ( $self->has_absolute ) {
			"absolute";
		}
		else {
			die "neither absolute nor relative time in $self";
		}
	}
}

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::dcpExpiryType"
	=> as __PACKAGE__;
coerce "${SCHEMA_PKG}::dcpExpiryType"
	=> from "PRANG::XMLSchema::duration"
	=> via {
		__PACKAGE__->new(relative => $_);
	};
coerce "${SCHEMA_PKG}::dcpExpiryType"
	=> from "PRANG::XMLSchema::dateTime"
	=> via {
		__PACKAGE__->new(absolute => $_);
	};

package XML::EPP::DCP::Ours;

use Moose;
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;
use PRANG::Graph;
our $SCHEMA_PKG = "XML::EPP";

subtype "${SCHEMA_PKG}::dcpRecDescType"
	=> as "PRANG::XMLSchema::token"
	=> where {
		length($_) and length($_) <= 255;
	};

has_element 'name' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::dcpRecDescType",
	predicate => "has_name",
	xml_nodeName => "recDesc",
	;

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::dcpOursType"
	=> as __PACKAGE__;


package XML::EPP::DCP::Recipient;

use Moose;
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;
use PRANG::Graph;
our $SCHEMA_PKG = "XML::EPP";

our @valid_recipients = qw(other ours public same unrelated);
for my $recipient ( @valid_recipients ) {

	my $type = $recipient eq "ours" ?
		"ArrayRef[${SCHEMA_PKG}::dcpOursType]" : "Bool";

	has_element $recipient =>
		(is => "rw",
		 isa => $type,
		 predicate => "has_$recipient",
		 );
}

with 'XML::EPP::Node';

subtype "${SCHEMA_PKG}::dcpRecipientType"
	=> as __PACKAGE__;

coerce "${SCHEMA_PKG}::dcpRecipientType"
	=> from "Str|ArrayRef[Str]"
	=> via {
		my @recipient = (ref $_ ? @$_ : $_);
		my %recipients = map { $_ => 1 } @recipient;
		my @init_args;
		my @ours;
		for my $recipient ( @valid_recipients ) {
			if (delete $recipients{$recipient}) {
				if ( $recipient eq "ours") {
					push @ours, XML::EPP::DCP::Ours->new;
				}
				else {
					push @init_args, $recipient => 1;
				}
			}
		}
		push @ours, map {
			XML::EPP::DCP::Ours->new( name => $_ );
		} keys %recipients;

		push @init_args, ours => \@ours
			if @ours;

		__PACKAGE__->new(@init_args);
	};

package XML::EPP::DCP::Access;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;
our $SCHEMA_PKG = "XML::EPP";

my @access_enum = qw(all none null other personal personalAndOther);
enum "${SCHEMA_PKG}::dcpAccessType::enum" => @access_enum;

has 'access' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::dcpAccessType::enum",
	trigger => sub { $_[0]->access_node(1) },
	;

has_element 'access_node' =>
	is => "rw",
	isa => "Bool",
	xml_nodeName => { map { $_ => "Bool" } @access_enum },
	xml_nodeName_attr => "access",
	;

with "${SCHEMA_PKG}::Node";

subtype "${SCHEMA_PKG}::dcpAccessType"
	=> as __PACKAGE__;

coerce "${SCHEMA_PKG}::dcpAccessType"
	=> from "Str"
	=> via {
		__PACKAGE__->new($_ => 1);
	};


package XML::EPP::DCP;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;
our $SCHEMA_PKG = "XML::EPP";

has_element 'access' =>
	is => "rw",
	isa => "XML::EPP::dcpAccessType",
	coerce => 1,
	;

has_element 'statement' =>
	is => "rw",
	isa => "ArrayRef[XML::EPP::DCP::Statement]",
	coerce => 1,
	;

coerce "ArrayRef[XML::EPP::DCP::Statement]"
	=> from "ArrayRef[HashRef]"
	=> via {
		my @x = @$_;
		[ map { XML::EPP::DCP::Statement->new(%$_) }
			  @x ];
	};

coerce "ArrayRef[XML::EPP::DCP::Statement]"
	=> from "HashRef"
	=> via {
		[ XML::EPP::DCP::Statement->new(%$_) ];
	};

has_element 'expiry' =>
	is => "rw",
	predicate => "has_expiry",
	isa => "${SCHEMA_PKG}::dcpExpiryType",
	coerce => 1,
	;

with "${SCHEMA_PKG}::Node";

subtype "${SCHEMA_PKG}::dcpType"
	=> as __PACKAGE__;

coerce __PACKAGE__
	=> from "HashRef"
	=> via {
		__PACKAGE__->new(%$_);
	};

package XML::EPP::DCP::Purpose;

use Moose;
our $SCHEMA_PKG = "XML::EPP";
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;
use PRANG::Graph;

my @valid_purposes = qw(admin contact other prov);
has_element $_ =>
	is => "rw",
	isa => "Bool"
	for @valid_purposes;

with "${SCHEMA_PKG}::Node";

subtype "${SCHEMA_PKG}::dcpPurposeType"
	=> as __PACKAGE__;

coerce "${SCHEMA_PKG}::dcpPurposeType"
	=> from "Str|ArrayRef[Str]"
	=> via {
		my @purposes = ref $_ ? @$_ : $_;
		my %purposes = map { $_ => 1 } @purposes;
		my @init_args;
		for my $purpose ( @valid_purposes ) {
			if ( delete $purposes{$purpose} ) {
				push @init_args, $purpose => 1,
			}
		}
		if ( keys %purposes ) {
			die "invalid purpose(s): @{[keys %purposes]}";
		}
		__PACKAGE__->new(@init_args);
	};

package XML::EPP::DCP::Retention;

use Moose;
our $SCHEMA_PKG = "XML::EPP";
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;
use PRANG::Graph;

my @retention_types = qw(business indefinite legal none stated);
enum "${SCHEMA_PKG}::dcpRetentionType::enum"
	=> @retention_types;

with "${SCHEMA_PKG}::Node";

has 'retention' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::dcpRetentionType::enum",
	trigger => sub {
		$_[0]->has_retention(1);
	};

has_element 'has_retention' =>
	is => "rw",
	isa => "Bool",
	xml_nodeName => { map { $_ => "Bool" } @retention_types },
	xml_nodeName_attr => "retention",
	;

subtype "${SCHEMA_PKG}::dcpRetentionType"
	=> as __PACKAGE__;
coerce "${SCHEMA_PKG}::dcpRetentionType"
	=> from "Str"
	=> via {
		__PACKAGE__->new(retention => $_);
	};

package XML::EPP::DCP::Statement;

use Moose;
our $SCHEMA_PKG = "XML::EPP";
use Moose::Util::TypeConstraints;
use MooseX::Method::Signatures;
use PRANG::Graph;

has_element 'purpose' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::dcpPurposeType",
	coerce => 1,
	;

has_element 'recipient' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::dcpRecipientType",
	coerce => 1,
	;

has_element 'retention' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::dcpRetentionType",
	coerce => 1,
	;

with "${SCHEMA_PKG}::Node";

subtype "${SCHEMA_PKG}::dcpStatementType"
	=> as __PACKAGE__;

1;

__END__

=head1 NAME

XML::EPP::DCP - Data Collection Policy object

=head1 SYNOPSIS

  my $DCP = XML::EPP::DCP->new(
      access => "personalAndOther",  # only one value allowed
      statement => {                 # array of hash refs OK
          purpose => "prov",         # array of str OK
          recipient => "ours",       # array of str OK; see notes
          retention => "business",   # only one value allowed
      },
      expiry => "PY1",               # optional; specify policy expiry
     );

=head1 DESCRIPTION

This module represents a Data Collection Policy, a part of the EPP
Greeting format.  The DCP is

           used to describe the server's privacy policy for data
  collection and management.

The RFC also notes;

                              Policy implications usually extend
  beyond the client-server relationship.  Both clients and
  servers can have relationships with other entities that need to
  know the server operator's data collection policy to make
  informed provisioning decisions.  Policy information MUST be
  disclosed to provisioning entities, though the method of
  disclosing policy data outside of direct protocol interaction
  is beyond the scope of this specification.

Hear that?  There's a B<MUST> there, so take heed: you absolutely must
know about other parties' policies, in some unspecified manner, beyond
the scope of the protocol, to be conformant to the protocol.  Nice
work, committee!  Now, you as a reader, I B<DOUBLE DOG DARE> you to
find out whether or not compliance with extra-protocol requirements
like this would actually affect any kind of agreement that you have
with any of your business partners.  Note that the B<DOUBLE DOG DARE>
trumps all keywords defined in RFC 2119, so now I<you really have to
do this> - nyeh nyeh nyeh-nyeh nyeh!

The following classes and properties are defined; once the object
structure is created, or if you are dealing with a DCP from a server
greeting, this API is how you must access the object.

They are concisely described here; note there are many coercion rules
for convenience and these are summaried in the L</SYNOPSIS>.

=head2 XML::EPP::DCP

This is the top-level object; there is exactly one of these in each
greeting.

Properties: B<access> (see L</XML::EPP::DCP::Access>), B<statement>
(array; see L</XML::EPP::DCP::Statement>), B<expiry> (See
L</XML::EPP::DCP::Expiry>)

=head2 XML::EPP::DCP::Access

This object;

                          describes the access provided by
 the server to the client on behalf of the originating data
 source.

It may have only one of its 6 boolean properties set; is is
essentially an enumerated value (this is not currently enforced).  It
is not implemented as a simple enum due to its structure in the XML
Schema.

Here are the values and description from RFC5730; these are all
available as properties from the B<XML::EPP::DCP::Access> object;

=over

=item B<all>

Access is given to all identified data.

=item B<none>

No access is provided to identified data.

=item B<null>

Data is not persistent, so no access is possible.

=item B<personal>

Access is given to identified data relating to individuals and
organizational entities.

=item B<personalAndOther>

Access is given to identified data relating to individuals,
organizational entities, and other data of a non-personal nature.

=item B<other>

Access is given to other identified data of a non-personal nature.

=back

=head2 XML::EPP::DCP::Statement

These objects

                                       describe data
 collection purposes, data recipients, and data retention.

There can be more than one of these for each DCP.

Properties: B<purpose> (see L</XML::EPP::DCP::Purpose>), B<recipient>
(see L</XML::EPP::DCP::Recipient>), B<retention> (see
L</XML::EPP::DCP::Retention>)

=head2 XML::EPP::DCP::Purpose

A set of values describing "the purposes for which data is collected"

Like B<XML::EPP::DCP::Access>, this object has a bunch of boolean
properties.  At least one must be set, but any number can be set at
once.  They are (the following text is from RFC5730):

=over

=item B<admin>

Administrative purposes.  Information can be used for administrative
and technical support of the provisioning system.

=item B<contact>

Contact for marketing purposes.  Information can be used to contact
individuals, through a communications channel other than the protocol,
for the promotion of a product or service.

=item B<prov>

Object-provisioning purposes.  Information can be used to identify
objects and inter-object relationships.

=item B<other>

Other purposes.  Information may be used in other ways not captured by
the above definitions.

=back

=head2 XML::EPP::DCP::Recipient

For the most part, this object is like the other quasi-enum types,
B<XML::EPP::DCP::Access> and B<XML::EPP::DCP::Purpose>.  This field

  describes the recipients of collected data

This object has a collection of properties, most of which are boolean
like the other two classes.  Like B<::Purpose> (but I<unlike>
B<::Access>), more than one may be set simultaneously.  However, the
B<ours> property is an array of B<XML::EPP::DCP::Ours> objects, which
may be named entities, and appear multiple times.

As such, there is a special case for the rule for this type when
coercing from C<ArrayRef[Str]> (ie, a list of strings); if an unknown
string appears, it is converted to a B<XML::EPP::DCP::Ours> object
with the B<name> property set to the passed-in value.

Valid types of recipient (and hence, property names of this object)
are;

=over

=item B<other>

Other entities following unknown practices.

=item B<ours>

Server operator and/or entities acting as agents or entities for whom
the server operator is acting as an agent.  This property is an Array
Reference of L</XML::EPP::DCP::Ours> objects.

=item B<public>

Public forums.

=item B<same>

Other entities following server practices.

=item B<unrelated>

Unrelated third parties.

=back

=head2 XML::EPP::DCP::Ours

As described in the previous section, an entry in the C<ours> array
property of a B<XML::EPP::DCP::Recipient> object.

                   An agent in this instance is defined as
  a third party that processes data only on behalf of the service
  provider for the completion of the stated purposes.

Properties: B<name> (optional Str; "used to describe the recipient")

=head2 XML::EPP::DCP::Retention

Another quasi-enum type, only a single property may be set at once for
this type.  It specifies

  data retention practices

So there you have it.  The allowed types of practices, and hence
properties of this class, are:

=over

=item B<business>

Data persists per business practices.

=item B<indefinite>

Data persists indefinitely.

=item B<legal>

Data persists per legal requirements.

=item B<none>

Data is not persistent and is not retained for more than a brief
period of time necessary to make use of it during the course of a
single online interaction.

=item B<stated>

Data persists to meet the stated purpose.

=back

=head2 XML::EPP::DCP::Expiry

This specifies "the lifetime of the policy" and is optional.

Properties: B<absolute> (an ISO-8601 dateTime eg
C<20100426T19:52+12>), B<relative> (an ISO-8601 duration eg C<PY2M52m>
for 2 years, 5 months, 2 minutes - mutually exclusive with
absolute)

The subtype C<XML::EPP::dcpExpiryType> will happily co-erce from a
valid C<Str> which is already a valid ISO-8601 dateTime (the precise
subset of which is defined in the XML Schema specification).  Values
accepted by L<MooseX::TimestampTZ> are also accepted.

=head1 SEE ALSO

L<XML::EPP>, L<XML::EPP::Greeting>

=head1 AUTHOR AND LICENSE

Development commissioned by NZ Registry Services, and carried out by
Catalyst IT - L<http://www.catalyst.net.nz/>

Copyright 2009, 2010, NZ Registry Services.  This module is licensed
under the Artistic License v2.0, which permits relicensing under other
Free Software licenses.

=cut
