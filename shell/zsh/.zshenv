


##################################################################################
# default program
##################################################################################
export EDITOR="nvim"
export VISUAL="zed"
export PAGER=less


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8








# xdg base dir spec compliance if not using install base dir
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

#export TERM='rxvt-256color'
#export TERM='xterm-256color'
export DOTFILES="$HOME/dotfiles"


export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XPROFILE="$XDG_CONFIG_HOME/x11/xprofile"






# gpg suit
# `gpg`:
# auxiliary programs
# `dirmngr`: invoke by `gpg` to access PGP keyservers
# `pinenry`:
# workaround, use terminal style to prompt for passphase whe signing
export GPG_TTY=$(tty)
# for argument you would like to be the default, you can add theme to respective config file
# gpg check `$gnupg_home/gpg.conf` (user specific) and `/etc/gnupg/gpg.conf`
# dirmngr check `$gnupg_home/dirmngr.conf` (user specific) and `/etc/gnupg/dirmngr.conf`
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi


# User-specific environment files take precedence over prefix-specific files and prefix-specific files take precedence over system-wide files
# /etc/homebrew/brew.env (system-wide)
# ${HOMEBREW_PREFIX}/etc/homebrew/brew.env (install-prefix-specific)
# $XDG_CONFIG_HOME/homebrew/brew.env if $XDG_CONFIG_HOME is set or ~/.homebrew/brew.env otherwise (user-specific)
export HOMEBREW_BUNDLE_FILE_GLOBAL=${XDG_CONFIG_HOME:=$HOME/.config}/homebrew/Brewfile
