package Dancer2::Plugin::Debugger;

=head1 NAME

Dancer2::Plugin::Debugger

=cut

use strict;
use warnings;

use Carp;
use Module::Runtime qw/use_module/;
use Dancer2::Plugin;
with 'Dancer2::Debugger::Role::Core';

sub BUILD {
    my $plugin = shift;

    return unless $plugin->config->{enabled};

    my $panels = $plugin->config->{panels};

    croak "Dancer2::Plugin::Debugger enabled but no panels configured"
      unless $panels;

    croak "Dancer2::Plugin::Debugger panels config is not an array reference"
      unless ref($panels) eq 'ARRAY';

    foreach my $panel (@$panels) {
        if ( $panel =~ s/^Dancer2::// ) {
            $panel = __PACKAGE__ . "::Panel::$panel";
            use_module($panel)->new( plugin => $plugin );
        }
    }
}

1;
