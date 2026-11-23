# ~/.bashrc: interactive bash setup (aliases, functions, prompt, completion).
#
# Environment variables and PATH live in ~/.profile.
# Key bindings and vim mode live in ~/.inputrc.

# Everything below is for interactive shells only.
[[ $- == *i* ]] || return

# History
HISTSIZE=100000
HISTFILESIZE=200000
HISTTIMEFORMAT='%F %T  '
HISTIGNORE='ls:ll:cd:pwd:exit:clear:history'
HISTCONTROL=ignoreboth
shopt -s histappend cmdhist
# Write each command to the history file right away, so other terminals see it.
# Must be set before starship and zoxide, which wrap PROMPT_COMMAND.
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# Shell options
shopt -s checkwinsize       # update LINES/COLUMNS after each command
shopt -s globstar           # ** matches recursively
shopt -s autocd             # type a directory name to cd into it
shopt -s cdspell dirspell   # fix small typos in cd paths

# Colors and pagers
# LS_COLORS is also used by eza, fd and colored tab completion.
if [[ -x /usr/bin/dircolors ]]; then
  if [[ -r ~/.dircolors ]]; then
      eval "$(dircolors -b ~/.dircolors)"
  else
      eval "$(dircolors -b)"
  fi
fi
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Completion
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

# Edit the command line in $VISUAL (Esc v, or Ctrl-X Ctrl-E in insert mode).
# Unlike readline's edit-and-execute-command, the edited command is put back
# on the prompt instead of running, so you can check it and press Enter.
# Quit the editor with an error (:cq in vim) to keep the line as it was.
# This needs bind -x, which ~/.inputrc can't do, so it lives here.
_edit_command_line() {
  local tmp
  tmp=$(mktemp --suffix=.sh) || return
  printf '%s\n' "$READLINE_LINE" >"$tmp"
  if "${VISUAL:-${EDITOR:-vi}}" "$tmp"; then
    READLINE_LINE=$(<"$tmp")
    READLINE_POINT=${#READLINE_LINE}
  fi
  rm -f "$tmp"
}
bind -m vi-command -x '"v": _edit_command_line'
bind -m vi-insert -x '"\C-x\C-e": _edit_command_line'

# fzf
# Ctrl-T: insert a file path, Ctrl-R: search history, Alt-C: cd into a directory.
export FZF_DEFAULT_OPTS="--cycle --layout=reverse --bind 'preview-scroll-up:preview-up+preview-up+preview-up+preview-up' --bind 'preview-scroll-down:preview-down+preview-down+preview-down+preview-down'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range :200 {}'"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always --icons {}'"
eval "$(fzf --bash)"

# Language and tool hooks
# These define shell functions or per-shell state, so they can't go in ~/.profile.
command -v fnm >/dev/null && eval "$(fnm env)"
[[ -r ~/.opam/opam-init/init.sh ]] && . ~/.opam/opam-init/init.sh >/dev/null 2>&1
[[ -f ~/.vite-plus/env ]] && . ~/.vite-plus/env   # the `vp` wrapper and its completion

# Aliases: files and navigation
alias ls='eza -lah --icons --group-directories-first'
alias ll='eza -laa --icons --group-directories-first'   # -aa also shows . and ..
alias la='eza -lahA --icons --group-directories-first'
alias lg='eza -la --git --git-ignore'
alias grep='grep --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias j='z'

# Ask before overwriting or deleting.
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias unlink='unlink -i'
alias rmdir='rmdir -i'

# Aliases: git
alias gg='git log --oneline --graph --decorate --all'
alias gundo='git reset HEAD~1 --mixed'
alias gtypo='git commit --amend'

# Aliases: misc
alias sb='source ~/.bashrc'
alias todo='nvim ~/Documents/notes/TODO.md'
alias clang='aplay ~/Downloads/metal-pipe.wav > /dev/null 2>&1 & clang'
alias aslr_disable='echo 0 | sudo tee /proc/sys/kernel/randomize_va_space'
alias aslr_enable='echo 2 | sudo tee /proc/sys/kernel/randomize_va_space'

# Desktop notification when a long command finishes:  sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Functions:
# Pick a file with fzf and open it with the default app.
fzopen() {
  local file
  file=$(fzf) && xdg-open "$file"
}

# Update apt, flatpak and snap packages in parallel.
uu() {
  local failed=0 flatpak_pid snap_pid
  sudo -v || return

  (
    sudo -n flatpak update --system -y || failed=1
    flatpak update --user -y || failed=1
    exit "$failed"
  ) </dev/null &
  flatpak_pid=$!

  sudo -n snap refresh </dev/null &
  snap_pid=$!

  sudo apt update --error-on=any && sudo apt upgrade -y || failed=1

  wait "$flatpak_pid" || failed=1
  wait "$snap_pid" || failed=1

  if [[ -f /var/run/reboot-required ]]; then
    printf '\nA reboot is required.\n'
  fi
  return "$failed"
}

# Prompt:
eval "$(starship init bash)"

# zoxide wants to be initialized last.
eval "$(zoxide init bash)"

# Machine-specific or private settings that shouldn't live in git.
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
true
