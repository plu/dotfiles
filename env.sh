which direnv >/dev/null && eval `direnv hook $0`
export PERLBREW_HOME=/opt/perlbrew
[[ -f "/opt/perlbrew/etc/bashrc" ]] && source /opt/perlbrew/etc/bashrc
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -f "$HOME/.dotfiles-secret/env.sh" ]] && source $HOME/.dotfiles-secret/env.sh

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
  export COPYFILE_DISABLE=true
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
  export JAVA_HOME=/Library/Java/Home
  export LSOPTIONS='-G'
  export PATH=/usr/local/mysql/bin:/usr/local/bin:/usr/local/share/git/contrib:/opt/appengine-java-sdk/bin:$PATH
elif [[ "$OS" == "Linux" ]]; then
  export LSOPTIONS='--color=auto'
elif [[ "$OS" == "FreeBSD" ]]; then
  export LSOPTIONS='-G'
  export LSCOLORS="Exfxcxdxbxegedabagacad"
fi

if [[ $TERM == "xterm-color" ]]; then
    export TERM="xterm"
fi

unset LANG
unset LC_CTYPE
unset LSCOLORS
export EDITOR=vim
export HISTCONTROL=ignoredups
export HISTSIZE=10000000000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export PAGER=less
export PATH=$HOME/bin:$PATH:/usr/local/sbin:/usr/sbin:/sbin

alias diff='diff -Nuarbw'
alias flushdns='dscacheutil -flushcache'
alias kaj='jobs -l | awk '\''{print $2}'\'' | xargs kill -9'
alias l='ls $LSOPTIONS -l'
alias ll='ls $LSOPTIONS -lA'
alias ls='ls $LSOPTIONS'
alias mate=mvim
alias mountpb='hdiutil attach -nobrowse ~/Dropbox/Development/perlbrew.sparseimage'
alias mutt='TERM=vt100 mutt'
alias natsort="perl -MSort::Key::Natural=natsort -e '@s=<>; print for natsort @s'"
alias noll='eval $(perl -Mlocal::lib='--deactivate-all')'
alias umountpb='diskutil eject /Volumes/perlbrew'
