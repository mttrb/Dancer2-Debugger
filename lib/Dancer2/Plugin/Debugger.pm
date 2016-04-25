package Dancer2::Plugin::Debugger;

=head1 NAME

Dancer2::Plugin::Debugger

=cut

use strict;
use warnings;

use Cache::FastMmap;
use Carp;
use File::Spec;
use Module::Find qw/findsubmod/;
use Module::Runtime qw/use_module/;
use Sereal::Decoder;
use Sereal::Encoder;
use Dancer2::Plugin;

=head1 ATTRIBUTES

=head2 enabled

Whether plugin is enabled. Set from config.

=cut

has enabled => (
    is          => 'ro',
    from_config => sub { 0 },
);

=head2 cache_file

The location of the shared cached file used to pass data between the collectors
within the Dancer2 plugin and the L<Plack::Debugger> panels.

Defaults to C<dancer2_debugger.mmap> inside L<Dancer2::Config/appdir>.

=cut

has cache_file => (
    is      => 'ro',
    default => sub {
        my $plugin = shift;
        my $path = $plugin->config->{cache_file} || 'dancer2_debugger.mmap';
        if ( !File::Spec->file_name_is_absolute($path) ) {
            $path =
              File::Spec->catfile( $plugin->app->config->{appdir}, $path );
        }
        return $path;
    },
);

=head2 cache

The L<Cache::FastMmap> cache object.

=cut

has cache => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my $plugin = shift;
        Cache::FastMmap->new(
            share_file => $plugin->cache_file,
            raw_values => 1,
        );
    },
);

=head2 decoder

A L<Sereal::Decoder> object.

=cut

has decoder => (
    is      => 'ro',
    default => sub { Sereal::Decoder->new() },
);

=head2 encoder

A L<Sereal::Encoder> object.

=cut

has encoder => (
    is      => 'ro',
    default => sub {
        Sereal::Encoder->new(
            {
                compress          => 1,
                no_bless_objects  => 1,
                stringify_unknown => 1,
            }
        );
    },
);

=head1 METHODS

=head2 BUILD

Load all C<Dancer2::Plugin::Debugger::Panel::*> classes if L</enabled> is true.

=cut

sub BUILD {
    my $plugin = shift;

    return unless $plugin->config->{enabled};

    my @panels = findsubmod Dancer2::Plugin::Debugger::Panel;

    foreach my $panel (@panels) {
        use_module($panel)->new( plugin => $plugin );
    }
}

=head2 get $key

Get value for C<$key> from L</cache>.

=cut

sub get {
    my ( $self, $key ) = @_;
    $self->cache->get($key);
}

=head2 get_decoded $key

Get decoded value for C<$key> from L</cache> that was previously encoded using
L</encoder>.

=cut

sub get_decoded {
    my ( $self, $key ) = @_;
    my $encoded = $self->get($key);
    return undef unless $encoded;
    $self->decoder->decode($encoded);
}

=head2 set $key, $value

Set value for C<$key> to C<$value> in L</cache>.

=cut

sub set {
    my ( $self, $key, $value ) = @_;
    $self->cache->set( $key, $value );
}

=head2 set_encoded $key, $value

Encode C<$value> using L</encoder> and set this as the value for C<$key>
in the L</cache>.

=cut

sub set_encoded {
    my ( $self, $key, $value ) = @_;
    $self->set( $key, $self->encoder->encode($value) );
}

1;
