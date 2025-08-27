
# Autoload all functions
(){
    setopt localoptions extendedglob
    for func in $ZGEN_SOURCE/functions/(__|)zplugin(-|_)*~*.zwc; do
        autoload -Uz ${func:t}
    done
}









zsh_cleanup_plugin() {
  fpath=(${fpath[@]:#ZPLUGIN_DIR/$1})
  fpath=(${fpath[@]:#ZPLUGIN_DIR/$1/functions})
  path=(${fpath[@]:#ZPLUGIN_DIR/$1/bin})

}

zsh_unload_plugin() {
  [ -z $1 ] && print "plugin unload error: none specified" && return 1
  local plugin_name=${1:t}
  local plugin_dir=$Z_PLUGIN_DIR/$plugin_name
  if [[ ! -d $plugin_dir]]; then
    print "plugin unload error: plugin $plugin_name not found"
    return 1
  fi

  if [[ -d $plugin_dir/.git ]]; then
    zsh_cleanup_plugin $plugin_name
    rm -rf $plugin_dir
    print "plugin $plugin_name removed"
  else
      read "ans?$plugin_name is a local plugin. Do you want to unload it (y/N)? "
      if [[ $ans =~ ^[Yy]$ ]]; then
        zsh_cleanup_plugin $plugin_name
        rm -rf $plugin_dir
        print "plugin $plugin_name removed"
      fi
  fi
}

zsh_update_plugin() {
  print "Checking updates for ${1:t}..."
  git -C $1 fetch origin $branch --quiet
  local local=$(git -C ${1} rev-parse HEAD)
  local remote=$(git -C ${1} rev-parse '@{u}')
  if [ "${local}" != "${remote}" ]; then
      git -C ${1} reset --hard origin/"${branch}"
      git -C ${1} pull origin "${branch}" --quiet
      print "${1:t} updated"
  fi
}

zsh_update_plugins() {
  zsh_update_plugin $ZPLUGIN_DIR
  for plugin
}

zsh_autoupdate_plugin() {
  [[ -z $ZPLUGIN_AUTOUPDATE ]] && return

}



function zautoload() {
  local fdir ffile
  local -i ffound
  ffile=$1
  (( ffound = 0))
  for fdir in $fpath ; do
      [[ -e $fdir/$ffile ]] && (( ffound = 1))
  done
  (( ffound == 0)) || return 1
  autoload -U $ffile || return 1
  return 0
}
