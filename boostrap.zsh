#!/usr/bin/env zsh

[[ -n $HOME/.hushlogin ]] && touch $HOME/.hushlogin

# fonts
# terminal

#


info() {
  printf "\033[36m$*\033[0m\n"
}

warn() {
  printf "\033[33m$*\033[0m\n"
}

error() {
  printf "\033[31merror\033[0m: $*\n" >&2
}

fatal() {
  error "$@"
  exit 1
}




function discover_platform() {

  local platform=$(uname)/$(uname -m)
  # platform=$(printf '%s' "$platform" | command tr '[A-Z]' '[a-z]')
  platform=$(printf '%s' "$platform" | command tr '[:upper:]' '[:lower:]')

  case "$platform" in
    'darwin/arm64');;
    'darwin/x86_64');;
    'linux/aarch64');;
    'linux/x86_64');;
    *)
      fatal "Unsupported platform: $platform"
    ;;
  esac
  echo $platform
}


function fs-watcher-clean() {
   if [[ "$OSTYPE" == "darwin"* ]]; then
        sudo sysctl -w kern.maxfiles=524288
        sudo sysctl -w kern.maxfilesperproc=524288
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo sysctl -n -w fs.inotify.max_queued_events=524288
        sudo sysctl -n -w fs.inotify.max_user_instances=512
        sudo sysctl -n -w fs.inotify.max_user_watches=524288
    fi
}



function init_homebrew() {

    # install from release
    # install from main branch
    if [[ -z $commands[brew] ]];  then
       bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      # post-homebrew install
      # echo 'eval "$(brew shellenv)"' >> $HOME/.zprofile
      chmod +x $DOTFILES/homebrew/run-brewfile.zsh && $XDG_CONFIG_HOME/homebrew/run-brewfile.zsh
    fi

}


function init_nix() {

  # create initial configuration in current directory and activate it
}


profile() {
  SHELL_PATH=${SHELL:-"/bin/sh"}

  case $SHELL_PATH in
    */zsh)
      PROFILE=${ZDOTDIR:-$HOME}/.zshrc ;;
    */bash)
      PROFILE=${BASHRC:-$HOME}/.bashrc ;;
    */fish)
      PROFILE=${FISH_CONFIG_DIR:-$HOME/.config/fish}/config.fish ;;
  esac

  info "Configuring path variable in ~${PROFILE#$HOME}..."
}



# source ./install.sh

# source ./.macos
