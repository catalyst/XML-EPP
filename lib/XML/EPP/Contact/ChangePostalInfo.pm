package XML::EPP::Contact::ChangePostalInfo;

use Moose;
use PRANG::Graph;
with 'XML::EPP::Contact::Node';

use PRANG::XMLSchema::Types;

#has_element 'name' =>
#	is => 'ro',
#	isa => 'XML::EPP::Contact::postalLineType',
#	required => 0,
#	;

has_element 'org' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::optPostalLineType',
	required => 0,
	;

use XML::EPP::Contact::Addr;
has_element 'addr' =>
	is => 'ro',
	isa => 'XML::EPP::Contact::Addr',
	xml_required => 0,
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

 <complexType name="chgPostalInfoType">
   <sequence>
     <element name="name" type="contact:postalLineType"
      minOccurs="0"/>
     <element name="org" type="contact:optPostalLineType"
      minOccurs="0"/>
     <element name="addr" type="contact:addrType"
      minOccurs="0"/>
   </sequence>
   <attribute name="type" type="contact:postalInfoEnumType"
    use="required"/>
 </complexType>

=cut
