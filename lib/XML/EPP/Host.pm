 package XML::EPP::Host;
 use Moose::Role;
 use XML::EPP::Host::Check;
 use XML::EPP::Host::Delete;
 use XML::EPP::Host::Info;
 with qw(XML::EPP::Plugin PRANG::Graph);
 1;
