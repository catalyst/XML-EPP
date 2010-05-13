
package XML::EPP::Domain::RQ;

use Moose::Role;

with qw(XML::EPP::Domain);

sub is_command { 1 }

1;

=head1 NAME

XML::EPP::Domain::RQ

=head1 SYNOPSIS

This module provides a role for all the Domain command request.

=head1 DESCRIPTION

...

=head2 XML Schema Definition

 <!--
 Child elements found in EPP commands.
 -->
 <element name="check" type="domain:mNameType"/>
 <element name="create" type="domain:createType"/>
 <element name="delete" type="domain:sNameType"/>
 <element name="info" type="domain:infoType"/>
 <element name="renew" type="domain:renewType"/>
 <element name="transfer" type="domain:transferType"/>
 <element name="update" type="domain:updateType"/>

=cut
