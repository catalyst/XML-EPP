package XML::EPP::Domain::Period;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

has_element 'value' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::pLimitType',
	xml_nodeName => ''
	;

has_attr 'unit' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::pUnitType',
	coerce => 1,
	;

sub months {
	my $self = shift;
	if ( ($self->unit||"") eq "y" ) {
		$self->value * 12;
	}
	else {
		$self->value;
	}
}

1;

=head1 NAME

XML::EPP::Domain::Period - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <complexType name="periodType">
  <simpleContent>
    <extension base="domain:pLimitType">
      <attribute name="unit" type="domain:pUnitType"
       use="required"/>
    </extension>
  </simpleContent>
 </complexType>

=cut
