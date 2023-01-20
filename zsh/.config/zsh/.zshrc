[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# https://github.com/zap-zsh/zap
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

plug $ZDOTDIR/options.zsh
plug $ZDOTDIR/aliases.zsh
plug $ZDOTDIR/exports.zsh

# KEEP AT BOTTOM
eval "$(starship init zsh)"
eval "`fnm env`"
eval "$(zoxide init zsh)"
