
# config base dir
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim' 
export VISUAL='nvim'

# starship prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# alias
alias logpretty="git log --graph --oneline --all"
alias logref="git log --pretty=reference --graph "
alias logstat="git log --stat"
# proxy
export https_proxy=http://127.0.0.1:6152;
export http_proxy=http://127.0.0.1:6152;
export all_proxy=socks5://127.0.0.1:6153
export grpc_proxy=http://127.0.0.1:6152;
export http2_proxy=http://127.0.0.1:6152;
export no_proxy=localhost,127.0.0.1;



# nvm - manage node version
# export NVM_DIR="$HOME/.nvm" # expose install dir
# export PATH=${PATH}:${NVM_HOME} # expose exeutable path
# [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm





export N_PREFIX="$HOME/.n"; # install dir
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin" # executable dir  

# add go executable dir to PATH 
export PATH=$PATH:/usr/local/go/bin

# brew pkg manager installed executable prefix
# ls $(brew --prefix)/bin

# executable install prefix, basedir to lookfor
export PATH="/Users/ayao/n/bin:$PATH"

# mysql install dir
export PATH="/usr/local/mysql/bin:$PATH"
# executuable install dir
export PATH="$HOME/.local/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
PATH=~/.console-ninja/.bin:$PATH

# bun completions
[ -s "/Users/ayao/.bun/_bun" ] && source "/Users/ayao/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


