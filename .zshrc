case $- in
    *i*) ;;
    *) return;;
esac

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:.:$HOME/.local/bin:

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

export NVM_LAZY=1

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    virtualenv
    kubectl
    docker
    colorize
    fzf
    colored-man-pages
    ubuntu
    emoji
    zsh-autosuggestions
    # nvm
)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Autosuggestions configuration
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias zshconfig="nvim ~/.zshrc"

function weather { curl "wttr.in/$1?m" }

## Kubernetes
alias k=kubectl
# Define as a function to avoid escaping quotes
function ktaints {
    kubectl get nodes -o go-template='{{range $item := .items}}{{with $nodename := $item.metadata.name}}{{range $taint := $item.spec.taints}}{{if and (eq $taint.effect "NoSchedule")}}{{printf "%s %s\n" $nodename $taint.key}}{{end}}{{end}}{{end}}{{end}}'
}
# Gets pods scheduled on node $1
function kpods-on-node {
kubectl get pods --field-selector spec.nodeName=$1 -o wide ${@:2}
}

function kbmnodes {
    kubectl get nodes | grep bm | awk '{print $1}'
}

function knodepvcs {
    kubectl get pvc -A -o jsonpath="{range .items[?(@.metadata.annotations.volume\.kubernetes\.io/selected-node=='$1')]}{.metadata.namespace}{'\t'}{.metadata.name}{'\n'}{end}" --all-namespaces
}

function knodespvcs {
    kbmnodes | while read p; do echo "=== $p"; kubectl get pvc -A -o jsonpath="{range .items[?(@.metadata.annotations.volume\.kubernetes\.io/selected-node=='$p')]}{.metadata.namespace}{'\t'}{.metadata.name}{'\n'}{end}" --all-namespaces; echo; done
}

export EDITOR=nvim
source $HOME/.dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# export TERM="xterm-256color"
export WORKON_HOME=$HOME/Envs
export VIRTUALENVWRAPPER_PYTHON=/home/linuxbrew/.linuxbrew/Homebrew/bin/python3
source $HOME/.local/bin/virtualenvwrapper.sh

# export DISPLAY=:0.0
export LIBGL_ALWAYS_INDIRECT=1

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --color=always --exclude .git"
export FZF_DEFAULT_OPTS="--ansi --height 100%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

export OWL="[0m[34mO[0m [35mW[0m [31mL[0m"

# Search for kube pods using fzf
pods() {
  FZF_DEFAULT_COMMAND="kubectl get pods --all-namespaces" \
    fzf --info=inline --layout=reverse --header-lines=1 \
        --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
        --header "$OWL ╱ Enter (kubectl exec) ╱ CTRL-O (less log) ╱ CTRL-R (reload) ╱ CTRL-D (describe) / CTRL-W (delete) / CTRL-T (tail)" \
        --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden)' \
        --bind 'enter:execute:kubectl exec -it --namespace {1} {2} -- sh > /dev/tty' \
        --bind 'ctrl-o:execute:kubectl logs --all-containers --namespace {1} {2} | less' \
        --bind 'ctrl-r:reload:eval $FZF_DEFAULT_COMMAND' \
        --bind 'ctrl-d:execute:kubectl describe pod --namespace {1} {2} | less' \
        --bind 'ctrl-w:execute:kubectl delete pod --namespace {1} {2}' \
        --bind 'ctrl-t:execute:kubectl logs --follow --tail=0 --namespace {1} {2}' \
        --preview-window up:follow \
        --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@" \
}

function encode { echo -n "$1" | base64; }

# Don't create __pycache__ and pyc files
export PYTHONDONTWRITEBYTECODE=1

alias e=nvim

function cheat { curl cheat.sh/$1 }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias nrs="npm run serve"

# export PATH="/home/baracoso/.linuxbrew/Homebrew/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/Homebrew/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/Homebrew/sbin:$PATH"

# source /opt/intel/oneapi/vtune/latest/env/vars.sh

alias rdp="ssh baracoso@nxsrv.teach.cs.toronto.edu -L3388:nxsrv.teach.cs.toronto.edu:3389"

export TOPDIR=~/csc469_a2/a2

alias guv="git add -uv"
alias gcan="git commit --amend --no-edit"
# Override this alias from OMZ because it's too dangerous
alias gcan!=gcan

function ef { find -wholename $1 | xargs nvim }

# Fixes an issue with P10k preventing FPP from working properly
alias fpp="fpp -ni"

[ -f "/home/baracoso/.ghcup/env" ] && source "/home/baracoso/.ghcup/env" # ghcup-env
export PATH="$PATH:/home/baracoso/.cabal/bin:/home/baracoso/.krew/bin"

function ghcl { git clone git@github.com:$1.git ${@:2}}

# pnpm
export PNPM_HOME="/home/baracoso/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Vulcan settings
source ~/.zshrc.vulcan

function json-curl { \
    curl $1 \
    -X POST \
    -H "Content-Type: application/json" \
    -d \'$2\'
}

export PATH="$PATH:/home/baracoso/go/bin"

alias glint="golangci-lint run"

# Extract Tar Gzipped archive"
alias untargz="tar -xzvf"

function highlight () {
    grep --color=always -E "$1|$" "${@:2}"
}

# Tmux settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Ruby gem settings
export GEM_HOME="/home/baracoso/.gem"
export GEM_PATH="/home/baracoso/.gem"
export PATH="$PATH:/home/baracoso/.gem/bin"

export PATH="$PATH:/home/baracoso/.cargo/bin"
export PATH="$PATH:/home/baracoso/tools/kubectl-plugins"

# zsh history settings
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.

# eksctl
fpath=($fpath ~/.zsh/completion)

## WSL settings
#  Shortcut to opening a WSL path in Explorer

# Open files in explorer if on windows
if [[ "$(< /proc/version)" == *(Microsoft|WSL)* ]]; then
    function exp {
        explorer.exe `wslpath -w "$1"`
    }
fi

# Setting for Docker for Windows
# if [[ "$(< /proc/version)" == *(Microsoft|WSL)* ]]; then
#     export DOCKER_HOST=tcp://localhost:2375
# fi


# Opens webpages in the default Windows browser
export BROWSER=wslview

function fppvi {
    ${@:1} | fpp -a -c 'nvim -p'
}

# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/lib/x86_64-linux-gnu/:/home/linuxbrew/.linuxbrew/Homebrew/lib"
alias ctop='TERM="${TERM/#tmux/screen}" ctop'

# krew path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

function ymerge {
     yq ea '. as $item ireduce ({}; . * $item )' ${@:1}
}
export PATH=$PATH:/usr/local/go/bin

# JQ
export JQ_COLORS="7;31"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/linuxbrew/.linuxbrew/Homebrew/Cellar/mc/RELEASE.2023-01-28T20-29-38Z_1/bin/mc mc
