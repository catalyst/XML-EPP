#!/usr/bin/perl -w

use Test::More no_plan;
use strict;
use XML::Compare;
use FindBin qw($Bin);
use lib $Bin;
use RFCTypes;
BEGIN { use_ok("XML::EPP") }

  my $DCP = XML::EPP::DCP->new(
      access => "personalAndOther",  # only one value allowed
      statement => {                 # array of hash refs OK
          purpose => "prov",         # array of str OK
          recipient => "ours",       # array of str OK; see notes
          retention => "business",   # only one value allowed
      },
      expiry => "PY1",               # optional; specify policy expiry
     );

isa_ok($DCP, "XML::EPP::DCP",
       "test example on XML::EPP::DCP man page");

# not testing serialization as it's a bit of a can of worms to
# serialize a fragment atm.

BEGIN { use_ok("XML::EPP::Greeting") }

 use MooseX::TimestampTZ qw(gmtimestamptz);
 my $greeting = XML::EPP::Greeting->new(
     server_name => "myhostname",
     current_time => gmtimestamptz,
     services => "auto",
     dcp => {
         access => "personalAndOther",
         statement => {
             purpose => "prov",
             recipient => "ours",
             retention => "business",
         },
         expiry => "PY1",
     },
    );

isa_ok($greeting, "XML::EPP::Greeting",
       "test example on XML::EPP::Greeting man page");
