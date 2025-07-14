
# config base dir
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim' 
export VISUAL='nvim'

# starship prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# alias
alias logpretty="git log --graph --oneline --all"
alias logref="git log --pretty=reference --graph "
alias logstat="git log --stat"
# proxy
export https_proxy=http://127.0.0.1:6152;
export http_proxy=http://127.0.0.1:6152;
export all_proxy=socks5://127.0.0.1:6153
export grpc_proxy=http://127.0.0.1:6152;
export http2_proxy=http://127.0.0.1:6152;
export no_proxy=localhost,127.0.0.1;


# feedback for config reload
# neofetch --backend off
# figlet -f standard "Bump!"



###############################################################################
# Prompts
# see  https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html                                                                 #
###############################################################################

[[  -e ~/.p10k.zsh ]] || source ~/.p10k.zsh


# zstyle ':vsc_info:*' enable git

# Git integration in prompt
autoload -Uz vcs_info # Load version control info
precmd() { vcs_info } # Update vcs_info before each command
zstyle ':vcs_info:git:*' formats ' (%b)' # Format for git branch
setopt PROMPT_SUBST # Enable prompt string expansion


# autoload -U colors && colors
# PS1='[\u@\h%-1d \w]✗%? '
# PS1='%F{blue}%B%~%b%f ✗%? '
# RPROMPT=

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
type starship_zle-keymap-select >/dev/null || { eval "$(starship init zsh)" } # this load starship

#################################################################################
# subcommands options suggestion
#################################################################################

#################################################################################
# Completion
# see https://github.com/zsh-users/zsh-completions/tree/HEAD
# add as submodule or cherry-pick the specific completions
# `git -C $ZDOTDIR/completions pull`
# go,python,node,bun,rust,kubctl,docker,
# feat(completion): print completion code to stdout instead modify shell config
# see https://github.com/pnpm/pnpm/pull/7597

# kubectl completion zsh
# helm completion
# pnpm install-completion zsh
# stripe completion
# $ZDOTDIR/.zcompdump
# $ZDOTDIR/.zcompcache
# locate the path of functtion
# compinit, compdef, compgen
# compdef _ngrok ngrok: registers _ngrok as the completion function for ngrok.
# case "$SHELL" in
#  *zsh) generate_zsh_completion ;;
#  *bash) generate_bash_completion ;;
# esac
# Keybindings
# menu select
# menu scroll
# Make `tab` and `shift+tab` cycle completions on the command line
#
# - `/usr/local/share/zsh/site-functions` (for system-wide installations)
# - `~/.config/zsh/completions` (for user-specific completions)
# completion defer loading
###############################################################################


# fpath=("${XDG_CONFIG_HOME-:./zsh/completions}" $fpath)
fpath+="${XDG_CONFIG_HOME:-$HOME/.config/zsh}/completions"

case "$OSTYPE" in
    darwin*)
        fpath+=("$(brew --prefix)/share/zsh/site-functions")
        ;;
    *) ;;
esac

function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        # source <(command kubectl completion zsh)
        #
        # kubectl completion zsh 2> /dev/null >| "$ZDOTDIR/completions/_kubectl" &|
        # command kubectl completion zsh >| "$ZDOTDIR/completions/_kubectl"
        kubectl completion zsh 2> /dev/null >| "$ZDOTDIR/completions/_kubectl" &|
    fi

    command kubectl "$@"
}

function ngrok() {
    if ! type _ngrok >/dev/null 2>&1; then
        # source <(command ngrok completion)
        ngrok completion 2> /dev/null >| "$ZDOTDIR/completions/_ngrok" &|
    fi
    command ngrok "$@"
}


function pnpm() {
    if ! type _pnpm >/dev/null 2>&1; then
        pnpm completion zsh 2> /dev/null >| "$ZDOTDIR/completions/_pnpm" &|
    fi
    command pnpm "$@"
}

function pip() {
    if ! type _pip >/dev/null 2>&1; then
        pip completion --zsh 2> /dev/null >| "$ZDOTDIR/completions/_pnpm" &|
    fi
    command pnpm "$@"
}




# zsh_add_completion "esc/conda-zsh-completion"
zsh_add_completion "_bun"
zsh_add_completion "_openssl"

autoload -U compinit; compinit
zstyle ':completion:*' menu select

####################################################################################
# Syntax Hightlight                                                                #
# see https://github.com/zsh-users/zsh-syntax-highlighting/tree/feature/redrawhook #
####################################################################################

###############################################################################
# Options
# set -o | less
###############################################################################

setopt appendhistory
setopt sharehistory
setopt HIST_SAVE_NO_DUPS


###############################################################################
# Alias
# check alias apply `alias`
###############################################################################

[[ -e $ZDOTDIR/.zalias.zsh ]] && source $ZDOTDIR/.zalias.zsh

###############################################################################
# Line EDITOR
# zle -al
###############################################################################

[[ -e ./zlerc.zsh ]] && source './zlerc.zsh'


###############################################################################
# Plugins & Integrations                                                          #
###############################################################################

# directory jump
eval "$(zoxide init --cmd cd zsh)"

