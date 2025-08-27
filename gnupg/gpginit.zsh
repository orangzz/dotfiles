#!/usr/bin/env zsh
GNUPGHOME=${XDG_DATA_HOME:-$HOME/.local/share}/gnupg
mkdir -p $GNUPGHOME
chown -R $(whoami) $GNUPGHOME
chmod 600 $GNUPGHOME/*
chmod 700 $GNUPGHOME

GPG_TTY="$(tty)"
export GPG_TTY
# unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#   export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#   gpgconf --launch gpg-agent
# fi


