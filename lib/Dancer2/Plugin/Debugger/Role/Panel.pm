package Dancer2::Plugin::Debugger::Role::Panel;

use Dancer2::Core::Types;
use Moo::Role;

has plugin => (
    is       => 'ro',
    isa      => InstanceOf ['Dancer2::Plugin::Debugger'],
    required => 1,
);

1;
