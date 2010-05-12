package XML::EPP::Host::Check;
use Moose;
use PRANG::Graph;
sub root_element { "check" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	'XML::EPP::Host::List';

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...
