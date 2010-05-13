package XML::EPP::Host::Address;
use Moose;
use PRANG::Graph;
with 'XML::EPP::Host::Node';
has_element "value" =>
	is => "ro",
	isa => "XML::EPP::Host::addrStringType",
	xml_nodeName => "",
	coerce => 1,
	;

has_attr "ip" =>
	is => "ro",
	isa => "XML::EPP::Host::ipType",
	default => "v4",
	;

use Moose::Util::TypeConstraints;
coerce __PACKAGE__
	=> from "Str",
	=> via { __PACKAGE__->new(value => $_) },
	;
coerce __PACKAGE__
	=> from "HashRef",
	=> via { __PACKAGE__->new($_) },
	;
subtype "XML::EPP::Host::addrType" => as __PACKAGE__;

1;

=head1 NAME

XML::EPP::Host::Address - implement addrType

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="addrType">
   <simpleContent>
     <extension base="host:addrStringType">
       <attribute name="ip" type="host:ipType"
        default="v4"/>
     </extension>
   </simpleContent>
 </complexType>

=cut
