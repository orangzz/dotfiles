# to abosolut path of current dir
DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)


rm -rf $HOME/.config/nvim
ln -s $DOTFILES/nvim $HOME/.config/nvim

rm -rf $HOME/.config/ghostty
ln -s $DOTFILES/ghostty $HOME/.config/ghostty

rm -rf $HOME/.config/starship.toml
ln -s $DOTFILES/starship/starship.toml $HOME/.config/starship.toml


rm -rf $HOME/.zshrc
ln -s $DOTFILES/zsh/.zshrc $HOME/.zshrc
