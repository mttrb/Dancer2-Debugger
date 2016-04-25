package Dancer2::Debugger;

use 5.006;
use strict;
use warnings;

=head1 NAME

Dancer2::Debugger

=head1 VERSION

0.001

=cut

our $VERSION = '0.001';

use Dancer2;
use Moo;

has base_url => (
    is => 'ro',
);

has plugin_config => (
    is => 'ro',
    default => sub { config->{plugins}->{Debugger} },
);

use DDP;
sub BUILD {
    my $self = shift;
    p $self->plugin_config;
}

=head1 SYNOPSIS

In your .psgi file:

    #!/usr/bin/env perl

    use strict;
    use warnings;
    use FindBin;
    use lib "$FindBin::Bin/../lib";

    use Plack::Builder;

    use Dancer2::Debugger;
    use MyApp;

    my $app = MyApp->to_app;
    my $debugger_app = Dancer2::Debugger->to_app;

    builder {
    };

=cut

1;
