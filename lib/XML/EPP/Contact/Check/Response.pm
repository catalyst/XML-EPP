package XML::EPP::Contact::Check::Response;

use Moose;
use PRANG::Graph;

sub root_element { 'chkData' }

with
        'XML::EPP::Contact::RS',
        'XML::EPP::Contact::Node',
        ;

use XML::EPP::Contact::Check::Status;

has_element 'items' =>
        is => 'ro',
        isa => 'ArrayRef[XML::EPP::Contact::Check::Status]',
        xml_nodeName => 'cd',
        ;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <!--
 <check> response elements.
 -->
 <complexType name="chkDataType">
   <sequence>
     <element name="cd" type="contact:checkType"
      maxOccurs="unbounded"/>
   </sequence>
 </complexType>

=cut
