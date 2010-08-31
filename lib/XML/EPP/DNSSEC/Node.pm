package XML::EPP::DNSSEC::Node;

use Moose::Role;
use XML::EPP::Common;

sub xmlns {
	"urn:ietf:params:xml:ns:secDNS-1.1";
}

sub preferred_prefix {
	'secDNS';
}

1;

=head1 NAME

XML::EPP::DNSSEC::Node - role for nodes in the RFC5910 (DNSSEC) extension

=head1 SYNOPSIS

 package XML::EPP::DNSSEC::Foo;
 use Moose;
 use PRANG::Graph;

 ...

 with 'XML::EPP::DNSSEC::Node';

=head1 DESCRIPTION

Provides a role for all XML::EPP::DNSSEC::* elements to use.

=cut
