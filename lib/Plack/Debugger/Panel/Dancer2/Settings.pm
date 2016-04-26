package Plack::Debugger::Panel::Dancer2::Settings;

use strict;
use warnings;

use parent 'Plack::Debugger::Panel';

sub new {
    my $class = shift;
    my %args = @_ == 1 && ref $_[0] eq 'HASH' ? %{ $_[0] } : @_;

    $args{title} ||= 'Dancer2::Settings';

    $args{'formatter'} ||= 'generic_data_formatter';

    $args{'after'} = sub {
        my ( $self, $env, $resp ) = @_;

        my $env_key = 'dancer2.debugger.settings';

        my $session = delete $env->{$env_key};
        return unless $session;

        $self->set_result( $session );
    };

    $class->SUPER::new( \%args );
}

1;
