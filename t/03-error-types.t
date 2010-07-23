#!/usr/bin/perl -w

use Test::More no_plan;
use strict;
use XML::Compare;
use FindBin qw($Bin);
use lib $Bin;
use RFCTypes;
BEGIN { use_ok("XML::EPP") }

my $result = XML::EPP::Result->new(
	code => "2001",
       );
isa_ok($result, "XML::EPP::Result", "new XML::EPP::Result");

my $err = XML::EPP::Error->new(
	value => "foo",
	reason => "This is a message with extra whitespace at the end\n",
       );
isa_ok($err, "XML::EPP::Error",
       "new XML::EPP::Error with Str value/reason");

$result->add_error($err);

my $epp = XML::EPP->new(message => XML::EPP::Response->new(
	result => [ $result ],
	tx_id => XML::EPP::TrID->new(server_id => "lalala"),
       ));

my $xmlc = XML::Compare->new(
	ignore_xmlns => {
		"epp" => "urn:ietf:params:xml:ns:epp-1.0",
	},
       );

my $epp_xml = $epp->to_xml(1);
ok($xmlc->is_same( $epp_xml, <<'XML' ), "new error object")
<?xml version="1.0" encoding="UTF-8"?>
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
  <response>
    <result code="2001">
      <msg lang="en">Command syntax error</msg>
      <extValue>
        <value>foo</value>
        <reason lang="en">This is a message with extra whitespace at the end</reason>
      </extValue>
    </result>
    <trID>
      <svTRID>lalala</svTRID>
    </trID>
  </response>
</epp>
XML
	or diag("Error: ".$xmlc->error."\nXML:\n",$epp_xml);

my $parser = XML::LibXML->new;
my $doc = $parser->parse_string($epp_xml);

$err->value($doc->documentElement);

$epp_xml = $epp->to_xml(1);
ok($xmlc->is_same( $epp_xml, <<'XML' ), "error object w/LibXML nodes")
<?xml version="1.0" encoding="UTF-8"?>
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
  <response>
    <result code="2001">
      <msg lang="en">Command syntax error</msg>
      <extValue>
        <value><epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
  <response>
    <result code="2001">
      <msg lang="en">Command syntax error</msg>
      <extValue>
        <value>foo</value>
        <reason lang="en">This is a message with extra whitespace at the end</reason>
      </extValue>
    </result>
    <trID>
      <svTRID>lalala</svTRID>
    </trID>
  </response></epp>
</value>
        <reason lang="en">This is a message with extra whitespace at the end</reason>
      </extValue>
    </result>
    <trID>
      <svTRID>lalala</svTRID>
    </trID>
  </response>
</epp>
XML
	or diag("Error: ".$xmlc->error."\nXML:\n",$epp_xml);
