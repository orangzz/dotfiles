


# Arguing that you don't care about the right to privacy because you have nothing to hide is no different from saying you don't care about free speech because you have nothing to say. – Edward Snowden

### env-manager {{{
  brew "dotenv"
  brew "direnv"


}}}


### secret-manager {{{

}}}
### password-manager {{{
  brew "passwordstore"
}}}


### credential-helper {{{

  # ssh-agent
  # gpg-agent

  brew 'gnupg'
  brew 'gpg-tui'
  cask "gpg-suite" if OS.mac?

  # credential manager
  cask '1password'
  cask '1password-cli'
  mas '1Password for Safari', id: 1569813296

  cask 'git-credential-manager' # cross-platform credential helper with support multi-factor auth
  cask "pass-git-helper"
  brew "netrc"


  brew "direnv"

  # os keychain
  # add_to_keychain
  # remove_from_keychain


  # credential vault - store and retrive secret
  brew "doppler"

  # brew 'jorgelbg/tap/pinentry-touchid' if OS.mac?
### }}}
