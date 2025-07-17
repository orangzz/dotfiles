#
# $gitdir/rebase-merge
# $gitdir/rebase-merge/interactive
# $gitdir/rebase-apply/applying
# $gitdir/rebase-apply/rebasing
# MERGE_HEAD
# REVERT_HEAD
# CHERRY_PICK_HEAD


BREW_COMPLETION=$HOMEBREW_PREFIX/share/zsh/site-functions/_git

[[ -r $BREW_COMPLETION ]] && . $completion


# checking commit config
# git config --global commit.gpgsign
# git config --global commit.template


# show config and source
# git config --list --global --show-origin





# git config --unset user.name
# git config --remove-section user


# git credential-osxkeychain erase
# git config --global credential.helper cache
