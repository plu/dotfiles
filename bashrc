# scp? return!
[ -z "$PS1" ] && return
[ -x $HOME/.dotfiles/install.sh ] && $HOME/.dotfiles/install.sh
[ -x $HOME/.dotfiles-secret/install.sh ] && $HOME/.dotfiles-secret/install.sh
source $HOME/.git.sh
source $HOME/.git-completion.sh
source $HOME/.env.sh
source $HOME/.history.sh
export PS1='\u@\h \w$(parse_git_branch)\$ '
