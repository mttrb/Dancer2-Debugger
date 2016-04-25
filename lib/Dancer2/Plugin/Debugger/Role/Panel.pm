package Dancer2::Plugin::Debugger::Role::Panel;

use Dancer2::Core::Types;
use Moo::Role;

has plugin => (
    is       => 'ro',
    isa      => InstanceOf ['Dancer2::Plugin::Debugger'],
    required => 1,
);

sub get {
    my ( $self, $key ) = @_;
    $self->plugin->cache->get_and_remove($key);
}

sub set {
    my ( $self, $key, $value ) = @_;
    $self->plugin->cache->set( $key, $value );
}

1;
