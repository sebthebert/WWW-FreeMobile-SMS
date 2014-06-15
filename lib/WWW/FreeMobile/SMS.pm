package WWW::FreeMobile::SMS;

=head1 NAME

WWW::FreeMobile::SMS - Module giving easy access to FreeMobile SMS API

=head1 DESCRIPTION

Module giving easy access to FreeMobile SMS API

=head1 SYNOPSIS

    use WWW::FreeMobile::SMS;

    my $sms = WWW::FreeMobile::SMS->new({user => $user, password => $password});

    $sms->send($msg);

=cut

use strict;
use warnings;

use LWP::UserAgent;

our $VERSION = '0.2';

my $URL_API = 'https://smsapi.free-mobile.fr/sendmsg';

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

=head1 SUBROUTINES/METHODS

=head2 new($params)

Creates a new instance of PushBullet API

    my $sms = WWW::FreeMobile::SMS->new({user => $user, password => $password});

=cut

sub new
{
    my ($class, $params) = @_;

    return (undef)
        if ((!defined $params->{user}) || (!defined $params->{password}));
        
    my $ua = LWP::UserAgent->new;
    $ua->agent("WWW::FreeMobile::SMS/$VERSION");
    $ua->proxy('https', $params->{proxy}) if (defined $params->{proxy});

    my $self = {
        _ua       => $ua,
        _user     => $params->{user},
        _password => $params->{password},
        _debug    => $params->{debug} || 0,
    };

    bless $self, $class;

    return ($self);
}

=head2 send($msg)

=cut

sub send
{
    my ($self, $msg) = @_;

    my $url =
          "${URL_API}?user="
        . $self->{_user}
        . '&pass='
        . $self->{_password} . '&msg='
        . $msg;
    my $res = $self->{_ua}->get($url);

    if ($res->is_success)
    {
        printf $res->content;
        return (1);
    }
    else
    {
        print $res->status_line, "\n";
        return (0);
    }
}

=head2 version()

Returns WWW::FreeMobile::SMS module version

=cut

sub version
{
    return ($VERSION);
}

1;

=head1 AUTHOR

Sebastien Thebert <www-freemobile-sms@onetool.pm>

=cut
