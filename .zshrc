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

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

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
    zsh-syntax-highlighting
    nvm
    npm
    yarn
    zshmarks
    zfm
)


source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# export LC_CTYPE=en_US.UTF-8

# Tmux 
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Autosuggestions configuration
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)

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

# Define as a function to avoid escaping quotes
function klabels {
kubectl get nodes -o go-template='{{range $item := .items}}{{with $nodename := $item.metadata.name}}{{range $key, $val := $item.metadata.labels}}{{printf "%s %s:%s\n" $nodename $key $val}}{{end}}{{end}}{{end}}'
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

# kcopysecret <secret-name> <secret-namespace> <new-namespace>
function kcopysecret {
    kubectl get secret $1 -n $2 -o yaml | sed s/"namespace: $2"/"namespace: $3"/| kubectl apply -n $3 -f -
}


# export DISPLAY=:0.0
export LIBGL_ALWAYS_INDIRECT=1

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --color=always --exclude .git"
export FZF_DEFAULT_OPTS="--ansi --height 100%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="\
    --prompt 'Git>' --preview 'bat --style=numbers --color=always --line-range :500 {}' \
    --bind 'ctrl-d:change-prompt(Directories> )+reload(fd --strip-cwd-prefix --color=always --no-ignore --type d)'
    --bind 'ctrl-g:change-prompt(All> )+reload(fd --strip-cwd-prefix --color=always --no-ignore)' \
    --bind 'ctrl-t:change-prompt(Git> )+reload($FZF_DEFAULT_COMMAND)'"

export OWL="[0m[34mO[0m [35mW[0m [31mL[0m"

# Search for kube pods using fzf
pods() {
  FZF_DEFAULT_COMMAND="kubectl get pods --all-namespaces" \
    fzf --info=inline --layout=reverse --header-lines=1 \
        --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
        --header "$OWL ╱ Enter (kubectl exec) ╱ CTRL-O (less log) ╱ CTRL-R (reload) ╱ CTRL-D (describe) / CTRL-W (delete) / CTRL-T (tail) / CTRL-E (tail errors)" \
        --bind 'ctrl-/:change-preview-window(wrap|)' \
        --bind 'enter:execute:kubectl exec -it --namespace {1} {2} -- sh > /dev/tty' \
        --bind 'ctrl-o:execute:kubectl logs --all-containers --namespace {1} {2} | less' \
        --bind 'ctrl-r:reload:eval $FZF_DEFAULT_COMMAND' \
        --bind 'ctrl-d:execute:kubectl describe pod --namespace {1} {2} | less' \
        --bind 'ctrl-w:execute:kubectl delete pod --namespace {1} {2}' \
        --bind 'ctrl-t:execute:kubectl logs --follow --tail=0 --namespace {1} {2}' \
        --bind 'ctrl-e:execute:kubectl logs --follow --tail=0 --namespace {1} {2} | grep "level\":\"\(error\|crit\)\""' \
        --preview-window up:follow \
        --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@" \
}

function encode { echo -n "$1" | base64; }

# Convert hex to decimal
function hex2dec { printf '%d' $1 } 
# Piped
function hex2decp { read p; printf '%d' $p } 

alias e=nvim

function cheat { curl cheat.sh/$1 }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias nrs="npm run serve"
alias nrt="npm run test"
alias nrb="npm run build"
alias nrbf="npm run build --force"
alias nrl="npm run lint"
alias nrbw="npm run build:watch"
alias nr="npm run"

alias p="pnpm"

# DAML
alias db="daml build"
alias ds="daml studio"

# Run vitest watch with all file arguments
function prfvw() {
    # ${*} => pass all arguments as a single entity, without string separation
    pnpm run firebase:exec "vitest --watch ${*}"
}

alias guv="git add -uv"
alias gcan="git commit --amend --no-edit"
alias gpms="gh pr merge --squash --delete-branch"
alias gpc="gh pr create"
# Override this alias from OMZ because it's too dangerous
alias gcan!=gcan

function ef { fd $1 | xargs nvim }

# Fixes an issue with P10k preventing FPP from working properly
alias fpp="fpp -ni"

[ -f "~/.ghcup/env" ] && source "~/.ghcup/env" # ghcup-env

# GitHub clone shortcut with full repo name, and optional target directory
function ghcl { git clone git@github.com:$1.git ${@:2}}
function ghcl_https { git clone https://github.com/$1.git ${@:2}}

# Vulcan settings
source ~/.zshrc.vulcan

function json-curl { \
    curl $1 \
    -X POST \
    -H "Content-Type: application/json" \
    -d \'$2\'
}

alias glint="golangci-lint run"

# Extract Tar Gzipped archive"
alias untargz="tar -xzvf"

function highlight () {
    grep --color=always -E "$1|$" "${@:2}"
}

# zsh history settings
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.

# eksctl
fpath=($fpath ~/.zsh/completion)
# daml
fpath=(~/.daml/zsh $fpath)

## WSL settings
if [[ "$(< /proc/version)" == *(Microsoft|WSL)* ]]; then
    # Open files in Explorer if on Windows
    function exp {
        explorer.exe `wslpath -w "$1"`
    }

    # Opens webpages in the default Windows browser
    export BROWSER=wslview

    export HOST=`ip route show default | awk '{print $3}'`
fi

# Select in FPP, and open in neovim, in tabs
function fppvi {
    ${@:1} | fpp -a -c 'nvim -p'
}

# Edit modified git files
alias em="git status | grep 'modified\|new file' | fpp -a -c 'nvim -p' -e 'ENTER'"

# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/lib/x86_64-linux-gnu/:/home/linuxbrew/.linuxbrew/lib"
alias ctop='TERM="${TERM/#tmux/screen}" ctop'

function ymerge {
     yq ea '. as $item ireduce ({}; . * $item )' ${@:1}
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/linuxbrew/.linuxbrew/Cellar/mc/RELEASE.2023-01-28T20-29-38Z_1/bin/mc mc

# NOTE: Using zfm instead
# ZSHmarks
# alias s=showmarks
# alias j=jump
# alias b=bookmark
# alias dm=deletemark

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

_fzf_complete_npm() {
    _fzf_complete --reverse --preview '' --prompt="npm run> " -- "$@" < <(
        cat package.json | jq -r '.scripts | keys[]'
    )
}

_fzf_complete_pnpm() {
    _fzf_complete --reverse --preview '' --prompt="pnpm run> " -- "$@" < <(
        cat package.json | jq -r '.scripts | keys[]'
    )
}

_fzf_complete_p() {
    _fzf_complete --reverse --preview '' --prompt="pnpm run> " -- "$@" < <(
        cat package.json | jq -r '.scripts | keys[]'
    )
}

_fzf_complete_yarn() {
    _fzf_complete --reverse --preview '' --prompt="yarn run> " -- "$@" < <(
        cat package.json | jq -r '.scripts | keys[]'
    )
}

# Markdown
function eip() {
    glow "https://raw.githubusercontent.com/ethereum/EIPs/master/EIPS/eip-$1.md" -w $(tput cols)
}

function erc() {
    glow "https://raw.githubusercontent.com/ethereum/ERCs/master/ERCS/erc-$1.md" -w $(tput cols)
}

alias gloww='glow -w $(tput cols)'

source ~/.dotfiles/fzf-git.sh

function gch() {
  local selected=$(_fzf_git_each_ref --no-multi)
  [ -n "$selected" ] && git checkout "$selected"
}

# Override aliases
alias vimdiff='nvim -d'

# Add sed to remove Windows newlines
alias wslpaste="powershell.exe Get-Clipboard | sed 's/\r//'"

# Autocompletions
source <(jwt completion bash)
source <(gh completion -s zsh)
source <(rg --generate complete-zsh)
eval "$(gh copilot alias -- zsh)"

autoload -U compinit; compinit
source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
