# subcommands completion

#+───────────┬───────────────────────┬
#│ Keystroke │     Bash Function     │       Zsh Function
#├───────────┼───────────────────────┼
#│  CTRL-t   │   __fzf_select__      │          __fsel
#├───────────┼───────────────────────┼
#│  CTRL-r   │   __fzf_history__     │   fzf-history-widget
#├───────────┼───────────────────────┼
#│  ALT-c    │   __fzf_cd__          │   fzf-cd-widget
#+───────────┴───────────────────────┴


# _fzf_compgen_path
# _fzf_compgen_dir

# _fzf_compgen_path() {
    # rg --files --glob "!.git" . "$1"
# }

# _fzf_compgen_dir() {
   # fd --type d --hidden --follow --exclude ".git" . "$1"
# }
