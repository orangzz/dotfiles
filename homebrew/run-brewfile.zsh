
# download, verify, install, run(fg,bg), check

export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/homebrew/Brewfile"
export  HOMEBREW_NO_AUTO_UPDATE=1
# dump to current directory by default
# brew bundle dump --file=$DOTFILES/brewfile
# brew bundle dump --global


# take instruction from each entry from brewfile and run brew install
# brew bundle install --verbose --file=$DOTFILES/Brewfile
# brew bundle install --global --verbose


() {
  # `local` sets a variable's scope to this function and its descendendants.
  local file=

  # Load all of the files in rc.d that start with <number>- and end in `.Brewfile`.
  # (n) sorts the results in numerical order.
  # <0->  matches any integer >= 0.
  #  <->  is the same as <0->
  for file in $XDG_CONFIG_HOME/homebrew/Brewfile.d/*.Brewfile(n); do
    brew bundle install --file=$file

  done
} "$@"



# brew bundle cleanup --force --global
# brew bundle cleanup --force --file $DOTFILES/Brewfile



# Homebrew Terminology:


# tap 水龙头
# livecheck for new releases
# [maintain formulas by vendor](https://github.com/orgs/Homebrew/discussions/268)
# main tap - `homebrew/cask`，`homebrew/core`




# formula 配方 cli
# cask 酒桶 gui
# bottle 装瓶
# service

# mas (cli for mac app store)





# brew info --cask <gui>
# brew info <cli> # just like `npm info {executable}`

# remove installed tools
# for tool in curl wget; do
#   sudo rm -f $HOMEBREW_PREFIX/Cellar/$tool
# done



# ls $(brew --prefix)/bin




# list installed package as entry from Brewfile
# brew bundle list -g
# brew bundle list --cask -g




# `brew bundle add name […]`: Add entries to your Brewfile
# `brew bundle remove name […]`: Remove entries that match name from your Brewfile




