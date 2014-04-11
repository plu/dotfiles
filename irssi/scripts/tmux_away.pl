use Irssi;
use strict;
use FileHandle;

use vars qw($VERSION %IRSSI);

$VERSION = "0.9.7.1+tmux";
%IRSSI = (
    authors     => 'Nick Moffitt <nick@zork.net>',
    name        => 'tmux_away',
    description => 'set (un)away, if tmux is attached/detached (based on screen_away by Andreas \'ads\' Scherbaum <ads@ufp.de>)',
    license     => 'GPL v2',
    url         => 'none',
);

# usage:
#
# put this script into your autorun directory and/or load it with
#  /SCRIPT LOAD <name>
#
# there are 5 settings available:
#
# /set tmux_away_active ON/OFF/TOGGLE
# /set tmux_away_repeat <integer>
# /set tmux_away_message <string>
# /set tmux_away_window <string>
# /set tmux_away_nick <string>
#
# active means, that you will be only set away/unaway, if this
#   flag is set, default is ON
# repeat is the number of seconds, after the script will check the
#   tmux status again, default is 5 seconds
# message is the away message sent to the server, default: not here ...
# window is a window number or name, if set, the script will switch
#   to this window, if it sets you away, default is '1'
# nick is the new nick, if the script goes away
#   will only be used it not empty
#
# normal you should be able to rename the script to something other
# than 'tmux_away' (as example, if you dont like the name) by simple
# changing the 'name' parameter in the %IRSSI hash at the top of this script


# variables
my $timer_name = undef;
my $away_status = 0;
my %old_nicks = ();
my %away = ();

# Register formats
Irssi::theme_register(
[
 'tmux_away_crap', 
 '{line_start}{hilight ' . $IRSSI{'name'} . ':} $0'
]);

# if we are running
my $tmux_away_used = 0;

# try to find out, if we are running in a tmux
# (see, if $ENV{STY} is set
if (!defined($ENV{TMUX})) {
  # just return, we will never be called again
  Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'tmux_away_crap',
    "could not open status file for parent process (pid: " . getppid() . "): $!");
  return;
}

my $socket = $ENV{TMUX};
$socket =~ s/,.*$//;

# register config variables
Irssi::settings_add_bool('misc', $IRSSI{'name'} . '_active', 1);
Irssi::settings_add_int('misc', $IRSSI{'name'} . '_repeat', 5);
Irssi::settings_add_str('misc', $IRSSI{'name'} . '_message', "not here ...");
Irssi::settings_add_str('misc', $IRSSI{'name'} . '_window', "1");
Irssi::settings_add_str('misc', $IRSSI{'name'} . '_nick', "");

# init process
tmux_away();

# tmux_away()
#
# check, set or reset the away status
#
# parameter:
#   none
# return:
#   0 (OK)
sub tmux_away {
  my ($away, @tmux, $tmux);

  # only run, if activated
  if (Irssi::settings_get_bool($IRSSI{'name'} . '_active') == 1) {
    if ($away_status == 0) {
      # display init message at first time
      Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'tmux_away_crap',
        "activating $IRSSI{'name'} (interval: " . Irssi::settings_get_int($IRSSI{'name'} . '_repeat') . " seconds)");
    }
    # get actual tmux status
    my @tmux = stat($socket);
    # 00100 is the mode for "user has execute permissions", see stat.h
    if (($tmux[2] & 00100) == 0) {
      # no execute permissions, Detached
      $away = 1;
    } else {
      # execute permissions, Attached
      $away = 2;
    }

    # check if status has changed
    if ($away == 1 and $away_status != 1) {
      # set away
      if (length(Irssi::settings_get_str($IRSSI{'name'} . '_window')) > 0) {
        # if length of window is greater then 0, make this window active
        Irssi::command('window goto ' . Irssi::settings_get_str($IRSSI{'name'} . '_window'));
      }
      Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'tmux_away_crap',
        "Set away");
      my $message = Irssi::settings_get_str($IRSSI{'name'} . '_message');
      if (length($message) == 0) {
        # we have to set a message or we wouldnt go away
        $message = "not here ...";
      }
      my ($server);
      foreach $server (Irssi::servers()) {
        if (!$server->{usermode_away}) {
          # user isnt yet away
          $away{$server->{'tag'}} = 0;
          $server->command("AWAY " . (($server->{chat_type} ne 'SILC') ? "-one " : "") . "$message") if (!$server->{usermode_away});
          if (length(Irssi::settings_get_str($IRSSI{'name'} . '_nick')) > 0) {
            # only change, if actual nick isnt already the away nick
            if (Irssi::settings_get_str($IRSSI{'name'} . '_nick') ne $server->{nick}) {
              # keep old nick
              $old_nicks{$server->{'tag'}} = $server->{nick};
              # set new nick
              $server->command("NICK " . Irssi::settings_get_str($IRSSI{'name'} . '_nick'));
            }
          }
        } else {
          # user is already away, remember this
          $away{$server->{'tag'}} = 1;
        }
      }
      $away_status = $away;
    } elsif ($away == 2 and $away_status != 2) {
      # unset away
      Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'tmux_away_crap',
        "Reset away");
      my ($server);
      foreach $server (Irssi::servers()) {
        if ($away{$server->{'tag'}} == 1) {
          # user was already away, dont reset away
          $away{$server->{'tag'}} = 0;
          next;
        }
        $server->command("AWAY" . (($server->{chat_type} ne 'SILC') ? " -one" : "")) if ($server->{usermode_away});
        if (defined($old_nicks{$server->{'tag'}}) and length($old_nicks{$server->{'tag'}}) > 0) {
          # set old nick
          $server->command("NICK " . $old_nicks{$server->{'tag'}});
          $old_nicks{$server->{'tag'}} = "";
        }
      }
      $away_status = $away;
    }
  }
  # but everytimes install a new timer
  register_tmux_away_timer();
  return 0;
}

# register_tmux_away_timer()
#
# remove old timer and install a new one
#
# parameter:
#   none
# return:
#   none
sub register_tmux_away_timer {
  if (defined($timer_name)) {
    # remove old timer, if defined
    Irssi::timeout_remove($timer_name);
  }
  # add new timer with new timeout (maybe the timeout has been changed)
  $timer_name = Irssi::timeout_add(Irssi::settings_get_int($IRSSI{'name'} . '_repeat') * 1000, 'tmux_away', '');
}

