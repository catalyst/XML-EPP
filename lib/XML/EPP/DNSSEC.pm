package XML::EPP::DNSSEC;
use Moose::Role;

with qw(XML::EPP::Extension::Type PRANG::Graph);

use Moose::Util::TypeConstraints;
use PRANG::XMLSchema::Types;
use XML::EPP::Common;

use XML::EPP::DNSSEC::Create;
use XML::EPP::DNSSEC::InfoResponse;

1;
