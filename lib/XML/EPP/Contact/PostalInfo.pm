package XML::EPP::Contact::PostalInfo;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

with 'XML::EPP::Contact::Node';

my $PKG = __PACKAGE__;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::postalLineType',
	;

has_element 'org' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::optPostalLineType',
	required => 0,
	;

use XML::EPP::Contact::Addr;
has_element 'addr' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::Addr',
	required => 1,
	;

has_attr 'type' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::postalInfoEnumType',
	;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="postalInfoType">
   <sequence>
     <element name="name" type="contact:postalLineType"/>
     <element name="org" type="contact:optPostalLineType"
      minOccurs="0"/>
     <element name="addr" type="contact:addrType"/>
   </sequence>
   <attribute name="type" type="contact:postalInfoEnumType"
    use="required"/>
 </complexType>

=cut
