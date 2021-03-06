export PERLBREW_HOME=/opt/perl5
[[ -f "/opt/perl5/etc/bashrc" ]] && source /opt/perl5/etc/bashrc
[[ -f "$HOME/.env-secret.sh" ]] && source $HOME/.env-secret.sh

test "$SSH_AUTH_SOCK" && ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
  export COPYFILE_DISABLE=true
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
  [ -d ~/Development/go ] && export GOPATH=~/Development/go
  [ -d /Development/go ] && export GOPATH=/Development/go
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  export LSOPTIONS='-G'
  export PATH=$GOPATH/bin:$PATH
  export PATH=$GO_HOME/bin:$PATH
  export PATH=$JAVA_HOME/bin:$PATH
  export PATH=/usr/local/bin:$PATH
  export PATH=/usr/local/sbin:$PATH
  export PATH=/usr/local/heroku/bin:$PATH
  export PATH=/usr/local/mysql/bin:$PATH
  export PATH=/usr/local/packer:$PATH
  export PATH=$PATH:/usr/local/opt/go/libexec/bin
  export PATH=~/Library/Android/sdk/tools:$PATH
  export PATH=~/Library/Android/sdk/platform-tools:$PATH
  export PATH=/usr/local/flutter/bin:$PATH
  export PATH=/usr/local/google-cloud-sdk/bin/:$PATH
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
export BAT_THEME=GitHub
export EDITOR=vim
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LC_ALL="en_US.UTF-8"
export PAGER=less
export PATH=$HOME/bin:$PATH
export TZ=Europe/Berlin
export TERM=screen-256color

alias vbi='vim +BundleInstall +qall'
alias diff='diff -Nuarbw'
alias disablevnc='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off'
alias enablevnc='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -clientopts -setvnclegacy -vnclegacy yes -clientopts -setvncpw -vncpw mypasswd -restart -agent -privs -all'
alias flushdns='sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache'
alias gti='git'
alias kaj='jobs -l | awk '\''{print $2}'\'' | xargs kill -9'
alias kdd='rm -rf ~/Library/Developer/Xcode/DerivedData/*'
alias l='ls $LSOPTIONS -l'
alias ll='ls $LSOPTIONS -lA'
alias ls='ls $LSOPTIONS'
alias mutt='TERM=vt100 mutt'
alias tmux="tmux -2"
[[ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]] && source '/usr/local/google-cloud-sdk/path.zsh.inc'
[[ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]] && source '/usr/local/google-cloud-sdk/completion.zsh.inc'
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -s $HOME/.gvm/scripts/gvm ]] && source $HOME/.gvm/scripts/gvm
which bat >/dev/null && alias cat='bat'
which pyenv >/dev/null && eval "$(pyenv init -)"
which direnv >/dev/null && eval "$(direnv hook bash)"
