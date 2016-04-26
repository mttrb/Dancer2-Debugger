# NAME

Dancer2::Debugger

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

Defaults to ["serializer"](#serializer).

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

sub enable {
    my $self = shift;
    Plack::Builder::enable $self->app->make\_injector\_middleware;
    Plack::Builder::enable $self->debugger->make\_collector\_middleware;
}

## mount

Convenience method for use in psgi file to mount [Plack::App::Debugger](https://metacpan.org/pod/Plack::App::Debugger).

# AUTHORS

Peter Mottram (SysPete), `peter@sysnix.com`

# LICENSE AND COPYRIGHT

Copyright 2016 Peter Mottram (SysPete).

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.
