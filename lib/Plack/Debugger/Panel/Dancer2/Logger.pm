package Plack::Debugger::Panel::Dancer2::Logger;

use strict;
use warnings;

use parent 'Plack::Debugger::Panel';

sub new {
    my $class = shift;
    my %args = @_ == 1 && ref $_[0] eq 'HASH' ? %{ $_[0] } : @_;

    $args{title} ||= 'Dancer2::Logger';

    $args{'formatter'} ||= 'generic_data_formatter';

    $args{'after'} = sub {
        my ( $self, $env, $resp ) = @_;

        my $env_key = 'dancer2.debugger.logger';

        my $logs = delete $env->{$env_key};
        return unless $logs;

        $self->set_result( $logs );
    };

    $class->SUPER::new( \%args );
}

1;
