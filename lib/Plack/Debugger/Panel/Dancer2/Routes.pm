package Plack::Debugger::Panel::Dancer2::Routes;

use strict;
use warnings;

use parent 'Plack::Debugger::Panel';

sub new {
    my $class = shift;
    my %args = @_ == 1 && ref $_[0] eq 'HASH' ? %{ $_[0] } : @_;

    $args{title} ||= 'Dancer2::Routes';
    $args{'formatter'} ||= 'generic_data_formatter';

    $args{'after'} = sub {
        my ( $self, $env, $resp ) = @_;

        my $env_key = 'dancer2.debugger.routes';

        my $routes = delete $env->{$env_key};
        return unless $routes;

        $self->set_result( $routes );
    };

    $class->SUPER::new( \%args );
}

1;
