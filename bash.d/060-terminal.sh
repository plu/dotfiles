if [ $TERM == "xterm-color" ]; then
    export TERM="xterm"
fi
export PS1='\u@\h \w$(parse_git_branch)\$ '
