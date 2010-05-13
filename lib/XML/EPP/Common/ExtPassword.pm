
package XML::EPP::Common::ExtPassword;

use Moose::Role;
use MooseX::Method::Signatures;
use Moose::Util::TypeConstraints;
our $SCHEMA_PKG = "XML::EPP::Common";

# <any namespace="##other"> maps to MessageNode; it's a free for all!

subtype "${SCHEMA_PKG}::extAuthInfoType"
	=> as __PACKAGE__;

1;

=head1 NAME

XML::EPP::Common::ExtPassword

=head1 SYNOPSIS

...

=head1 DESCRIPTION

...

=head2 XML Schema Definition

  <complexType name="extAuthInfoType">
    <sequence>
      <any namespace="##other"/>
    </sequence>
  </complexType>

=cut
