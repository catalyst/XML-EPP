package XML::EPP::Contact::Disclose;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

with 'XML::EPP::Contact::Node';

my $PKG = __PACKAGE__;

has_element 'name' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Contact::Location]',
	xml_min => 0,
	xml_max => 2,
	;

has_element 'org' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Contact::Location]',
	xml_min => 0,
	xml_max => 2,
	;

has_element 'addr' =>
	is => 'ro',
	isa => 'ArrayRef[XML::EPP::Contact::Location]',
	xml_min => 0,
	xml_max => 2,
	;

has_element 'voice' =>
	is => 'ro',
	isa => 'Bool',
	required => 0,
	;

has_element 'fax' =>
	is => 'ro',
	isa => 'Bool',
	required => 0,
	;

has_element 'email' =>
	is => 'ro',
	isa => 'Bool',
	required => 0,
	;

has_attr 'flag' =>
	is => 'ro',
	isa => 'PRANG::XMLSchema::boolean'
	;

=head2 XML Schema Definition

 <complexType name="discloseType">
   <sequence>
     <element name="name" type="contact:intLocType"
      minOccurs="0" maxOccurs="2"/>
     <element name="org" type="contact:intLocType"
      minOccurs="0" maxOccurs="2"/>
     <element name="addr" type="contact:intLocType"
      minOccurs="0" maxOccurs="2"/>
     <element name="voice" minOccurs="0"/>
     <element name="fax" minOccurs="0"/>
     <element name="email" minOccurs="0"/>
   </sequence>
   <attribute name="flag" type="boolean" use="required"/>
 </complexType>

=cut
