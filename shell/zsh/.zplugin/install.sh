
main() {


local ZPLUGIN_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/zplugin
local BACKUP_SUFFIX=$(date +%Y-%m-%d)_$(date_+%s)
local ZSHRC=${ZDOTDIR:-$HOME}/.zshrc

[[ -f $ZPLUGIN_DIR/zplugin.zsh ]] && {
    read "ans?Zplugin is already installed in '$ZPLUGIN_DIR'"
    read -q "ans?Do you want to reinstall it (y/N)? "
    [[ $ans =~ ^[Nn]$ ]] && {
      echo " skipped installation"
      return
    }
    echo " Reinstalling Zplugin"
    rm -rf $ZPLUGIN_DIR
}

  git clone --depth 1 https://github.com/orangzz/zplugin.git

}
