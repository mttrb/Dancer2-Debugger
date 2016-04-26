package Dancer2::Plugin::Debugger::Panel::Session;

=head1 NAME

Dancer2::Plugin::Debugger::Panel::Session - add session data to debugger panels

=cut

use Moo;
with 'Dancer2::Plugin::Debugger::Role::Panel';
use namespace::clean;

my $env_key = 'dancer2.debugger.session';

sub BUILD {
    my $self = shift;

    $self->plugin->app->add_hook(
        Dancer2::Core::Hook->new(
            name => 'after_layout_render',
            code => sub {
                my $session = $self->plugin->app->session->data;
                $self->plugin->app->request->env->{$env_key} = $session;
            },
        )
    );
}

1;
