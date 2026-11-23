# ~/.bash_profile: read by bash login shells (instead of ~/.profile).
# Set up the environment, then the interactive config if there's a terminal.

[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[[ $- == *i* && -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
true
