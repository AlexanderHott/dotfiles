# Ott's Dots

This is a collection of my dot (configuration) files.

## Quick Start

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install stow git

git clone https://github.com/AlexanderHOtt/dotfiles.git ~/.dotfiles

cd ~/.dotfiles

stow zsh  # To use the zsh config
stow */   # To use all configs
```

[`stow`](https://www.gnu.org/software/stow/) creates a symlink relative to your
home directory. That's why everything is nested 3 folders deep.

## Extra Setup

- [zsh](#zsh)

### Zsh

Add the following line to your `/etc/zsh/zshenv`.

```zsh
export ZDOTDIR=$HOME/.config/zsh
```

Install any or all of the following

```bash
sudo apt install exa fzf batcat

curl -sS https://starship.rs/install.sh | bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
curl -fsSL https://fnm.vercel.app/install | bash
```

- [exa (better ls)](https://the.exa.website/)
- [fzf (fast fuzzy-finder)](https://github.com/junegunn/fzf)
- [batcat (better cat)](https://github.com/sharkdp/bat)
- [starship (prompt)](https://starship.rs/)
- [zoxide (better ls)](https://github.com/ajeetdsouza/zoxide)
- [fnm (node version manager)](https://github.com/Schniz/fnm)
