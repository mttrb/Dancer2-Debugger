use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'Dancer2::Debugger',
    AUTHOR             => q{Peter Mottram (SysPete) <peter@sysnix.com>},
    VERSION_FROM       => 'lib/Dancer2/Debugger.pm',
    ABSTRACT_FROM      => 'lib/Dancer2/Debugger.pm',
    LICENSE            => 'perl_5',
    PL_FILES           => {},
    MIN_PERL_VERSION   => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    PREREQ_PM => {
        'Cache::FastMmap' => 0,
        'Dancer2'         => 0,
        'Dancer2::Plugin' => 0,
        'Data::Dump'      => 0,
        'Moo'             => 2,
        'Sereal'          => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'Dancer2-Debugger-*' },
);
