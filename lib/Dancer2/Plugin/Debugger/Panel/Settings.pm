package Dancer2::Plugin::Debugger::Panel::Settings;

=head1 NAME

Dancer2::Plugin::Debugger::Panel::Settings - add settings data to debugger panels

=cut

use Moo;
with 'Dancer2::Plugin::Debugger::Role::Panel';
use namespace::clean;

my $env_key = 'dancer2.debugger.settings';

sub BUILD {
    my $self = shift;

    $self->plugin->app->add_hook(
        Dancer2::Core::Hook->new(
            name => 'after_layout_render',
            code => sub {
                my $settings = $self->plugin->app->config;
                $self->plugin->app->request->env->{$env_key} = $settings;
            },
        )
    );
}

1;
