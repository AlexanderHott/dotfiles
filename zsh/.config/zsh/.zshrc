# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# Zap changes it's behavior based on some of the settings in 
# options.zsh so it needs to be sourced first.
source $ZDOTDIR/options.zsh

# https://github.com/zap-zsh/zap
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

plug $ZDOTDIR/aliases.zsh
plug $ZDOTDIR/exports.zsh

plug "zap-zsh/vim"

export ANDROID_HOME=$HOME/Android/Sdk

# KEEP AT BOTTOM
eval "$(starship init zsh)"
eval "`fnm env`"
eval "$(zoxide init zsh)"

# pnpm
export PNPM_HOME="/home/ott/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
