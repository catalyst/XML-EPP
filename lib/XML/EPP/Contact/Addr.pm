package XML::EPP::Contact::Addr;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

with 'XML::EPP::Contact::Node';

my $PKG = __PACKAGE__;

has_element 'street' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Contact::optPostalLineType]',
	xml_min => 0,
	xml_max => 3,
	;

has_element 'city' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::postalLineType',
	;

has_element 'sp' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::optPostalLineType',
	required => 0,
	;

has_element 'pc' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::optPostalLineType',
	required => 0,
	;

has_element 'cc' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::ccType',
	;

1;

=head1 NAME

XML::EPP::Contact::Addr - implement host:chgType

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="addrType">
   <sequence>
     <element name="street" type="contact:optPostalLineType"
      minOccurs="0" maxOccurs="3"/>
     <element name="city" type="contact:postalLineType"/>
     <element name="sp" type="contact:optPostalLineType"
      minOccurs="0"/>
     <element name="pc" type="contact:pcType"
      minOccurs="0"/>
     <element name="cc" type="contact:ccType"/>
   </sequence>
 </complexType>

=cut
