
package XML::EPP::Contact::RS;

use Moose::Role;

with qw(XML::EPP::Contact);

sub is_command { 0 }

1;

=head1 NAME

XML::EPP::Contact::RS

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

This module provides a role for all the Contact command responses.

=head2 XML Schema Definition

 <!--
 Child response elements.
 -->
 <element name="chkData" type="contact:chkDataType"/>
 <element name="creData" type="contact:creDataType"/>
 <element name="infData" type="contact:infDataType"/>
 <element name="panData" type="contact:panDataType"/>
 <element name="trnData" type="contact:trnDataType"/>

=cut
