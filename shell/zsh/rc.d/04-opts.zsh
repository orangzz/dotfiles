# === ZSH Options ===
# http://zsh.sourceforge.net/Doc/Release/Options.html

# View a list of all default zsh options `emulate -lLR zsg`
# View list the shell options `setopt` state (on or off)  set -o | less

# Changing Directories
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
alias dh='dirs -v'
setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir
setopt auto_pushd              # make cd push the old directory onto the directory stack
setopt pushd_ignore_dups       # don’t push multiple copies of the same directory onto the directory stack
setopt pushd_minus             # swapped the meaning of cd +1 and cd -1
setopt pushdsilent             # keeps the shell from printing the directory stack each time we do a cd
setopt pushd_to_home           # if no arguments are given, will push home directory to stack

# Expansion and Globbing
# http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
# Grouping,  range of integers, exclude certain files from the patterns, file type qualifiers
# *~(*.gz|*.bz2|*.xz|*.zip) -> searches for word not in compressed files
setopt extendedglob

# Job Control
# http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
unsetopt hup                  # don't kill jobs on shell exit
setopt longlistjobs           # long listing format for jobs
# Input/Output
# http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
setopt automenu             # Automatically use menu completion after the second consecutive request for
# completion
setopt interactive_comments    # enable comments in interactive shell
setopt always_to_end           # completion is inserted with cursor within a word, the cursor is moved to the end of the word
setopt complete_in_word       # completion is inserted within a word, not just at the end
setopt no_case_glob           # ~/d* is expanded into /Users/armin/Desktop /Users/armin/Documents /Users/armin/Downloads
setopt hash_executables_only   # only hash the executables
