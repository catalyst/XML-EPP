package XML::EPP::Domain::NS::List;

use Moose;
use PRANG::Graph;

sub root_element { 'infData' }

use XML::EPP::Domain::NS;
has_element 'ns' =>
    is => 'ro',
    # XXX: This would be a more correct definition (from the spec) but
    # PRANG doesn't yet let you do this.
    # isa => 'ArrayRef[XML::EPP::Domain::NS]|ArrayRef[XML::EPP::Common::labelType]',
    # So instead we do this:
    isa => 'ArrayRef[XML::EPP::Domain::NS|XML::EPP::Common::labelType]',
    xml_min => 0,
    xml_nodeName => {
        hostAttr => 'XML::EPP::Domain::NS',
        hostObj  => 'XML::EPP::Common::labelType',
    },
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
 Name servers are either host objects or attributes.
 -->
 <complexType name="nsType">
  <choice>
    <element name="hostObj" type="eppcom:labelType"
     maxOccurs="unbounded"/>
    <element name="hostAttr" type="domain:hostAttrType"
     maxOccurs="unbounded"/>
  </choice>
 </complexType>

=cut
