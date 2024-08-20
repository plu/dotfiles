[[ -f "$HOME/.env-secret.sh" ]] && source $HOME/.env-secret.sh

test "$SSH_AUTH_SOCK" && ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
  [ -d /Development/go ] && export GOPATH=/Development/go
  [ -d ~/Development/go ] && export GOPATH=~/Development/go
  export BETA_TESTING=1
  export COPYFILE_DISABLE=true
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
  export FASTLANE_HIDE_PLUGINS_TABLE=1
  export FASTLANE_HIDE_TIMESTAMP=1
  export FASTLANE_OPT_OUT_USAGE=1
  export FASTLANE_SKIP_ACTION_SUMMARY=1
  export FASTLANE_SKIP_UPDATE_CHECK=1
  export LSOPTIONS='-G'
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
  export PATH="$GOPATH/bin:$PATH"
  export PATH="$GO_HOME/bin:$PATH"
  export PATH="$JAVA_HOME/bin:$PATH"
  export PATH="$PATH:/usr/local/opt/go/libexec/bin"
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/flutter/bin:$PATH"
  export PATH="/usr/local/google-cloud-sdk/bin/:$PATH"
  export PATH="/usr/local/heroku/bin:$PATH"
  export PATH="/usr/local/mysql/bin:$PATH"
  export PATH="/usr/local/packer:$PATH"
  export PATH="/usr/local/sbin:$PATH"
  export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
  export PATH="$HOME/Library/Android/sdk/tools:$PATH"
  export PATH="$HOME/.rd/bin:$PATH"
  export PATH="$HOME/bin:$PATH"
  export PKG_CONFIG_PATH="/usr/local/opt/libressl/lib/pkgconfig"
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
export FASTLANE_HIDE_PLUGINS_TABLE=1
export FASTLANE_HIDE_TIMESTAMP=1
export FASTLANE_OPT_OUT_USAGE=1
export FASTLANE_SKIP_ACTION_SUMMARY=1
export FASTLANE_SKIP_UPDATE_CHECK=1
export GPG_TTY=$(tty)
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LC_ALL="en_US.UTF-8"
export NVM_DIR="$HOME/.nvm"
export PAGER=less
export PATH=$HOME/bin:$PATH
export SDKMAN_DIR="$HOME/.sdkman"
export TERM=screen-256color
export TZ=Europe/Berlin

alias diff='diff -Nuarbw'
alias flushdns='sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache'
alias gti='git'
alias k=kubectl
alias kaj='jobs -l | awk '\''{print $2}'\'' | xargs kill -9'
alias kdd='rm -rf ~/Library/Developer/Xcode/DerivedData/*'
alias l='ls $LSOPTIONS -l'
alias ll='ls $LSOPTIONS -lA'
alias ls='ls $LSOPTIONS'
alias mutt='TERM=vt100 mutt'
alias tmux="tmux -2"
alias v=velero
alias vbi='vim +BundleInstall +qall'

[[ -x /usr/libexec/path_helper ]] && eval "$(/usr/libexec/path_helper -s)"

[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f /usr/local/google-cloud-sdk/completion.zsh.inc ]] && source /usr/local/google-cloud-sdk/completion.zsh.inc
[[ -f /usr/local/google-cloud-sdk/path.zsh.inc ]] && source /usr/local/google-cloud-sdk/path.zsh.inc
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.ios ]] && source ~/.ios
[[ -f ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"
[[ -s $HOME/.gvm/scripts/gvm ]] && source $HOME/.gvm/scripts/gvm
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -s $HOME/.sdkman/bin/sdkman-init.sh ]] && source $HOME/.sdkman/bin/sdkman-init.sh
[[ -s $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion
[[ -s $NVM_DIR/nvm.sh ]] && \. $NVM_DIR/nvm.sh

which bat >/dev/null && alias cat='bat'
which direnv >/dev/null && eval "$(direnv hook zsh)"
which kubectl >/dev/null && source <(kubectl completion zsh)
which pyenv >/dev/null && eval "$(pyenv init --path)"
which rbenv >/dev/null && eval "$(rbenv init - zsh)"
which velero >/dev/null && source <(velero completion zsh)
