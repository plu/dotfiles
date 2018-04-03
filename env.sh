export PERLBREW_HOME=/opt/perl5
[[ -f "/opt/perl5/etc/bashrc" ]] && source /opt/perl5/etc/bashrc
[[ -f "$HOME/.env-secret.sh" ]] && source $HOME/.env-secret.sh

test "$SSH_AUTH_SOCK" && ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
  export COPYFILE_DISABLE=true
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
  export GOPATH=~/Development/go
  export GO_HOME=/usr/local/go
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  export LSOPTIONS='-G'
  export PATH=$GOPATH/bin:$PATH
  export PATH=$GO_HOME/bin:$PATH
  export PATH=$JAVA_HOME/bin:$PATH
  export PATH=/Applications/VMware\ Fusion.app/Contents/Library:$PATH
  export PATH=/Applications/android-sdk-macos/sdk/platform-tools:$PATH
  export PATH=/Applications/android-sdk-macos/sdk/tools:$PATH
  export PATH=/opt/appengine-java-sdk/bin:$PATH
  export PATH=/opt/go_appengine:$PATH
  export PATH=/opt/play:$PATH
  export PATH=/usr/local/bin:$PATH
  export PATH=/usr/local/heroku/bin:$PATH
  export PATH=/usr/local/mysql/bin:$PATH
  export PATH=/usr/local/packer:$PATH
  export PATH=/usr/local/share/git/contrib:$PATH
  export PATH=/usr/local/bin/Sencha/Cmd:$PATH
elif [[ "$OS" == "Linux" ]]; then
  export LSOPTIONS='--color=auto'
  export SWIFT_ROOT=/opt/swift
  export PATH=$SWIFT_ROOT/usr/bin:$PATH
elif [[ "$OS" == "FreeBSD" ]]; then
  export LSOPTIONS='-G'
  export LSCOLORS="Exfxcxdxbxegedabagacad"
fi

function ksdiff {
  result=$(mktemp).png
  compare $1 $2 $result
  open $1
  open $2
  open $result
}

if [[ $TERM == "xterm-color" ]]; then
    export TERM="xterm"
fi

unset LANG
unset LC_CTYPE
unset LSCOLORS
unset LC_ALL
export EDITOR=vim
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LC_ALL="en_US.UTF-8"
export PAGER=less
export PATH=$HOME/bin:$PATH
export TZ=Europe/Berlin

alias vbi='vim +BundleInstall +qall'
alias diff='diff -Nuarbw'
alias disablevnc='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off'
alias enablevnc='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -clientopts -setvnclegacy -vnclegacy yes -clientopts -setvncpw -vncpw mypasswd -restart -agent -privs -all'
alias flushdns='sudo discoveryutil udnsflushcaches; dscacheutil -flushcache'
alias gti='git'
alias kaj='jobs -l | awk '\''{print $2}'\'' | xargs kill -9'
alias kdd='rm -rf ~/Library/Developer/Xcode/DerivedData/*'
alias l='ls $LSOPTIONS -l'
alias ll='ls $LSOPTIONS -lA'
alias ls='ls $LSOPTIONS'
alias mutt='TERM=vt100 mutt'
alias tmux="tmux -2"

[[ -f '/opt/google-cloud-sdk/path.bash.inc' ]] && source '/opt/google-cloud-sdk/path.bash.inc'
[[ -f '/opt/google-cloud-sdk/completion.bash.inc' ]] && source '/opt/google-cloud-sdk/completion.bash.inc'
which direnv >/dev/null && eval `direnv hook $0`
which pyenv >/dev/null && eval "$(pyenv init -)"
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
