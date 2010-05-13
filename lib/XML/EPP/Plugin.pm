
package XML::EPP::Plugin;

use Moose::Role;
use PRANG::Graph;

with 'PRANG::Graph';

requires 'is_command';

1;

=head1 NAME

XML::EPP::Plugin

=head1 SYNOPSIS

 package XML::EPP::Domain;
 use Moose::Role;
 with qw(XML::EPP::Plugin PRANG::Graph);
 sub is_command { 0|1 };
 1;

=head1 DESCRIPTION

Provides a role which can be incorporated to show that this element is a plugin.

=head2 XML Schema Definition

n/a

=cut
