package Dancer2::Plugin::Debugger::Panel::TemplateVariables;

=head1 NAME

Dancer2::Plugin::Debugger::Panel::TemplateVariables - add template tokens to debugger panels

=cut

use Moo;
with 'Dancer2::Plugin::Debugger::Role::Panel';
use namespace::clean;

sub BUILD {
    my $self = shift;

    $self->plugin->app->add_hook(
        Dancer2::Core::Hook->new(
            name => 'before_layout_render',
            code => sub {
                my $tokens = shift;
                my $result = $self->plugin->set_encoded(
                    template_variables => $tokens
                );
                if ( !$result ) {
                    $self->plugin->app->log( 'warning',
                        "fastmmap set failed - value too large?" );
                }
            },
        )
    );
}

1;
