# measures user-visible latency of interactive zsh:
# create_tty_ms=
# prompt_first_display_ms=
# command_lag_ms=
# input_lag_ms=
# just execute 'ZSH_PROFILE_RC=1 zsh' and run 'zprof' to get the details
[[ ${ZSH_PROFILE_RC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZSH_PROFILE_RC=1 zsh"
# alias zbench='for i in $(seq 1 10); do; /usr/bin/time zsh -i -c exit; done'


# found in `/etc/zsh/zshrc`
# Useful support for interacting with Terminal.app or other terminal programs
# [ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"

# found in  `/etc/zshrc_$TERM_PROGRAM`( `/etc/zshrc_Apple_Terminal`)
# ghostty will create this file if  turn on shell-integration
    # Set up the session directory/file.
    # SHELL_SESSION_DIR="${ZDOTDIR:-$HOME}/.zsh_sessions"
    # SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID.session"
    # mkdir -m 700 -p "$SHELL_SESSION_DIR"

SHELL_SESSION_DIR=$XDG_STATE_HOME/zsh/.zsh_sessions
SHELL_SESSION_FILE=$SHELL_SESSION_DIR/$TERM_SESSION_ID.session



# proxy
export https_proxy=http://127.0.0.1:6152;
export http_proxy=http://127.0.0.1:6152;
export all_proxy=socks5://127.0.0.1:6153
export grpc_proxy=http://127.0.0.1:6152;
export http2_proxy=http://127.0.0.1:6152;
export no_proxy=localhost,127.0.0.1;



# ZFUNCTION=

# fpath=($ZDOTDIR/completions $fpath)

# autoload -U $ZFUNCTION/*(:t)

# see https://github.com/zsh-users/zsh-syntax-highlighting/tree/feature/redrawhook #




# Plugin Integrations
# zsh_add_file "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# directory jump
eval "$(zoxide init --cmd cd zsh)"

FZF_DEFAULT_OPTS="
--border
--height 80%
--extended
--ansi
--reverse
--cycle
--bind ctrl-s:toggle-sort
--bind 'alt-e:execute($EDITOR {} >/dev/tty </dev/tty)'
--preview \"(bat --color=always {} || ls -l --color=always {}) 2>/dev/null | head -200\"
--preview-window right:60%
"
FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git 2>/dev/null"

source <(fzf --zsh)




# autoload -Uz add-zsh-hook

# function add_execute_permission {
#   # Loop through all files in the $DOTFILES/scripts directory that are newly created
#   find $DOTFILES/scripts -type f -exec chmod +x {} \;
# }




if [[ -e "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi







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
 

##? plugin-load - load plugins without a fancy plugin manager
##?
##? usage: plugin-load [-h|--help]
##?        plugin-load [-n|--no-source] [-d|--defer] [-f|--fpath] [-p|--path]
##?        [-u|--use-dir <plugin-subdir>] [<repo...>]

ZPLUGIN_DIR=$HOME/.zplugin
[ -f $ZPLUGIN_DIR/zplugin.zsh ] || git -C ${ZPLUGIN_DIR:h} clone https://github.com/orangzz/zplugin.git $ZPLUGIN_DIR
source $ZPLUGIN_DIR/zplugin.zsh

zplugin load zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-history-substring-search \
    zsh-users/zsh-history-substring-search \
    zsh-users/zsh-surround

[[ "$PWD" != "/" ]] || cd

# done profiling
[[ ${ZSH_PROFILE_RC:-0} -eq 0 ]] || { unset ZSH_PROFILE_RC && zprof }




