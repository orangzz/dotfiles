one of struggle of zsh is find command in its man page that's why this cheatsheet exists

zsh-quickstart-kit
awesome-zsh-plugins

## String

```zsh
# pad / trim
# trim leading and trailing space
# echo "$str" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
# substitute the value of name with the matched portion deleted
# `#` removes at the start of the portion, `#` is the shortest match, and `##` is the longest.


# ${name#pattern}
# ${name##pattern}
# `%` removes at the end of the string, `%` is the shortest match, and `%%` is the longest.

Get index of a value in an array (0 if not found)	${VARNAME[(Ie)value]}
Get index of a value in an array (${#VARNAME} + 1 if not found)	${VARNAME[(ie)value]}


# startsWith
if [[ $VARNAME = "startstr"* ]]
# contain
if [[ $VARNAME = *"substring"* ]]
# endsWith
if [[ $VARNAME = *"substring" ]]

```

`$@`: Preserves each argument as separate entities
`$*`: Joins all arguments into a single string

## Function

trap functions
hook functions
autoloading functions
hook-like functions
API-like function

## `add-zsh-hook`

https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions

:warning: If you call `zplugin` outside your `.zshrc` file, the plugin you sourced will not be sourced at the next shell reload.

# add-zsh-hook precmd vcs_info

# builtin hook is one of chpwd, precmd, preexec, periodic, zshaddhistory,

## Compsys

executable script or autoloaded function

`compdef()`: bind completion functions to commands
`compadd()`
`_arguments()`:

```zsh
(( ${+functions[compdef]} ))

```

store function used to completing commands in a file call `_<cmd>`,
place file in one of directory in `$fpath`,
or create a directory in own home directory, and prepend that directory
to the list in `$fpath`

```

# organized shell config, consider performance

# restart shell:
# - Open a new tab or window in your terminal.
# - Replace the current shell with a new one: `exec zsh`
# reload config `source $ZDOTDIR/.zshrc`


# alias expansion

# parameter substitution `${parameter}`
# command substitution `$(command)`
# process substitution `<(process)`
# `man zshall`
# `man zshbuiltins` autoload emulate
#  eval: Execute arguments as a shell command.
# `man zshoptions`
# `man zshzle`


#=== parameter expansion and substitution ===
# `man zshparam`
# ${name:+word}    # Use word if name is set AND non-empty
# ${name:-word}    # Use word if name is unset OR empty
# ${name:=word}    # Set name to word if unset OR empty, then use it

# variable expansian modifier
# each preceded by a ‘:’.
# :t - tail modifier: $(basename $1) ${1##*/} remove all leading pathname segment(keep filename)
# :h - head modifier: $(dirname $1) ${1%/*} remove  trailing pathname segment(keep directory)
#  a      Turn a file name into an absolute path:  prepends the current directory, if necessary; remove `.' path segments; and remove `..' path segments and the segments that immediately precede them.
#  A      Turn a file name into an absolute path as the `a' modifier does, and then pass the result through the realpath(3) library function to resolve symbolic links.

Parameter Expansion Flags



# `man zshexpen` -> `/Glob Qualifiers`
# N    sets the NULL_GLOB option for the current pattern
# /      directories
# .      plain files
#  @      symbolic links
#  =      sockets


#  Subscript Flags
# ${(k)array}  # Get the keys of an associative array
# ${(v)array}  # Get the values of an associative array
# `#` = "strip this prefix from each element
# `:#` = "Remove elements that match this pattern"




# substr/slicing
# ${str[start,end]}
# Escape
# join/split
# spe=:,  sep="\x00" null character


# https://zsh.sourceforge.io/Doc/Release/Arithmetic-Evaluation.html
# ${+name} If name is set, `1' is substituted, otherwise `0' is substituted.

# (( ${+terminfo[cuu]} && ${+terminfo[ed]} && ${+terminfo[sc]} && ${+terminfo[rc]} )) || return 0

```

man zshmisc
