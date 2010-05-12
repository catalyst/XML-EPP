package XML::EPP::Host::Check::Response;

use Moose;
use PRANG::Graph;
sub root_element { "chkData" }

with
	'XML::EPP::Host::RS',
	'XML::EPP::Host::Node',
	;

use XML::EPP::Host::Check::Status;
has_element 'items' =>
	is => "ro",
	isa => "ArrayRef[XML::EPP::Host::Check::Status]",
	xml_nodeName => "cd",
	;

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="chkDataType">
   <sequence>
     <element name="cd" type="host:checkType"
      maxOccurs="unbounded"/>
   </sequence>
 </complexType>

=cut
