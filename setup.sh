#!/usr/bin/env zsh

set -o errexit   # exit on fail
set -o pipefail  # catch errors in pipelines
set -o nounset   # exit on undeclared variable
# set -o xtrace    # trace execution


# setup wizard
# teardown previous
# hyperland gnome dwm
# .cert
#

# gnome kde
# os = 'x86_64-linux'
# os = 'arrch64-darwin'

# home.username =
# home.homeDirectory =

# standalone installation

set -e



# to abosolut path of current dir
export DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
if [[ ! -e /etc/zshenv ]]; then
    sudo touch /etc/zshenv
fi
if ! grep -q 'export ZDOTDIR=' /etc/zshenv; then
    # tell zsh wherer to look for startup file
    echo 'export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"' | sudo tee -a /etc/zshenv
fi

#  COLORS=(
#     [RED]='\033[0;31m'
#     [GREEN]='\033[0;32m'
#     [YELLOW]='\033[1;33m'
#     [BLUE]='\033[0;34m'
# )
# Package configurations

sync_vscode() {
    ln -sf $HOME/dotfiles/editor/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
    ln -sf $HOME/dotfiles/editor/vscode/extensions.json $HOME/Library/Application\ Support/Code/User/extensions.json
    ln -sf  $HOME/dotfiles/editor/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
    ln -sF  $HOME/dotfiles/editor/vscode/snippets $HOME/Library/Application\ Support/Code/User/snippets
}

 packages=(
    ["$DOTFILES/homebrew"]="$HOME/.config/homebrew"
    ["$DOTFILES/git"]="$HOME/.config/git"
    ["$DOTFILES/xterm/ghostty"]="$HOME/.config/ghostty"
    ["$DOTFILES/shell/zsh"]="$ZDOTDIR"
    ["$DOTFILES/starship"]="$HOME/.config/starship"
    ["$DOTFILES/editor/nvim"]="$HOME/.config/nvim"
    ["$DOTFILES/npm/.npmrc"]="$HOME/.npmrc"
)


# Link src to dest
# overwrite if target exist
# backup if target exists

safe_link() {
    local origin=$1
    local target=$2

    # Create parent directory if needed
    [[ ! -d $target ]] && mkdir -p "${target:h}"

    [[ -s $target ]] && {
        echo "$target already exists in home directory"
        echo "(1) Remove $target and create symlink to ~/.dotfiles/$target"
        echo "(2) Backup $target to ~/.dotfiles/$target.bak and create symlink to ~/.dotfiles/$target"
        read -p "" -r

        mv $target $target.bak
        ln -s $origin $target
    }






}

# Link each package to its destination
for src in ${(k)packages}; do
     dest=${packages[$src]}
    safe_link $src $dest
done



# setup default shell for terminal emulator

# if [[ $SHELL != 'zsh' ]]; then
#     sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)
# fi
# source $ZDOTDIR/.zshrc
# exec zsh
error() {
  printf "\033[31merror\033[0m: $*\n" >&2
}


check_tools_requested() {
      if ! command -v ansible-playbook &> /dev/null; then
      echo "Command ansible-playbook could not be found!"
      echo
      echo "You can install ansible by below commands:"
      echo
      echo "pipx install --include-deps ansible"
      exit 1
    fi
}



setup_shell() {
  local SHELL_NAME
  local SHELL_PATH
  IFS= read -r -d '' SHELL_NAME || {
    error "$SHELL_NAME is not exist in PATH env vars"
    return 1
  }
  if ! grep -qxF $SHELL_PATH /etc/shells; then
      echo $SHELL_PATH | sudo tee -a /etc/shells
  fi
  chsh -s $SHELL_PATH
}



show_usage() {
   cat << EOF
Usage: setup.zsh [OPTIONS]

Options:
    --help       print this help and exit
    --check     check for required dependencies

Examples:
    setup.sh                    # Install from current directory
    $SCRIPT_NAME ~/Downloads/fonts  # Install from specific directory
EOF
  exit 0
}
while test $# -gt 0; do
  case "$1" in
      --check) ANSIBLE_PLAYBOOK_ARGS+=("--check");;
      --help) usage;;
      --*) echo "bad option $1";;
        *) usage;;
  esac
  shift
done

cd ./ansible
ansible-galaxy collection install -r requirements.yml --upgrade
ansible-playbook --ask-become-pass setup.yml ${ANSIBLE_PLAYBOOK_ARGS[@]}
