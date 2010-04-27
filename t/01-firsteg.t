#!/usr/bin/perl -w

use Test::More no_plan;
use strict;
use XML::Compare;
use FindBin qw($Bin);
use lib $Bin;
use RFCTypes;
BEGIN { use_ok("XML::EPP") }

my $obj_create = XML::EPP->new(
	message => XML::EPP::Command->new(
		action => "create",
		argument => XML::EPP::SubCommand->new(
			payload => XML::EPP::Obj::create->new(
			       ),
		       ),
		client_id => "xml_epp_".time."_$$",
	       ),
       );

isa_ok($obj_create, "XML::EPP",
       "new obj create message");

my $xml_request = $obj_create->to_xml;

my $xmlc = XML::Compare->new(
	ignore => [ "//epp:clTRID/text()" ],
	ignore_xmlns => {
		"epp" => "urn:ietf:params:xml:ns:epp-1.0",
	},
       );

ok($xmlc->is_same( $xml_request, <<'XML' ), "new obj create")
<?xml version="1.0" encoding="utf-8"?>
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
  <command>
    <create>
      <greed:create xmlns:greed="urn:ietf:params:xml:ns:obj" />
    </create>
    <clTRID>...</clTRID>
  </command>
</epp>
XML
	or diag("Error: ".$xmlc->error);
