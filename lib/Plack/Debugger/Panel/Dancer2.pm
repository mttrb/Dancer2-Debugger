package Plack::Debugger::Panel::Dancer2;

=head1 NAME

Plack::Debugger::Panel::Dancer2 - base class for Dancer2 panels

=cut

use strict;
use warnings;

use Data::Dump qw(dump);
use Cache::FastMmap;
use Sereal::Decoder;

use open ':std', ':encoding(UTF-8)';
use parent 'Plack::Debugger::Panel';

sub new {
    my $class = shift;

    my %args = @_ == 1 && ref $_[0] eq 'HASH' ? %{ $_[0] } : @_;

    $args{cache_file} = '/home/apm/git/perl.dance/dancer2_debugger.mmap';

    die "cache_file is a required parameter" unless $args{cache_file};

    my $self = $class->SUPER::new( \%args );

    unlink $args{cache_file};

    $self->{dancer2_cache} ||= Cache::FastMmap->new(
        share_file => $args{cache_file},
        raw_values => 1,
    );
    $self->{dancer2_decoder} ||= Sereal::Decoder->new();

    $self;
}

sub dancer2_cache_get {
    my ( $self, $key ) = @_;
    my $value = $self->{dancer2_cache}->get_and_remove($key);
    return undef unless $value;
    return $self->{dancer2_decoder}->decode($value);
}

1;

