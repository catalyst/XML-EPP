package XML::EPP::Domain::Check::Status;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Domain::Node';

use XML::EPP::Domain::Check::Name;
has_element 'name_status' =>
        is => 'ro',
        isa => 'XML::EPP::Domain::Check::Name',
        xml_nodeName => 'name',
        handles => [qw(available name)],
	required => 1,
        ;

has_element 'reason' =>
        is => 'ro',
        isa => 'XML::EPP::Common::Reason',
        predicate => 'has_reason',
        xmlns => &xmlns,
        ;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="checkType">
   <sequence>
     <element name="name" type="host:checkNameType"/>
     <element name="reason" type="eppcom:reasonType"
      minOccurs="0"/>
   </sequence>
 </complexType>

=cut
