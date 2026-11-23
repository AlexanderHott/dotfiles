# ~/.bash_logout: run when a bash login shell exits.

# Clear the console when leaving a TTY login, for privacy.
if [ "$SHLVL" = 1 ]; then
  [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
