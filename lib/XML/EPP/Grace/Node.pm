package XML::EPP::Grace::Node;

use Moose::Role;
use XML::EPP::Common;

sub xmlns {
	"urn:ietf:params:xml:ns:rgp-1.0";
}

1;

=head1 NAME

XML::EPP::Grace::Node - role for nodes in the RFC3915 (RGP) extension

=head1 SYNOPSIS

 package XML::EPP::Grace::Foo;
 use Moose;
 use PRANG::Graph;

 ...

 with 'XML::EPP::Grace::Node';

=head1 DESCRIPTION

Provides a role for all XML::EPP::Grace::* elements to use.

=cut
