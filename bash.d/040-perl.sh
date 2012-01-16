#export CATALYST_CONFIG_LOCAL_SUFFIX=plu
export CATALYST_DEBUG=1
export CATALYST_RELOAD=1
export DBIC_TRACE=1
export PERL_MM_USE_DEFAULT=1
export TEST_POD=1
export PERLBREW_HOME=/opt/perlbrew
[ -f "/opt/perlbrew/etc/bashrc" ] && source /opt/perlbrew/etc/bashrc

if [ "$(type -t cd)" == "builtin" ]; then
    local func="_perl_locallib_orig_cd() { builtin cd \"\$@\"; }"
else
    local func="$(declare -f cd)"
    local func="_perl_locallib_orig_cd${func#cd}"
fi
eval $func

_perl_locallib_custom_cd() {
    local cwd=$(pwd)
    if [[ "$HOME" != "$cwd" && -f "$cwd/.llrc" ]] ; then
        local ll=$PERLBREW_ROOT/locallib/$(cat "$cwd/.llrc")-$(perl -e 'print $^V')
        local OLD_PATH=$PERL_LOCAL_LIB_ROOT
        eval $(perl -Mlocal::lib='--deactivate-all' 2>/dev/null)
        eval $(perl -Mlocal::lib=$ll 2>/dev/null)
        if [ "$?" -eq "0" ] && [ "$ll" != "$OLD_PATH" ] && [ -n "$PERL_LOCAL_LIB_ROOT" ]; then
            echo "Setting local::lib to: $ll"
        fi
    else
        if [[ -f "$HOME/.llrc" ]] ; then
            local ll=$PERLBREW_ROOT/locallib/$(cat "$HOME/.llrc")-$(perl -e 'print $^V')
            local OLD_PATH=$PERL_LOCAL_LIB_ROOT
            eval $(perl -Mlocal::lib='--deactivate-all' 2>/dev/null)
            eval $(perl -Mlocal::lib=$ll 2>/dev/null)
            if [ "$?" -eq "0" ] && [ "$ll" != "$OLD_PATH" ] && [ -n "$PERL_LOCAL_LIB_ROOT" ]; then
                echo "Setting local::lib to: $ll"
            fi
        fi
    fi
}

cd() {
    _perl_locallib_orig_cd "$@"
    local result=$?
    if [ "$result" -eq "0" ]; then
        _perl_locallib_custom_cd "$@"
    fi
    return $result
}

_perl_locallib_custom_cd
