export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export EDITOR=nvim
export TERMINAL=konsole
export BROWSER=firefox
export MANPAGER=nvim

export STARSHIP_CONFIG=~/.config/starship.toml
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship_cache

if [ $SHLVL -eq 1 ]; then
    export PATH="$HOME/.local/bin:$HOME/.local/share/fnm:$PATH"
fi
 
