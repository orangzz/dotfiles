###############################################################################
# The Order and Condition are sourced
# organzied shell config, consider performance

# restart shell:
# - Open a new tab or window in your terminal.
# - Replace the current shell with a new one: `exec zsh`
# reload config `source $ZDOTDIR/.zshrc`

# `man zshexpn` - zsh expansion and substitution
# alias expansion
# command substitution `$(command)`
# parameter subtituion `${parameter}` `man zshparam`
# processs subtitution `<(process)`
# `man zshall`
# `man zshbuiltins` autoload emulate
#  eval: Execute arguments as a shell command.
# `man param`
# `man zshoptions`
# `man zshzle`
###############################################################################


# startup time profiling and benchmark

zmodload zsh/zprof






# zsh syntax hightlighting
# shell fonts



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



#################################################################################
# subcommands options suggestion
#################################################################################

zsh_add_file "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
####################################################################################
# Completion
####################################################################################

[[ -s $ZDOTDIR/.zcomp.zsh ]] && source $ZDOTDIR/.zcomp.zsh


####################################################################################
# Syntax Hightlight                                                                #
# see https://github.com/zsh-users/zsh-syntax-highlighting/tree/feature/redrawhook #
####################################################################################

###############################################################################
# Options
# set -o | less
###############################################################################

setopt autocd
setopt appendhistory
setopt sharehistory
setopt HIST_SAVE_NO_DUPS




###############################################################################
# Line EDITOR
# zle -al
###############################################################################

[[ -e ./zlerc.zsh ]] && source './zlerc.zsh'


###############################################################################
# Plugins & Integrations
# Terminal status bar
###############################################################################

# directory jump
eval "$(zoxide init --cmd cd zsh)"

source <(fzf --zsh)





###############################################################################
# Scripts
###############################################################################

autoload -Uz add-zsh-hook

function add_execute_permission {
  # Loop through all files in the $DOTFILES/scripts directory that are newly created
  find $DOTFILES/scripts -type f -exec chmod +x {} \;
}

add-zsh-hook chpwd add_execute_permission
# add-zsh-hook precmd vcs_info

# Local config
if [[ -e "$HOME/.localrc" ]]; then
    source "$HOME/.localrc"
fi


# export GPG_TTY to work around a failure I don't really understand
GPG_TTY="$(tty)"
export GPG_TTY

zprof


() {
  # `local` sets a variable's scope to this function and its descendendants.
  local file=

  # Load all of the files in rc.d that start with <number>- and end in `.zsh`.
  # (n) sorts the results in numerical order.
  # <0->  matches any integer >= 0.
  #  <->  is the same as <0->
  # <0-9> matches any integer >= 0 and <= 9.
  #  <-9> is the same as <0-9>
  # See https://zsh.sourceforge.io/Doc/Release/Expansion.html#Glob-Operators
  for file in $ZDOTDIR/rc.d/<->-*.zsh(n); do
    . $file   # `.` is like `source`, but doesn't search your $path.
  done
} "$@"
