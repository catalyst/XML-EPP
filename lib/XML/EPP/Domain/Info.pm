package XML::EPP::Domain::Info;

use Moose;
use PRANG::Graph;

sub root_element { 'info' }

with 'XML::EPP::Domain::RQ', 'XML::EPP::Domain::Node';

use XML::EPP::Domain::Info::Name;

has_element 'name' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::Info::Name',
	;

has_element 'auth_info' =>
	is => 'ro',
	isa => 'XML::EPP::Domain::AuthInfo',
	xml_required => 0,
	xml_nodeName => 'authInfo',
	predicate => 'has_auth_info',
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
Child elements of the <info> command.
-->
<complexType name="infoType">
 <sequence>
   <element name="name" type="domain:infoNameType"/>
   <element name="authInfo" type="domain:authInfoType"
    minOccurs="0"/>
 </sequence>
</complexType>

=cut
