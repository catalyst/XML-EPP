#!/usr/bin/perl
## ----------------------------------------------------------------------------
# This program is designed to create some POD for each of the XML::EPP classes
# contained in this distribution.
#
# It will create a new *.pod file for every XML/EPP/*.pm file it sees in %INC.
#
# Run as:
#    $ ./make-docs.pl
## ----------------------------------------------------------------------------

use strict;
use warnings;

use Data::Dumper;
use Pod::POM;
use XML::EPP::Domain;
use XML::EPP::Host;
use XML::EPP::Contact;
use File::Slurp;

my $parser = Pod::POM->new();

my @module_files = grep { m{^XML/EPP/} } keys %INC;

foreach my $file ( @module_files ) {
    print qq{--- $file\n};
    my $module_name = make_module_name($file);
    my $pom = $parser->parse("lib/$file");

    # loop through all the content and print it out as applicable
    my $seen = {};
    my $pod;
    # get the docs in the following order
    foreach my $title ( 'NAME', 'SYNOPSIS', 'DESCRIPTION' ) {
        my $section = get_section($pom, 1, $title);
        if ( defined $section ) {

            # for 'DESCRIPTION' check it has an 'XML Schema Definition'
            if ( $title eq 'DESCRIPTION' ) {
                $pod .= make_description_section($section);
            }
            else {
                $pod .= $section;
            }
        }
        else {
            print qq{Warning: Couldn't find any "=head1 $title" section\n};
            $pod .= "=head1 $title\n\n" . ($title eq 'NAME' ? $module_name : 'TO WRITE!') . "\n\n";
        }
    }

    # now do the XML Schema Attributes and Elements
    $pod .= "=head2 Attributes\n\n";
    $pod .= make_attribute_section($module_name);
    $pod .= "=head2 Elements\n\n";
    $pod .= make_element_section($module_name);

    # SEE ALSO
    $pod .= "=head1 SEE ALSO\n\n";
    $pod .= "ToMake\n\n";

    # AUTHOR AND LICENSE
    $pod .= "=head1 AUTHOR AND LICENSE\n\n";
    $pod .= <<'EOF';
Development commissioned by NZ Registry Services, and carried out by
Catalyst IT - L<http://www.catalyst.net.nz/>

Copyright 2009, 2010, NZ Registry Services.  This module is licensed
under the Artistic License v2.0, which permits relicensing under other
Free Software licenses.

EOF

    # finish the pod off
    $pod .= "=cut\n\n";

    # write out this file
    my $outfile = "lib/$file";
    $outfile =~ s{ \.pm \z }{.pod}gxms;
    write_file($outfile, $pod);
}

## ----------------------------------------------------------------------------

sub get_section {
    my ($pom, $level, $name) = @_;
    die "need a $level" unless defined $level;

    my $method_name = "head$level";
    foreach my $head ( $pom->$method_name ) {
        if ( $head->title eq $name ) {
            return $head;
        }
    }
    return;
}

sub make_description_section {
    my ($pom) = @_;

    my $pod = "=head1 DESCRIPTION\n\n";

    # firstly, print out all the sections up until the first head (of some sort)
    my @sections = $pom->content();
    foreach my $section ( @sections ) {
        last if $section->type() ne 'text';
        $pod .= $section;
    }

    my $section = get_section($pom, 2, 'XML Schema Definition');
    $pod .= "=head2 XML Schema Definition\n\n";
    if ( defined $section ) {
        unless ( $section->content =~ m{ \A \s }xms ) {
            print qq{Warning: "=head2 XML Schema Definition" doesn't begin with a space\n};
        }
        $pod .= $section->content;
    }
    else {
        print qq{Warning: Couldn't find a "=head2 XML Schema Definition" inside 'DESCRIPTION'\n};
        $pod .= "TO WRITE\n\n";
    }
    return $pod;
}

sub make_attribute_section {
    my ($module_name) = @_;

    # my $module_name = make_module_name($file);

    my @attrs;
    eval {
        @attrs = grep { $_->does('PRANG::Graph::Meta::Attr') } $module_name->meta->get_all_attributes;
    };
    if ( $@ ) {
        return "Failed to find any attributes on this element.\n\n";
    }
    unless ( @attrs ) {
        return "There are no xml attributes on this element.\n\n";
    }

    my $pod = "=over\n\n";
    foreach my $attr ( @attrs ) {
        $pod .= "=item B<$attr->{name}>\n\n";

        $pod .= "This attribute is of type '$attr->{isa}' and is ";
        $pod .= $attr->{xml_required} ? "required." : "not required.";
        $pod .= "  It corresponds to the XML element of name '$attr->{xml_nodeName}'."
            if $attr->{xml_nodeName};
        $pod .= "\n\n";
    }
    $pod .= "=back\n\n";

    return $pod;
}

sub make_element_section {
    my ($module_name) = @_;

    # my $module_name = make_module_name($file);

    my @elems;
    eval {
        @elems = grep { $_->does('PRANG::Graph::Meta::Element') } $module_name->meta->get_all_attributes;
    };
    if ( $@ ) {
        return "Failed to find any child elements on this element.\n\n";
    }

    my $pod = "=over\n\n";
    foreach my $elem ( @elems ) {
        $pod .= "=item B<$elem->{name}>\n\n";

        $pod .= "This element is of type '$elem->{isa}' and is ";
        $pod .= $elem->{xml_required} ? "required." : "not required.";
        $pod .= "  It corresponds to the XML element of name '$elem->{xml_nodeName}'."
            if $elem->{xml_nodeName};

        # do min/max
        $pod .= "  It should be provided at least $elem->{xml_min} times."
            if $elem->{xml_min};
        $pod .= "  It can be provided at most $elem->{xml_max} times."
            if $elem->{xml_max};

        # end this section
        $pod .= "\n\n";
    }
    $pod .= "=back\n\n";

    return $pod;
}

sub make_module_name {
    my ($filename) = @_;
    $filename =~ s{\/}{::}gmxs;
    $filename =~ s{\.pm \z }{}gmxs;
    return $filename;
}

## ----------------------------------------------------------------------------
