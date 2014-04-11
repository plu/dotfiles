use strict;
use Irssi;

my $VERSION = '0.1';
my %IRSSI   = (
    authors => 'Johannes Plunien',
    contact => 'http://www.pqpq.de/contact/',
    license => 'Perl',
);

Irssi::command_bind(
    'qc' => sub {
        foreach my $w ( Irssi::windows() ) {
            my $act = $w->{active};
            next unless defined $act->{type};
            $w->command("window close") if $act->{type} eq 'QUERY';
        }
    }
);
