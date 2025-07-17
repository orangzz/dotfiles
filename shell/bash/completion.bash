_git() {
    _compadd git --list-cmds=list-mainporcelain
    =
}

_cmd_clone(){
    _compadd "git clone  --git-completion-helper"
}
_compadd() {
    COMPREPLY=($(compgen -W "$1" -- "${COMP_WORDS[COMP_CWORD]}" ))
}
