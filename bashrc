# scp? return!
[ -z "$PS1" ] && return
$HOME/.dotfiles/install.sh
$HOME/.dotfiles-secret/install.sh
source $HOME/.git.sh
source $HOME/.git-completion.sh
source $HOME/.env.sh
export PS1='\u@\h \w$(parse_git_branch)\$ '
