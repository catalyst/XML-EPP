#!/usr/bin/perl

use Test::More qw(no_plan);
use XML::EPP::Host;

my $create = XML::EPP::Host::Create->new(
	name => "ns1.example.com",
	addr => [
		"192.0.2.2",
		"192.0.2.29",
		{
			ip => "v6",
			value => "1080:0:0:0:8:800:200C:417A",
		},
	       ],
       );

is(scalar(@{ $create->addr }), 3, "::Address all present");
is($create->addr->[1]->value, "192.0.2.29",
   "::Address coerce from Str");
is($create->addr->[2]->ip, "v6", "::Address coerce from HashRef");

1;
