package XML::EPP::Contact::Check::Status;

use Moose;
use PRANG::Graph;

with 'XML::EPP::Contact::Node';

use XML::EPP::Contact::Check::ID;
has_element 'id_status' =>
        is => 'ro',
        isa => 'ArrayRef[XML::EPP::Contact::Check::ID]',
        xml_nodeName => 'id',
        handles => [qw(available id)],
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
     <element name="id" type="contact:checkIDType"/>
     <element name="reason" type="eppcom:reasonType"
      minOccurs="0"/>
   </sequence>
 </complexType>

=cut
