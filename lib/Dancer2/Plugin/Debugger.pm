package Dancer2::Plugin::Debugger;

=head1 NAME

Dancer2::Plugin::Debugger

=cut

use strict;
use warnings;

use Carp;
use Module::Find qw/findsubmod/;
use Module::Runtime qw/use_module/;
use Dancer2::Plugin;
with 'Dancer2::Debugger::Role::Core';

sub BUILD {
    my $plugin = shift;

    return unless $plugin->config->{enabled};

    my @panels = findsubmod Dancer2::Plugin::Debugger::Panel;

    foreach my $panel (@panels) {
        use_module($panel)->new( plugin => $plugin );
    }
}

1;
