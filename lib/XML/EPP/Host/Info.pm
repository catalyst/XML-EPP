package XML::EPP::Host::Info;
use Moose;
use PRANG::Graph;
sub root_element { "info" }

with
	'XML::EPP::Host::RQ',
	'XML::EPP::Host::Node',
	'XML::EPP::Host::Item';

1;

=head1 NAME

? - implement ?

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

...
