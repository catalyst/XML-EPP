
package XML::EPP::Contact::RQ;

use Moose::Role;

with qw(XML::EPP::Contact);

sub is_command { 1 }

1;

=head1 NAME

XML::EPP::Contact::RQ

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

This module provides a role for all the Contact command requests.

=head2 XML Schema Definition

 <!--
 Child elements found in EPP commands.
 -->
 <element name="check" type="contact:mIDType"/>
 <element name="create" type="contact:createType"/>
 <element name="delete" type="contact:sIDType"/>
 <element name="info" type="contact:authIDType"/>
 <element name="transfer" type="contact:authIDType"/>
 <element name="update" type="contact:updateType"/>

=cut
