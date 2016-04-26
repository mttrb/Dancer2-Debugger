# NAME

Dancer2::Debugger - Dancer2 panels for Plack::Debugger

# VERSION

0.001

# SYNOPSIS

In your .psgi file:

    #!/usr/bin/env perl

    use strict;
    use warnings;
    use FindBin;
    use lib "$FindBin::Bin/../lib";

    use Plack::Builder;

    use Dancer2::Debugger;
    my $debugger = Dancer2::Debugger->new;

    use MyApp;
    my $app = MyApp->to_app;

    builder {
        $debugger->mount;
        mount '/' => builder {
            $debugger->enable;
            $app;
        }
    };

In environments/development.yml file:

    plugins:
        Debugger:
            enabled: 1

In MyApp.pm:

    use Dancer2::Plugin::Debugger

# DESCRIPTION

[Dancer2::Debugger](https://metacpan.org/pod/Dancer2::Debugger) makes using the excellent [Plack::Debugger](https://metacpan.org/pod/Plack::Debugger) much more
convenient and in addition provides a number of Dancer2 panels.

Current panels included with this distribution:

- [Plack::Debugger::Panel::Dancer2::Logger](https://metacpan.org/pod/Plack::Debugger::Panel::Dancer2::Logger)
- [Plack::Debugger::Panel::Dancer2::Routes](https://metacpan.org/pod/Plack::Debugger::Panel::Dancer2::Routes)
- [Plack::Debugger::Panel::Dancer2::Session](https://metacpan.org/pod/Plack::Debugger::Panel::Dancer2::Session)
- [Plack::Debugger::Panel::Dancer2::TemplateVariables](https://metacpan.org/pod/Plack::Debugger::Panel::Dancer2::TemplateVariables)

Some of the debugger panels make use of collectors which are imported into
your [Dancer2](https://metacpan.org/pod/Dancer2) app using [Dancer2::Plugin::Debugger](https://metacpan.org/pod/Dancer2::Plugin::Debugger) which is also 
included in this distribution.

# ATTRIBUTES

## app

Instantiated [Plack::App::Debugger](https://metacpan.org/pod/Plack::App::Debugger) object.

## data\_dir

See ["data\_dir" in Plack::Debugger::Storage](https://metacpan.org/pod/Plack::Debugger::Storage#data_dir).

Defaults to `debugger_panel` in the system temp directory (usually `/tmp`
on Linux/UNIX systems).

Attempts to create the directory if it does not exist.

## debugger

Instantiated [Plack::Debugger](https://metacpan.org/pod/Plack::Debugger) object.

## deserializer

See ["deserializer" in Plack::Debugger::Storage](https://metacpan.org/pod/Plack::Debugger::Storage#deserializer).

Defaults to the value of ["serializer"](#serializer).

## filename\_fmt

See ["filename\_fmt" in Plack::Debugger::Storage](https://metacpan.org/pod/Plack::Debugger::Storage#filename_fmt).

Defaults to `%s.json`.

## panels

Array reference of panel class names to load. Defaults to all classes
found in `@INC` under [Plack::Debugger::Panel](https://metacpan.org/pod/Plack::Debugger::Panel).

## panel\_objects

Imported and instantiated panel objects.

## serializer

See ["serializer" in Plack::Debugger::Storage](https://metacpan.org/pod/Plack::Debugger::Storage#serializer).

Defaults to `JSON::MaybeXS->new( convert_blessed => 1, utf8 => 1 )`

## storage

Instantiated [Plack::Debugger::Storage](https://metacpan.org/pod/Plack::Debugger::Storage) object.

# METHODS

## enable

Convenience method for use in psgi file which runs the following methods:

["make\_injector\_middleware" in Plack::App::Debugger](https://metacpan.org/pod/Plack::App::Debugger#make_injector_middleware) and
["create\_middleware" in Plack::Debugger](https://metacpan.org/pod/Plack::Debugger#create_middleware).

## mount

Convenience method for use in psgi file to mount [Plack::App::Debugger](https://metacpan.org/pod/Plack::App::Debugger).

# SEE ALSO

[Plack::Debugger](https://metacpan.org/pod/Plack::Debugger), [Plack::Debugger::Panel::Dancer2::Version](https://metacpan.org/pod/Plack::Debugger::Panel::Dancer2::Version)

# AUTHORS

Peter Mottram (SysPete), `peter@sysnix.com`

# LICENSE AND COPYRIGHT

Copyright 2016 Peter Mottram (SysPete).

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.
