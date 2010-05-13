 package XML::EPP::Host::RQ;
 use Moose::Role;
 with qw(XML::EPP::Host);
 sub is_command { 1 }
 1;

=head1 NAME

XML::EPP::Host::RQ

=head1 SYNOPSIS

TODO

=head1 DESCRIPTION

This module provides a role for all the Host command requests.

=head2 XML Schema Definition

 <!--
 Child elements found in EPP commands.
 -->
 <element name="check" type="host:mNameType"/>
 <element name="create" type="host:createType"/>
 <element name="delete" type="host:sNameType"/>
 <element name="info" type="host:sNameType"/>
 <element name="update" type="host:updateType"/>

=cut
