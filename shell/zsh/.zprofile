##################################################################################
# [direnv]()
# project environment variable manager
# [dotenvx](https://dotenvx.com/docs/env-file)
# project secert manager

# zsh shell starup file loading order (If ZDOTDIR is unset, HOME is used instead)
# Startup:
#   1. /etc/zshenv -> $ZDOTDIR/.zshenv                         - Always loaded
#   2. /etc/zprofile -> $ZDOTDIR/.zprofile.     - If the shell is a login shell
#   3. /etc/zshrc -> $ZDOTDIR/.zshrc            - if the shell is interactive
#   4. /etc/zlogin -> $ZDOTDIR/.zlogin          -  if the shell is a login shell,
# Shutdown:
#   5. $ZDOTDIR/.zlogout ->/etc/zlogout         - When a login shell exits



# x11/xinitrc
# x11/xprofile
# x1ll/xresources


##################################################################################
# `path` : entry in its directory in it wil used as search path to find executable scripts or native binary
# `fpath`: entry in its directory in it wil be used as search path to find the completin function
# `manpath`:


# Where are `$paths` come from ?

# macos use utility `/usr/libexec/path_helper` prepend the system path to the `$path` environment variable
# content of `/etc/paths` and all the entry in `/etc/paths.d` directory,

# Changes to /etc/profile might be overwritten by a future macOS update.
#  Changes to a user’s profile file, might be overwritten by the user.
#  dropping a file into `/etc/paths.d` with a package installer will affect all users on a system.


# verify with command `cat /etc/paths /etc/paths.d/*`
# `cat /etc/profile
# System-wide .profile for sh(1)
# if [ -x /usr/libexec/path_helper ]; then
   # eval `/usr/libexec/path_helper -s`
# fi


# turn out `$path` in `ZDOTDIR/.zshenv` is load befored the system path
# $ZDOTDIR/.zprofile <- `/etc/paths` <- `/etc/paths.d` <- $ZDOTDIR/.zshenv
# causing system binaries to take precedence over homebrew-installed ones

# prefer precedence
# $DOTFILES/scripts <- $HOMEBREW_PREFIX/{s,}bin <- system path



#-- Per user paths
# `~/Library/Paths/paths.d`
# `~/Library/Paths/paths`
# `~/.config/paths.d/`
# `~/.config/paths`
##################################################################################




# hismastervoicek1
# serverFault
# stackoverflow
# segementFault
# codeRefactor


[[ $ZDOTDIR/.zfunc.zsh ]] && . $ZDOTDIR/.zfunc.zsh


# remove duplicate and not-existed entry
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath  # -T creates a "tied" pair;



[[ -z "$commands[brew]" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
# where to find manpages installed by Homebrew

path=(
 $DOTFILES/scripts
 $HOME/.local/bin
 # /home/linuxbrew/.linuxbrew/bin(N)   # (N): null if file doesn't exist
 $path[@]
)

##################################################################################
# language runtime and dependency manager installed


#-- Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home"
CLASS_PATH="$JAVA_HOME/lib"
PATH="$PATH:$JAVA_HOME/bin"

# Rust
zsh_add_path "$HOME/.cargo/bin"


# python runtime version management
# [pyenv](https://github.com/pyenv/pyenv)
# python package and dependency management
# [poetry](https://python-poetry.org)
#



#-- node runtime version pacmage manager

# nvm
# export NVM_INSTALL="$HOME/.nvm" # set install dir
# [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
# nvm end

# n
#`npm cofig ls`
# npm config get prefix
# $N_PREFIX/lib/node_modules - installed packages
# $N_PREFIX/bin - installed executables
export N_PREFIX=$HOME/.n
zsh_add_path "$N_PREFIX/bin"

#--  node package and dependency manager


# pnpm
export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share/pnpm}"
[[ ! -d $PNPM_HOME ]] && mkdir -p $PNPM_HOME
zsh_add_path $PNPM_HOME/node_modules/.bin
# pnpm end


# bun
export BUN_INSTALL="$HOME/.bun"
zsh_add_path "$BUN_INSTALL/bin"


#-- Golang

# The go install command installs binaries to $GOBIN, which defaults to $GOPATH/bin

zsh_add_path "$GOBIN"
