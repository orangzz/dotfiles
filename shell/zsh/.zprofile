# terminfo database
# act as if the terminal behaves like xterm-256color








# [[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h




#--  shell invocation mode
#  reading commands from a script or standard input
#  -c Take the first argument as a command to execute

# -- shell process mode
# invoke as login shell
# invoke as interactive shell - shell process input and output connect to terminal emulator
# invoked as script interperter

# logged in from a tty
# logged into system via ssh
# executing a command remotely
# open GNOME or KDE terminal window/tab:
#  login, interactive on macos
#  non‑login, interactive on linux




#-- zsh shell startup/shutdown file loading order

# (If ZDOTDIR is unset, HOME is used instead)
#   1. /etc/zshenv -> $ZDOTDIR/.zshenv         - Always loaded
#   2. /etc/zprofile -> $ZDOTDIR/.zprofile     - If the shell is a login shell
#   3. /etc/zshrc -> $ZDOTDIR/.zshrc            - if the shell is interactive
#   4. /etc/zlogin -> $ZDOTDIR/.zlogin          -  if the shell is a login shell
# Shutdown:
#   5. $ZDOTDIR/.zlogout ->/etc/zlogout         - When a login shell exits


#-- Bash shell statup fie loading order

# invoke as interactive or login shell
# /etc/profile -> ~/.bash_profile -> ~/.bash_login -> ~/.profile -> ~/.bash_logout   - if the shell is a login shell

# invoke as interactive non-login shell
# /etc/bashrc -> ~/.bashrc

# BASH_ENV - if invoke as script interpreter,
# it looks for the variable BASH_ENV in the environment, expands its value if it appears there, and uses the expanded value as the name of a file to read and execute. as if:
# if [ -n "$BASH_ENV" ]; then . "$BASH_ENV"; fi


#-- fish shell startup file loading order

# <install-prefix>/config.fish
# /etc/fish/config.fish
# ~/.config/fish/config.fish


##################################################################################
# `path` : entry in its directory in it wil used as search path to discover executable scripts or native binary
# `fpath`: entry in its directory in it wil be used as search path to find the completin function
# `manpath`:


# Where are `$paths` come from ?
# cat /etc/profile
# if [ -x /usr/libexec/path_helper ]; then
#    eval `/usr/libexec/path_helper -s`
# fi

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

[[ $ZDOTDIR/rc.d/01-func.zsh ]] && . $ZDOTDIR/rc.d/01-func.zsh


# remove duplicate and not-existed entry
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath  # -T creates a "tied" pair;



[[ -z "$commands[brew]" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
# where to find manpages installed by Homebrew

path=(
 $DOTFILES/scripts(N)
 $HOME/.local/bin(N)
 # /home/linuxbrew/.linuxbrew/bin(N)   # (N): null if pattern match doesn't exist
 $path[@]
)

################################################################################## lang runtime version manager and dependency manager setup process
# setup install prefix - the base directory the lang runtime will install to
# setup fpath for shell to discover the completion function
# setup path for shell to discover the executable scripts or native binaries
# install latest lts version of lang runtime



#-- Ruby



RBENV_ROOT=$HOME/.rbenv
if [[ -z $commands[rbenv] && $commands[brew] ]]; then
  brew install rbenv
fi

# rbenv root
# $HOME/.rbenv/versions/<version-number>/bin


# list installed version aware by rbenv
# rbenv versions

# currently active Ruby version
# rbenv version
# reports the currently configured global version.
# rbenv global

# setup the global ruby version shell will invoke
# echo $INSTALL_VERSION > ~/.rbenv/version
# rbenv global <installed-version>

# setup the local ruby version for the current directory
# version string read from a `.ruby-version` file


#-- Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home"
CLASS_PATH="$JAVA_HOME/lib"
PATH="$PATH:$JAVA_HOME/bin"


#-- Rust
zsh_add_path "$HOME/.cargo/bin"

# python runtime version management
# [pyenv](https://github.com/pyenv/pyenv)
# python package and dependency management
# [poetry](https://python-poetry.org)
#



#-- node runtime version  manager

# nvm
# export NVM_INSTALL="$HOME/.nvm" # set install dir
# [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
# nvm end

#`npm config ls --depth=0`
# npm config get prefix - $HOME/.n
# $N_PREFIX/lib/node_modules - installed packages
# $N_PREFIX/bin - installed executables
# $HOME/.n/etc/npmrc -  globalconfig file
export N_PREFIX=$HOME/.n
if [[ -z $commands[n] ]]; then
    curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s install lts
fi
zsh_add_path "$N_PREFIX/bin"
# export N_NODE_MIRROR=https://npmmirror.com/mirrors/node


#-- alternative node dependency manager


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



#
# GPG
# workaround to invoke gpg agent
# require tty to show pinentry prompt
# pop up a window asking for passphrase
# added to init/startup file is used on shell invocations


GPG_TTY="$(tty)"
export GPG_TTY


if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id.account@github 2>/dev/null
fi
# unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#   export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#   gpgconf --launch gpg-agent
# fi
