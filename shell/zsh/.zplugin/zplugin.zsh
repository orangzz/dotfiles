#!/usr/bin/env zsh
#  Zsh Plugin Standard compatibility
# 0 – the plugin manager provides the ZERO parameter,
# f - … supports the functions subdirectory,
# b - … supports the bin subdirectory,
# u - … the unload function,
# U - … the @zsh-plugin-run-on-unload call,
# p – … the @zsh-plugin-run-on-update call,
# i – … the zsh_loaded_plugins activity indicator,
# P – … the ZPFX global parameter,
# s – … the PMSPEC global parameter itself (i.e.: should be always present).
export PMSPEC="0fbs"



# %N indicates "The name of the script, sourced file, or shell function that zsh is currently executing,"
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"

## namespace prefix

ZPLUGIN[HOME_DIR]=$HOME/.zplugin

if [[ -z $ZPLUGIN_DIR ]]; then
  if [[ -e ${ZDOTDIR:-$HOME}/.zplugin]]; then
    ZPLUGIN_DIR=$HOME/.zplugin
  else
    # ZPLUGIN_DIR=$ZPLUGIN_SOURCE/.zplugin
    ZPLUGIN_DIR=$ZPLUGIN_SOURCE/sources
  fi
fi

path=(${0:h}/bin $path[@])
fpath=(${0:h}/functions $fpath[@])
typeset -gaU path fpath


source "${0:h}/init.zsh"
