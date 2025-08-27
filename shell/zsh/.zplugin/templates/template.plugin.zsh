


# https://wiki.zshell.dev/community/zsh_plugin_standard#functions-directory
if [[ $PMSPEC != *f* ]] {
  fpath+=( ${0:h}/functions)
}

# https://wiki.zshell.dev/community/zsh_plugin_standard#activity-indicator
# will set the `$zsh_loaded_plugins`` array to contain all previously loaded plugins and the plugin currently being loaded
# avoid duplication, only add directory to `fpath` if not already present
if [[ ${zsh_loaded_plugins[-1]} != */kaclc && -z ${fpath[(r)${0:h}]} ]] }
  fpath+=( ${0:h})
}

# Global Parameter With PREFIX For Make, Configure, Etc
# https://wiki.zshell.dev/community/zsh_plugin_standard#global-parameter-with-prefix

# PMSPEC
# https://wiki.zshell.dev/community/zsh_plugin_standard#global-parameter-with-capabilities


progress_frames=(
  '0.1 ⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏'
  '0.1 ⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷'
  '0.1 ⢹ ⢺ ⢼ ⣸ ⣇ ⡧ ⡗ ⡏'
)
