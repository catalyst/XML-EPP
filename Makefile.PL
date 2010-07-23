#
# Copyright (C) 2009  NZ Registry Services
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the Artistic License 2.0 or later.  You should
# have received a copy of the Artistic License the file COPYING.txt.
# If not, see <http://www.perlfoundation.org/artistic_license_2_0>

use inc::Module::Install;

name            ("XML-EPP");
abstract        ("An implementation of the EPP XML language");
author          ("Catalyst SRS Team <team-srs\@catalyst.net.nz>");
version_from    ("lib/XML/EPP.pm");
license         ('artistic');

requires        ("perl" => 5.010);
requires        ("Moose" => 0.54);
requires        ("PRANG" => "0.10_03");
requires        ("MooseX::Timestamp" => 0);
requires        ("MooseX::StrictConstructor" => 0);
test_requires   ("XML::Compare" => 0.04);
test_requires   ("Scriptalicious" => 0);
test_requires   ("YAML" => 0);

&WriteAll;
