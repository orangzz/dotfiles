function zsh_add_file(){
    # -r file   True if file exists and is readable
    # -s file   True if file exists and has a size greater than zero.
    [[ -r $ZDOTDIR/$1 ]] && . $ZDOTDIR/$1
}


# discover executable
# prepend a path to the $PATH environment variable.
# path separator - ':' for posix or ';' for win
# only prepend path if it existed and not duplicated
function zsh_add_path() {
    #  IFS=":"
    if [[ -d $1 && ":$path:" != *":$1:"* ]]; then
        path=($1 ${path[@]})
    fi
}

# discover completion
function zsh_add_fpath() {
    # include boundary to avoid substring issue
    [[ -d $1 && " ${fpath[*]} " != *" $1 "* ]] && fpath=($1 ${fpath[@]})
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
      zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin"
      zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
         curl -fsSL "https://raw.githubusercontent.com/HEAD/$1" -o $ZDOTDIR/plugins/
    fi

}

function zsh_add_completion() {
    local COMPLETION_NAME=$(basename "$1")
    if [[ -d "$ZDOTDIR/completions/$COMPLETION_NAME" ]]; then
        zsh_add_file "completions/$COMPLETION_NAME"
    fi

    if [[ "$2" = true ]]; then
        compinit
    fi
}





