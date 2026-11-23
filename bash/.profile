# ~/.profile: environment for login sessions.
#
# This is read once when you log in (the KDE session, a TTY, ssh), and
# everything exported here is inherited by every program you start: GUI apps,
# terminals, scripts, cron-less helpers, editors. Keep it to environment
# variables and PATH. It must stay POSIX sh: no aliases, no prompt, no bash-isms.
#
# Interactive bash setup lives in ~/.bashrc. Readline setup lives in ~/.inputrc.

path_prepend() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}
path_append() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="${PATH:+$PATH:}$1" ;;
  esac
}

# Editors and pagers
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='bat --plain --language=man --strip-ansi=always'

# Toolchain locations
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"
export CARGO_HOME="$HOME/.cargo"
export CARGO_TARGET_DIR="$HOME/.cargo-target"
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.local/share/pnpm"
export FLYCTL_INSTALL="$HOME/.fly"
export VP_HOME="$HOME/.vite-plus"

# PATH
# Each prepend goes in front of the previous one, so the list below runs from
# lowest to highest priority. Anything prepended wins over /usr/bin.
path_prepend /usr/local/go/bin
path_prepend "$HOME/go/bin"
path_prepend "$HOME/.local/bin/goland/bin"
path_prepend "$HOME/.local/bin/zig"
path_prepend /opt/syncthing
path_prepend "$BUN_INSTALL/bin"
path_prepend "$PNPM_HOME/bin"
path_prepend "$CARGO_HOME/bin"
path_prepend "$HOME/.turso"
path_prepend "$FLYCTL_INSTALL/bin"
path_prepend "$JAVA_HOME/bin"
path_prepend "$ANDROID_HOME/tools/bin"
path_prepend "$ANDROID_HOME/cmdline-tools/latest/bin"
path_prepend "$ANDROID_HOME/platform-tools"
path_prepend "$ANDROID_HOME/emulator"
path_prepend "$HOME/.local/share/fnm"
path_prepend "$HOME/.opencode/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$VP_HOME/bin"

path_append "$HOME/.local/share/JetBrains/Toolbox/scripts"
path_append "$VP_HOME/fallback-bin"

export PATH
unset -f path_prepend path_append

# Machine-specific environment that shouldn't live in git.
[ -f "$HOME/.profile.local" ] && . "$HOME/.profile.local"
true
