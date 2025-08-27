# ================================
# ZSH KEY BINDINGS CONFIGURATION
# ================================

# Enable vi mode
bindkey -v

# ================================
# Set cursor mode based on vi mode
# ================================


# Insert mode could be
# `i` (insert)
# `a` (append)
# `I` (insert at the non-blank beginning of current line)
# `A` (append at the end of current line)
# ZVM_INSERT_MODE='i'

# The mode could be the below value:
# `n` (normal)
# `i` (insert)
# `v` (visual)
# `vl` (visual-line)
# ZVM_MODE=''

# Define cursor styles
local CURSOR_BLOCK='\e[2 q'
local CURSOR_BEAM='\e[5 q'
local CURSOR_BLINKING_BLOCK='\e[1 q'
local CURSOR_UNDERLINE='\e[4 q'

# Register ZLE widgets

zle-keymap-select() {
    case $KEYMAP in
        vicmd) echo -ne $CURSOR_BLOCKk;;    # Command mode: block cursor
        viins|main) echo -ne $CURSOR_BLINKING_BLOCK;; # Insert mode: blinking block cursor
    esac
}
zle -N zle-keymap-select

# Initialize with BLOCK cursor
function zle-line-init {
    echo -ne $CURSOR_BLINKING_BLOCK
}
zle -N zle-line-init

function zle-line-finish {
    echo -ne $CURSOR_BEAM
}
zle -N zle-line-finish




# Ensure beam cursor on new prompt
# preexec precmd() {
#     echo -ne $cursor_beam
# }





# ================================
# TERMINAL KEY MAPPINGS
# ================================

# Define terminal-specific keys using terminfo
typeset -A key
key=(
    BackSpace  "${terminfo[kbs]}"
    Home       "${terminfo[khome]}"
    End        "${terminfo[kend]}"
    Insert     "${terminfo[kich1]}"
    Delete     "${terminfo[kdch1]}"
    Up         "${terminfo[kcuu1]}"
    Down       "${terminfo[kcud1]}"
    Left       "${terminfo[kcub1]}"
    Right      "${terminfo[kcuf1]}"
    PageUp     "${terminfo[kpp]}"
    PageDown   "${terminfo[knp]}"
)

# Helper function to bind keys across multiple keymaps
bind2maps() {
    local i sequence widget
    local -a maps

    # Collect keymaps until '--'
    while [[ "$1" != "--" ]]; do
        maps+=( "$1" )
        shift
    done
    shift

    sequence="${key[$1]}"
    widget="$2"

    [[ -z "$sequence" ]] && return 1

    for i in "${maps[@]}"; do
        bindkey -M "$i" "$sequence" "$widget"
    done
}

# Bind terminal keys across keymaps
bind2maps emacs             -- Delete      delete-char
bind2maps       viins vicmd -- Delete      vi-delete-char
bind2maps emacs viins vicmd -- Up          up-line-or-history
bind2maps emacs viins vicmd -- Down        down-line-or-history
bind2maps emacs             -- Left        backward-char
bind2maps       viins vicmd -- Left        vi-backward-char
bind2maps emacs             -- Right       forward-char
bind2maps       viins vicmd -- Right       vi-forward-char

bindkey undo Ctrl+/   Shift+Tab  # undo the last command line change
bindkey redo Option+/            # redo the last undone command line change

bindkey cd-back       # cd into the previous directory
bindkey cd-forward    # cd into the next directory
bindkey cd-up         # cd into the parent directory
bindkey cd-down       # cd into a child directory

# ================================
# surround
# ================================

bindkey -M vicmd 'cs' change-surround
bindkey -M vicmd 'ds' delete-surround
bindkey -M vicmd 'as' add-surround
bindkey -M vicmd 'cis' change-inside-surround



# ================================
# COMPLETION BINDINGS
# ================================

# Tab completion navigation
bindkey '^I' menu-complete                    # Tab: forward through completions
bindkey "$terminfo[kcbt]" reverse-menu-complete # Shift-Tab: backward through completions

# ================================
# HISTORY SEARCH
# ================================

# Load history search functions
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# History search bindings
bindkey -M viins '^[[A' history-beginning-search-backward    # Up arrow
bindkey -M viins '^[[B' history-beginning-search-forward     # Down arrow
bindkey -M vicmd 'k' history-substring-search-up             # k in command mode
bindkey -M vicmd 'j' history-substring-search-down           # j in command mode
bindkey '^R' history-incremental-search-backward             # Ctrl-R


# ================================
# COMMAND LINE EDITING
# ================================

# Edit command line in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

# Command Line navigation
bindkey -M viins '^[[7~' beginning-of-line    # Home key alternative

# ================================
# UTILITY FUNCTIONS
# ================================

# Alt-H: Get help on current command
unalias run-help 2>/dev/null
autoload -RUz run-help

# Alt-Shift-S: Prefix command with sudo
() {
    bindkey '^[S' $1
    zle -N $1
    $1() {
        # Load previous command if current line is empty
        [[ $BUFFER == [[:space:]]# ]] && zle .up-history
        # Add sudo while preserving cursor position
        LBUFFER="sudo $LBUFFER"
    }
} .sudo

# ================================
# NOTES & REFERENCE
# ================================

# Key binding commands:
# bindkey -l                    - List all keymaps
# bindkey -M <keymap>          - Show bindings for keymap
# bindkey -M <keymap> <key>    - Show widget for specific key
# bindkey -M <keymap> -r <key> - Remove binding

# Special characters:
# \e = Alt/Meta key
# ^  = Ctrl key

# Common keymaps:
# emacs  - Emacs emulation
# viins  - Vi insert mode
# vicmd  - Vi command mode
# isearch - Incremental search
