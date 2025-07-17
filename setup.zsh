###############################################################################
# setup wizard
# cleanup



# to abosolut path of current dir
export DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
if [[ ! -e /etc/zshenv ]]; then
    sudo touch /etc/zshenv
fi
if ! grep -q 'export ZDOTDIR=' /etc/zshenv; then
    # tell zsh wherer to look for startup file
    echo 'export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"' | sudo tee -a /etc/zshenv
fi
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
#  COLORS=(
#     [RED]='\033[0;31m'
#     [GREEN]='\033[0;32m'
#     [YELLOW]='\033[1;33m'
#     [BLUE]='\033[0;34m'
# )
# Package configurations
declare -A packages=(
    ["$DOTFILES/shell/zsh"]="$ZDOTDIR"
    ["$DOTFILES/homebrew"]="$HOME/.config/homebrew"
    ["$DOTFILES/editor/nvim"]="$HOME/.config/nvim"
    ["$DOTFILES/xterm/ghostty"]="$HOME/.config/ghostty"
    ["$DOTFILES/starship"]="$HOME/.config/starship"
)
safe_link() {
    local source="$1"
    local target="$2"
    # Create parent directory if needed
    [[ ! -d $target ]]; mkdir -p "${target:h}"
    # Remove existing one and create a new one
    [[ -L $target  ]] && rm -rf $target
    ln -sv "$source" "$target"
}

# Link each package to its destination
for src in ${(k)packages}; do
     dest=${packages[$src]}
    safe_link $src $dest
done




# split=("${(@s#/#)SHELL}")ju
# shell=$split[-1]
# if [[ $shell != 'zsh' ]]; then
#     sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)
# fi
# # source $ZDOTDIR/.zshrc
# exec zsh


# # setup terminal emualator default shell
# case "$shell" in
#     zsh)
#         sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)
#         ;;
#     fish)
#         echo /usr/local/bin/fish | sudo tee -a /etc/shells
#         chsh -s /usr/local/bin/fish
#         ;;
#     bash)
#         echo "win sublinux"
#     ;;
#     *)
#         ;;
# esac
