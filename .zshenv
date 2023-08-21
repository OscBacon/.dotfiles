export PATH=$HOME/bin:/usr/local/bin:$PATH:.:$HOME/.local/bin:

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export NVM_LAZY=1

# Brew
export PATH="/home/linuxbrew/.linuxbrew/Homebrew/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/Homebrew/sbin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1

export EDITOR=nvim
# export TERM="xterm-256color"
export WORKON_HOME=$HOME/Envs
export VIRTUALENVWRAPPER_PYTHON=/home/linuxbrew/.linuxbrew/Homebrew/bin/python3
source $HOME/.local/bin/virtualenvwrapper.sh

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# yarn
export PATH="/home/baracoso/.yarn/bin:$PATH"

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

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/tools/kubectl-plugins"

export PATH="$PATH:/home/baracoso/.foundry/bin"
export PATH="$PATH:/snap/bin"
