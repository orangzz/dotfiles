###############################################################################
# Plugins
# check alias apply `alias`
# [[ -e $ZDOTDIR/alias.zsh ]] && . $ZDOTDIR/alias.zsh
###############################################################################




###############################################################################
# [See the details of these options](https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html)
# On the left prompt:
# PS1='[\u@\h%-1d] $F{%(?.green.red)}✗ '
# show only current dir and its parent
# show vins mode or vicmd mode and the last command exit status
# On the right prmpots:
# vcs_info(branch name, count commits ahead or behind of remote, wokring tree dirty action: rebase or merge, revert, cherry-pick,bisect) , viins or vicmd mode


# `%F{<color>} %f` - Change the foreground color with <color>.
# `%K{<color>} %k` - Change the background color with <color>.
# `%B %b` - Bold.
# `%U %u` - Underline.

###############################################################################

# [[  -r ~/.p10k.zsh ]] || . ~/.p10k.zsh

# autoload -U colors && colors

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
[[ $widgets[starship_zle-keymap-select] ]] || { eval "$(starship init zsh)" } # this load starship
