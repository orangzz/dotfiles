###############################################################################
# Alias
# check alias apply `alias`
# [[ -e $ZDOTDIR/alias.zsh ]] && . $ZDOTDIR/alias.zsh
###############################################################################



alias zrc="$EDITOR $ZDOTDIR/.zshrc"
alias fpath="print -l $fpath"
alias path="print -l $path"
alias manpath="print -l $manpath"

# modern aleternative

if command -v bat &> /dev/null; then
  alias cat="bat --plain --theme zenburn"
  alias bcat="bat --theme zenburn"
fi

alias v='nvim'
alias find="fd"
alias grep="rg"
# ls directory content with pager, icon, color
# `--quit-if-one-screen` exit if the entire output can be displayed on one screen.
# `--RAW-CONTROL-CHARS`  allows ANSI "color" escape sequences to be output in their raw form. This means that if the input contains color codes (like from `ls --color`), they will be interpreted by the terminal and the output will be colored.
# `--no-init` prevent the clear the output on the screen after you exit `less`.
# alias ls='lsd -la | less -FRX'
alias ls="lsd -la"
alias tree="lsd -la --tree --color=always --icon=always | less -FRX"

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias rmdir='rmdir -v'



# Terraform and Terragrunt
alias tff="terraform fmt --recursive"
alias tg="terragrunt"
alias tgp="terragrunt plan"
alias tga="terragrunt apply"
alias tgf="terragrunt hclfmt"
alias tfclean="rm -rf .terraform .terraform.lock.hcl backend.tf providers.tf"

alias kctx='kubectx'








###############################################################################
# System monitor: disk, memory, netowork, process                                                                     #
###############################################################################

alias df='df -h'
alias free='free -m'
alias psmem='ps auxf | sort -nr -k 4 | head -5'
alias pscpus='ps auxf | sort -nr -k 3 | head -5'


# power off, halt
alias shutdown="sudo shutdown -p now"
alias reboot="sudo shutdown -r now"
alias flushdns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"





###############################################################################
# Docker
###############################################################################

alias dockls='docker ps --format "table {{.Names}}\t{{.Status}}"'
alias dockstats='docker ps -q | xargs docker stats'
alias dockrs=''



case "$(uname -s)" in
    Darwin)
        ;;
    Linux)
        alias ls='ls --color=auto'
        ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*|)
        echo "MS Windows"
    ;;
    *)
        ;;
esac


###############################################################################
# Git
###############################################################################


alias lg="lazygit"
alias gs="git status"


# alias glpretty="git log --graph --oneline --all"
alias gl="git log --graph --format='%C(yellow)%h%Creset - %s %Cgreen(%cr) %C(blue)%an %Creset'"
alias glref="git log --pretty=reference --graph "
alias gd="git diff --stat --patch"
alias gane="git commit --amend --no-edit"
###############################################################################
# Navigating the Direcotry tree
# broot
# y
#   ..  to go one dir up
#   ~   to go to your home dir
#   ~-2 to go to the 2nd mostly recently visited dir
#   /   to go to the root dir
setopt AUTO_CD
###############################################################################


alias ..="cd .."
alias ...="cd .. && cd .."
alias ....="cd .. && cd .. && cd .."
