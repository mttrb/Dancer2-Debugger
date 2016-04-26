package Dancer2::Plugin::Debugger;

=head1 NAME

Dancer2::Plugin::Debugger

=cut

use strict;
use warnings;

use Module::Find qw/findsubmod/;
use Module::Runtime qw/use_module/;
use Dancer2::Plugin;

=head1 CONFIGURATION

    plugins:
        Debugger:
            enabled: 1

=head2 enabled

Whether plugin is enabled. Defaults to false.

=head1 METHODS

=head2 BUILD

Load all C<Dancer2::Plugin::Debugger::Panel::*> classes if L</enabled> is true.

=cut

on_plugin_import {
    my $plugin = shift;

    return unless $plugin->config->{enabled};

    my @panels = findsubmod Dancer2::Plugin::Debugger::Panel;

    foreach my $panel (@panels) {
        use_module($panel)->new( plugin => $plugin );
    }
};

register_plugin;

1;
