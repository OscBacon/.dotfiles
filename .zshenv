export PATH=$HOME/bin:/usr/local/bin:$PATH:.:$HOME/.local/bin:$HOME/.bun/bin:

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export COLORTERM=truecolor

export NVM_LAZY=1

# Brew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
export HOMEBREW_CELLAR=/home/linuxbrew/.linuxbrew/Cellar

export EDITOR=nvim
# export TERM="xterm-256color"
export WORKON_HOME=$HOME/Envs
export VIRTUALENVWRAPPER_PYTHON=/home/linuxbrew/.linuxbrew/bin/python3
# source $HOME/.local/bin/virtualenvwrapper.sh
source /home/linuxbrew/.linuxbrew/bin/virtualenvwrapper.sh

# yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Go
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# Python
# Don't create __pycache__ and pyc files
export PYTHONDONTWRITEBYTECODE=1

# Ruby gems
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$HOME/.gem"
export PATH="$PATH:$HOME/.gem/bin"

# krew
export PATH="$PATH:$HOME/.cabal/bin:$HOME/.krew/bin"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/tools/kubectl-plugins"

export PATH="$PATH:$HOME/.foundry/bin"
export PATH="$PATH:/snap/bin"
. "$HOME/.cargo/env"

# JQ
export JQ_COLORS="7;31"

export PATH="$PATH:/opt/nvim/"

# HiDPI scaling for WSLg apps
export GDK_DPI_SCALE=1.5      # GTK apps: 1.5x text, widgets stay 1x (GDK_SCALE takes whole numbers only)
export QT_SCALE_FACTOR=1.5    # Qt apps

export XDG_RUNTIME_DIR="/mnt/wslg/runtime-dir"
export GALLIUM_DRIVER=d3d12

export L8547="http://localhost:8547"
export L8545="http://localhost:8545"
export L9545="http://localhost:9545"
export L9546="http://localhost:9546"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

# Turso
export PATH="$PATH:$HOME/.turso"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# For colored man pages, with colored-man-pages omz plugin
export GROFF_NO_SGR=1

source ~/.zshenv.private

