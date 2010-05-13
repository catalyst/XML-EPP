package XML::EPP::Host::Create;
use Moose;
use PRANG::Graph;
sub root_element { "create" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	;

has_element 'name' =>
	is => "ro",
	isa => "XML::EPP::Common::labelType",
	;

use XML::EPP::Host::Address;

has_element 'addr' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Host::Address]",
	xml_min => 0,
	coerce => 1,
	;

use Moose::Util::TypeConstraints;

# Moose Wishlist: should be able to infer this coercion from the two
# at the end of ::Address
coerce "ArrayRef[XML::EPP::Host::Address]"
	=> from "ArrayRef[XML::EPP::Host::Address|HashRef|Str]"
	=> via {
		my @rv = @$_;
		for ( @rv ) {
			if ( ref $_ eq "HASH" ) {
				$_ = XML::EPP::Host::Address->new($_);
			}
			elsif ( !blessed $_ ) {
				$_ = XML::EPP::Host::Address->new(
					value => $_,
				       );
			}
		}
		\@rv;
	},
	;

subtype "XML::EPP::Host::createType" => as __PACKAGE__;

1;

=head1 NAME

XML::EPP::Host::Create - implement createType

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

TODO

=head2 XML Schema Definition

 <!--
 Child elements of the <create> command.
 -->
 <complexType name="createType">
   <sequence>
     <element name="name" type="eppcom:labelType"/>
     <element name="addr" type="host:addrType"
      minOccurs="0" maxOccurs="unbounded"/>
   </sequence>
 </complexType>

=cut

