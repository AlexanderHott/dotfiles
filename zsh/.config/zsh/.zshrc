# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

source $ZDOTDIR/options.zsh

source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/exports.zsh

# KEEP AT BOTTOM
eval "$(starship init zsh)"
eval "`fnm env`"
eval "$(zoxide init zsh)"
