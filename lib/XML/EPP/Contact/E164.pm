
package XML::EPP::Contact::E164;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;
use PRANG::XMLSchema::Types;

our $SCHEMA_PKG = "XML::EPP::Contact";

has_attr 'x' =>
	is => 'rw',
	isa => 'PRANG::XMLSchema::token',
	;

has_element 'content' =>
	is => 'rw',
	isa => 'XML::EPP::Contact::e164StringType',
	xml_nodeName => '',
	;

with 'XML::EPP::Common::Node';

subtype "${SCHEMA_PKG}::pwAuthInfoType"
	=> as __PACKAGE__;

1;

=head1 NAME

XML::EPP::Contact::E164 - implement e164Type

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="e164Type">
   <simpleContent>
     <extension base="contact:e164StringType">
       <attribute name="x" type="token"/>
     </extension>
   </simpleContent>
 </complexType>

=cut
