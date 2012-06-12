# scp? return!
[ -z "$PS1" ] && return

function source_dir {
  dir=$1
  if [ -d "$dir" ] ; then
    for rc in $dir/* ; do
      [ -f "$rc" ] && source $rc
    done
  fi
}

$HOME/.dotfiles/install.sh

umask 0022
export EDITOR=vim
export PAGER=less
export OS=`uname`

source_dir "$HOME/.bash.d"
source_dir "$HOME/.bash.d/$OS"
source_dir "$HOME/.bash.d/$HOSTNAME"

[ -f "$HOME/.dotfiles-secret/bashrc" ] && source $HOME/.dotfiles-secret/bashrc

unset LC_CTYPE
unset LANG
