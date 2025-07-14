


##################################################################################
# default program
##################################################################################
export EDITOR="nvim"
export VISUAL="zed"
export PAGER=less









# xdg base dir spec compliance if not using install base dir
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

#export TERM='rxvt-256color'
#export TERM='xterm-256color'
export DOTFILES="$HOME/dotfiles"


export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XPROFILE="$XDG_CONFIG_HOME/x11/xprofile"






# gpg
export GPG_TTY=$(tty)
