
package XML::EPP::Domain::RS;

use Moose::Role;

with qw(XML::EPP::Domain);

sub is_command { 0 }

1;

=head1 NAME

XML::EPP::Domain::RS

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

This module provides a base class for all the Domain command responses.

=head2 XML Schema Definition

 <!--
 Child response elements.
 -->
 <element name="chkData" type="domain:chkDataType"/>
 <element name="creData" type="domain:creDataType"/>
 <element name="infData" type="domain:infDataType"/>
 <element name="panData" type="domain:panDataType"/>
 <element name="renData" type="domain:renDataType"/>
 <element name="trnData" type="domain:trnDataType"/>

=cut
