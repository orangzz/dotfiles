# Prompts
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# On the left prompt:
# show only current dir and its parent
# show vi mode indicator and the last command exit status
# On the right prompt:
# vcs_info(branch name, count commits ahead or behind of remote, working tree dirty action: rebase or merge, revert, cherry-pick, bisect)

# autoload -Uz vcs_info
# precmd() vcs_info

# autoload -U promptinit; promptinit
# prompt pure
# starship
# powerlevel10k

# `%F{<color>} %f` - Change the foreground color with <color>.
# `%K{<color>} %k` - Change the background color with <color>.
# `%B %b` - Bold.
# `%U %u` - Underline.

# [[  -r ~/.p10k.zsh ]] || . ~/.p10k.zsh

# autoload -U colors && colors

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
[[ $widgets[starship_zle-keymap-select] ]] || {
  eval "$(starship init zsh)"
}
