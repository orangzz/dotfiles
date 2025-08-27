export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# := if it's unset or null and then substitutes
# xdg base dir spec compliance
: XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
: XDG_CACHE_HOME=${XDG_CACHE_HOME:=$HOME/.cache}
: XDG_DATA_HOME=${XDG_DATA_HOME:=$HOME/.local/share}
: XDG_STATE_HOME=${XDG_STATE_HOME:=$HOME/.local/state}
#=== ZSH PREFIX ===
ZDOTDIR=$XDG_CONFIG_HOME/zsh

export EDITOR=nvim VISUAL=nvim PAGER=less

# gtk
#export TERM='rxvt-256color'
#export TERM='xterm-256color'
DOTFILES=$HOME/dotfiles


XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
XPROFILE="$XDG_CONFIG_HOME/x11/xprofile"






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
