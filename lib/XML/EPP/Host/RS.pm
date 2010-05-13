package XML::EPP::Host::RS;
use Moose::Role;
with qw(XML::EPP::Host);
sub is_command { 0 }
1;

=head1 NAME

XML::EPP::Host::RS

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

This module provides a role for all the Host command responses.

=head2 XML Schema Definition

 <!--
 Child response elements.
 -->
 <element name="chkData" type="host:chkDataType"/>
 <element name="creData" type="host:creDataType"/>
 <element name="infData" type="host:infDataType"/>
 <element name="panData" type="host:panDataType"/>

=cut
