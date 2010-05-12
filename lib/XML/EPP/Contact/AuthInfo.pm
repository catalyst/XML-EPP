package XML::EPP::Contact::AuthInfo;

use Moose;
use PRANG::Graph;
use Moose::Util::TypeConstraints;

with 'XML::EPP::Contact::Node';

my $PKG = __PACKAGE__;

subtype "${PKG}::choice0"
	=> as 'XML::EPP::Common::Password|XML::EPP::Common::ExtPassword'
	;

has_element 'pw' =>
	is => "rw",
	isa => "${PKG}::choice0",
	xml_nodeName => {
		"pw" => "XML::EPP::Common::Password",
		"ext" => "XML::EPP::Common::ExtPassword",
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

 <complexType name="authInfoType">
   <choice>
     <element name="pw" type="eppcom:pwAuthInfoType"/>
     <element name="ext" type="eppcom:extAuthInfoType"/>
   </choice>
 </complexType>

=cut
