# bindkey -l - Output the list of all available keymaps.
# bindkey -M <keymap> - Output all the keybindings for the keymap <keymap>. For example: bindkey -M viins.
# bindkey -M <keymap> <keystroke> - Output the widget bound to the keystroke <keystroke> for the keymap <keymap>. For example: bindkey -M vicmd u.
# bindkey -M <keymap> -r <keystroke> - Delete the binding mapped to the keystroke <keystroke> for the keymap <keymap>. For example: bindkey -M vicmd -r '^l'
# bindkey <keystroke> <widget>
# `\e` stands for <alt>
# `^`  stands for <ctrl>.


# keymap(as a collection of keyboard shortcuts )
# emacs: emacs emulation
# viins: vi emulation (insert mode)
# vicmd: vi emulation (command mode)
# isearch: incremental search mode
# command: command reading mode
# .safe: fallback keymap (cannot be deleted)

# terminfo

# view the list of shortcut for a keymaps
# bindkey -M vicmd
# bindkey -M emacs

# bindkey -A viins main


# bindkey '^l' clear-screen
# bindkey "^u" kill-whole-line
# bindkey "^k" kill-line
# # bindkey "^w" backward-kill-line
# bindkey "^w" backward-kill-word
# bindkey "^a" beginning-of-line
# bindkey "^e" end-of-line
# bindkey "^f" forward-char
# bindkey "^b" backward-char
# bindkey "\eb" backward-word
# bindkey "\ef" forward-word

# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

# bindkey '^p' histroy-search-backward
# bindkey '^n' histroy-search-forward

# # zoxide
# bindkey "^[" prev    #  Previous window
# bindkey -M ecmas "\e\ " next    #  Next window

##
# Alt-H: Get help on your current command.
#
unalias run-help 2> /dev/null   # Remove the simple default.
autoload -RUz run-help         # -R resolves the function immediately, so we can access the source dir.


# Load $functions_source, an associative array (a.k.a. dictionary, hash table
# or map) that maps each function to its source file.



# Alt-Shift-S: Prefix the current or previous command line with `sudo`.
() {
  bindkey '^[S' $1  # Bind Alt-Shift-S to the widget below.
  zle -N $1         # Create a widget that calls the function below.
  $1() {            # Create the function.
    # If the command line is empty or just whitespace, then first load the
    # previous line.
    [[ $BUFFER == [[:space:]]# ]] &&
        zle .up-history

    # $LBUFFER is the part of the command line that's left of the cursor. This
    # way, we preserve the cursor's position.
    LBUFFER="sudo $LBUFFER"
  }
} .sudo

# remap caps to esc


bindkey -v
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

  function bind2maps () {
      local i sequence widget
      local -a maps
      # collect keymap until hit '--'
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
  bind2maps emacs             -- Delete      delete-char
  bind2maps       viins vicmd -- Delete      vi-delete-char
  bind2maps emacs viins vicmd -- Up          up-line-or-history
  bind2maps emacs viins vicmd -- Down        down-line-or-history
  bind2maps emacs             -- Left        backward-char
  bind2maps       viins vicmd -- Left        vi-backward-char
  bind2maps emacs             -- Right       forward-char
  bind2maps       viins vicmd -- Right       vi-forward-char

#-- Reassign keys
# Make `<tab>` and `<shift-tab>` cycle completions
bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete
# Make `<enter>` submit the command line, even when you are in the menu
# bindkey -M menuselect '^M' .accept-line


# ctrl+v for inspect escape sequence
# zle -la
# man zshzle

# open editor
autoload -z edit-commnad-line
zle -N edit-command-line
bindkey -M vicmd vv edit-command-line





bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround

bindkey -M viins '^[[7~' beginning-of-line


# Search history with arrow keys
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search # Register up-line-or-beginning-search as a zle widget
zle -N down-line-or-beginning-search # Register down-line-or-beginning-search as a zle widget



# bindkey '^[[A' up-line-or-beginning-search    # Up arrow for history search
# bindkey '^[[B' down-line-or-beginning-search  # Down arrow for history search

bindkey -M viins '^[[A' history-beginning-search-backward
bindkey -M viins '^[[B' history-beginning-search-forward
# bindkey -M viins '^[[A' history-substring-search-up  # Up arrow for history search
# bindkey -M viins '^[[B' history-substring-search-down # Down arrow for history search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^R' history-incremental-search-backward
# End of search history with arrow keys



# surround
bindkey -M vicmd add add-surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
# around
# inside


local cursor_block='\e[2 q'
local cursor_beam='\e[5 q'

    function zle-keymap-select {
        case $KEYMAP in
            vicmd) echo -ne $cusor_block;;
            vins|main) echo -ne $cursor_beam;;
        esac
    }

    zle-line-init() {
        zle -K viins
        echo -ne $cursor_beam
    }

zle -N zle-keymap-select
zle -N zle-line-init
echo -ne $cursor_beam
preexec() { echo -ne $cursor_beam }




# window management
# resize
# new
# back/for
