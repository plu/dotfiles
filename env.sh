which direnv >/dev/null && eval `direnv hook $0`
export PERLBREW_HOME=/opt/perl5
[[ -f "/opt/perl5/etc/bashrc" ]] && source /opt/perl5/etc/bashrc
[[ -f "$HOME/.env-secret.sh" ]] && source $HOME/.env-secret.sh
which pyenv >/dev/null && eval "$(pyenv init -)"

test "$SSH_AUTH_SOCK" && ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
  export COPYFILE_DISABLE=true
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
  export JAVA_HOME=/Library/Java/Home
  export LSOPTIONS='-G'
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
  export PATH=/usr/local/heroku/bin:/opt/go_appengine:/usr/local/mysql/bin:/usr/local/bin:/usr/local/share/git/contrib:/opt/appengine-java-sdk/bin:/Applications/VMware\ Fusion.app/Contents/Library:$PATH
  export PATH=/Applications/android-sdk-macos/sdk/platform-tools:/Applications/android-sdk-macos/sdk/tools:/usr/local/packer:$PATH
  export PATH=$JAVA_HOME/bin:$PATH
  export PATH=/opt/play:$PATH
  export PATH=/usr/local/ec2/bin:$PATH
  export EC2_HOME=/usr/local/ec2
  export IOS_SDK_VERSION=7.0
  export TEST_SCHEME=Smoke
  export DYLD_LIBRARY_PATH=/usr/local/mysql/lib
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
unset LC_ALL
export EDITOR=vim
export HISTCONTROL=ignoreboth
export HISTSIZE=10000000000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LC_ALL="en_US.UTF-8"
export PAGER=less
export PATH=$HOME/bin:$PATH:/usr/local/sbin:/usr/sbin:/sbin
export TZ=Europe/Berlin

alias b='bundle'
alias be='bundle exec'
alias vbi='vim +BundleInstall +qall'
alias diff='diff -Nuarbw'
alias disablevnc='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off'
alias enablevnc='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -clientopts -setvnclegacy -vnclegacy yes -clientopts -setvncpw -vncpw mypasswd -restart -agent -privs -all'
alias flushdns='sudo discoveryutil udnsflushcaches; dscacheutil -flushcache'
alias gti='git'
alias kaj='jobs -l | awk '\''{print $2}'\'' | xargs kill -9'
alias l='ls $LSOPTIONS -l'
alias ll='ls $LSOPTIONS -lA'
alias ls='ls $LSOPTIONS'
alias mate=vim
alias mvim=vim
alias mountpb='hdiutil attach -nobrowse ~/Dropbox/Development/perlbrew.sparseimage'
alias mutt='TERM=vt100 mutt'
alias natsort="perl -MSort::Key::Natural=natsort -e '@s=<>; print for natsort @s'"
alias noll='eval $(perl -Mlocal::lib='--deactivate-all')'
alias tmux="tmux -2"
alias umountpb='diskutil eject /Volumes/perlbrew'

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -f '/opt/google-cloud-sdk/path.bash.inc' ]] && source '/opt/google-cloud-sdk/path.bash.inc'
[[ -f '/opt/google-cloud-sdk/completion.bash.inc' ]] && source '/opt/google-cloud-sdk/completion.bash.inc'
