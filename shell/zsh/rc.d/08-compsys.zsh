# === Completion ===
# man zshcompsys
# add as submodule or cherry-pick the specific completions
# feat(completion): print completion code to stdout instead modify shell config





# $ZDOTDIR/.zcompdump
# $ZDOTDIR/.zcompcache


# compinit, compdef, compgen, compadd, complist



# case "$SHELL" in
#  *zsh) generate_zsh_completion ;;
#  *bash) generate_bash_completion ;;
# esac


# Make `tab` and `shift+tab` display the completion menu, cycle completions on the command line
# - `$(brew --prefix)/share/zsh/site-functions
# - `/usr/local/share/zsh/site-functions` (for system-wide installations)
# - `~/.config/zsh/completions` (for user-specific completions)


# compinit and compaudit use entry in `fpath` directory as search path for completion function discovery
#
# starship completions fish | source
# source <(starship completions fish)
# eval "$(starship completions zsh)"
# $_comps[starship], $_functions[_starship]

# optimzing startup time to less than 100ms
# defer initialization
# complie completion functions into a cached bytecode dump.

# use `$fpath` as search path to register completion functions
typeset -U fpath
fpath=(
    ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/completions
    $HOMEBREW_PREFIX/share/zsh/site-functions
    $fpath[@]
)

# zsh_add_fpath $HOMEBREW_PREFIX/share/zsh/site-functions
# zsh_add_fpath "$XDG_CONFIG_HOME/zsh/completions"

# zmodload zsh/complist

# go,python,node,bun,rust,kubctl,helm, docker,

function kubectl() {
    # local setup=__start_kubectl
    # if there isn't completion loaded and executable found in search path
    if [[ -z $_comps[kubectl] && -n $commands[kubectl] ]]; then
        source <(command kubectl completion zsh)

        # (( ${+_comps} )) && _comps[kubectl]=$setup
        # autoload -Uz _asdf
        # compdef _asdf asdf
    fi
    command kubectl "$@"
}


# [[ -z $functions[__start_kubectl] && ! -s $ZDOTDIR/completions/__start_kubectl && $commands[kubectl] ]] && {
#     kubectl completion zsh 2> /dev/null >| "$ZDOTDIR/completions/_kubectl"
# } &!


# helm completion

# register completion function

#  registers `_ngrok` as the completion function for `ngrok`
# $_comps[ngrok]=_ngrok
# compdef _ngrok ngrok, $_comps[ngrok], $_functions[_ngrok]


# function ngrok() {
#     if [[ -z $_comps[ngrok] ]]; then
#         source <(ngrok completion)

#         # ngrok completion 2> /dev/null >| "$ZDOTDIR/completions/_ngrok" &|
#     fi
#     command ngrok "$@"
# }
#
# function strip() {
#
# }
#
#-- multi runtime version manager - asdf


#-- node, bun

# function pnpm() {
#     if [[ -z $_comps[pnpm] ]]; then
#         source <(command pnpm completion zsh)
#         # pnpm completion zsh 2> /dev/null >| "$ZDOTDIR/completions/_pnpm" &|
#     fi
#     command pnpm "$@"
# }
[[ -z $_comps[pnpm] && ! -s $ZDOTDIR/completions/_pnpm && $commands[pnpm] ]] && {
    pnpm completion zsh >| "$ZDOTDIR/completions/_pnpm"
} &!


#-- ptyhon
# runtime version manager
# package or/and dependency manager

function pyenv() {
    if [[ -z $_comps[pyenv] ]]; then
        source <(pyenv init - --no-rehash)
    fi
    command pyenv "$@"
}

# echo "Value: '${commands[pyenv]}'"                                               main
# echo "Length: ${#commands[pyenv]}"
# check is unset or empty
# test -n "$commands[pyenv]" && "non-empty" || "empty"
[[ -z $_comps[pyenv] && ! -s $ZDOTDIR/completions/_pyenv && -n "$commands[pyenv]" ]] && {
    pyenv init - --no-rehash >| "$ZDOTDIR/completions/_pyenv"
} &!


function pip() {
    if [[ -z $_comps[pip] ]]; then
        source <(pip completion --zsh)
    fi
    command pip "$@"
}

[[ -z $_comps[pip] && ! -s $ZDOTDIR/completions/_pip_completion && $commands[pip] ]] && {
    pip completion --zsh >| "$ZDOTDIR/completions/_pip_completion"
} &!

function pipx() {
    if [[ -z $_comps[pipx] ]]; then
        source <(register-python-argcomplete pipx)
    fi
    command pipx "$@"
}

[[ -z $_comps[pipx] && ! -s $ZDOTDIR/completions/_python_argcomplete && -n "$commands[pipx]" ]] && {
    register-python-argcomplete pipx >| "$ZDOTDIR/completions/_python_argcomplete"
} &!


function pipenv() {
    if [[ -z $_comps[pipenv]  ]]; then
        source <(pipenv --completion)
    fi
    command pipenv "$@"
}

[[ -z $_comps[pipenv] && ! -s $ZDOTDIR/completions/_pipenv && -n "$commands[pipenv]" ]] && {
    pipenv completion  >| "$ZDOTDIR/completions/_pipenv"
} &!





#-- rust
#   fpatg _rustup  'rustup completions zsh'
#   fpath _cargo   'rustup completions zsh cargo'
#



# pip completion
# "esc/conda-zsh-completion"


# echo $functions[$_comps[bun]]
# echo $functions_source[$_comps[bun]]
[[ -z $_comps[bun] && ! -s $ZDOTDIR/completions/_bun && -s $HOME/.bun/_bun ]] &&  {
    ln -sf "$HOME/.bun/_bun" "$ZDOTDIR/completions/_bun"
} &!



[[ -z $_comps[ngrok] && ! -s $ZDOTDIR/completions/_ngrok && $commands[ngrok] ]] && {
     ngrok completion >| "$ZDOTDIR/completions/_ngrok"
} &!

# android
export ANDROID_HOME=/usr/local/share/android-sdk
export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
export ANDROID_NDK_HOME=/usr/local/share/android-ndk





# `man zshmodules` -> `zsh/zutil`



# zstyle ':vsc_info:*' enable git

# Git integration in prompt
# autoload -Uz vcs_info # Load version control info
# precmd() { vcs_info } # Update vcs_info before each command
# zstyle ':vcs_info:git:*' formats ' (%b)' # Format for git branch
# setopt PROMPT_SUBST # Enable prompt string expansion

# rm -f ${ZDOTDIR:-$HOME}/.zcompdump


autoload -Uz compinit
ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump

# ensure compinit directory
[[ ! -d $ZSH_COMPDUMP ]] && mkdir -p $ZSH_COMPDUMP:h # $(dirname $ZSH_COMPDUMP)


if [[ $ZSH_COMPDUMP(#qNmh+24) ]]; then  # full compinit per day
    # rm -f "$ZSH_COMPDUMP*"
    # compinit will create the dump file if there isn't one already
    # use option `-u` to make all files found used without asking
    compinit -i -d "$ZSH_COMPDUMP"
else
    # ignore all insecure files and directories use the option `-i`
    # compaudit not owned by root or current user
    # group or world writable directory
    # skips the compaudit
    compinit -C -d "$ZSH_COMPDUMP"
fi


# Compile the completion dump to boost startup speed. Run in background.
{
    # if zcompdump file exists, and we don't have a compiled version or the
    # if dump file is newer than the compiled file
    if [[ -s $ZSH_COMPDUMP && (! -s ${ZSH_COMPDUMP}.zwc || $ZSH_COMPDUMP -nt ${ZSH_COMPDUMP}.zwc) ]]; then
        zcompile  $ZSH_COMPDUMP
    fi
} &!


#-- completin style
# :completion:<function>:<completer>:<command>:<argument>:<tag>
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"


# menu select, menu scroll
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'


#-- completin option
setopt MENU_COMPLETE # select the first match given by the completion menu


# defer loading on invocation
# after_startup
