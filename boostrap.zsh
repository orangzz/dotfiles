#!/usr/bin/env zsh

platform=$(command uname -sm)
platform=$(printf '%s' "$platform" | command tr '[A-Z]' '[a-z]')

case "$platform" in
  'darwin arm64');;
  'darwin x86_64');;
  'linux aarch64');;
  'linux x86_64');;
  *)
    >&2 'printf' '\033[33mz4h\033[0m: sorry, unsupported platform: \033[31m%s\033[0m\n' "$platform"
    'exit' '1'
  ;;
esac


DOTFILES="${DOTFILES:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"

function init_homebrew() {

    # install from release
    # install from main branch
    if [[ $(which brew) ]];  then
      commnad bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      # post-homebrew install
      # echo 'eval "$(brew shellenv)"' >> $HOME/.zprofile
    fi

}









# source ./install.sh

# source ./.macos
