
package XML::EPP::Common::Reason;

use Moose;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
use PRANG::Graph;

our $SCHEMA_PKG = "XML::EPP::Common";

has_attr 'lang' =>
	is => "rw",
	isa => "PRANG::XMLSchema::language",
	predicate => "has_lang",
	;

has_element 'content' =>
	is => "rw",
	isa => "${SCHEMA_PKG}::reasonBaseType",
	xml_nodeName => "",
	;

with "${SCHEMA_PKG}::Node";

subtype "${SCHEMA_PKG}::reasonType"
	=> as __PACKAGE__;

1;

=head NAME

XML::EPP::Common::Reason

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

TODO

=head2 XML Schema Definition

 <!--
 <check> response types.
 -->
 <complexType name="reasonType">
   <simpleContent>
     <extension base="eppcom:reasonBaseType">
       <attribute name="lang" type="language"/>
     </extension>
   </simpleContent>
 </complexType>

=cut
