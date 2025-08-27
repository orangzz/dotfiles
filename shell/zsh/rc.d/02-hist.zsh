# History
# http://zsh.sourceforge.net/Doc/Release/Options.html#History

# should after `/etc/zshrc` startup file loaded
# otherwise will be overwrite by config in `/etc/zshrc` `cat /etc/zshrc | grep HISTFILE`
HISTFILE=$XDG_STATE_HOME/zsh/.zsh_history
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

setopt append_history          # append to history file
setopt hist_reduce_blanks      # remove blanks from each command line being added to the history list
setopt hist_ignore_space       # trim leading and trailing whitespace
setopt inc_append_history      # write to the history file immediately, not when the shell exits
setopt hist_find_no_dups       # don't display previous found history entry
setopt hist_ignore_all_dups    # Keep only the most recent copy of each duplicate entry in history.
setopt share_history            # share history between sessions
setopt extended_history        # save command with beginning timestamp(in seconds since the epoch) and the duration (in seconds) to history file in the format of ':<start time>:<elapsed seconds>;command'
setopt hist_no_store           # don't store history commands
setopt hist_fcntl_lock        # Use modern file-locking mechanisms, for better safety & performance
setopt hist_verify             # don't execute immediately upon history expansion
unsetopt hist_beep             # don't beep when attempting to access a missing history entry

# zsh-history-substring-search
# terminfo
# share history between local and remote
