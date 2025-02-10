# If you're using macOS, you'll want this enabled
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light reegnz/jq-zsh-plugin


zinit snippet OMZP::command-not-found
zinit snippet OMZP::colored-man-pages

# Load completions
fpath=(~/.docker/completions \/Applications/kitty.app/Contents/Resources/kitty/shell-integration/zsh/completions /opt/homebrew/share/zsh/site-functions /opt/homebrew/share/zsh/site-functions /Users/rahuldesar/.local/share/zinit/completions /usr/local/share/zsh/site-functions /usr/share/zsh/site-functions /usr/share/zsh/5.9/functions /Users/rahuldesar/.local/share/zinit/plugins/zsh-users---zsh-completions/src /Users/rahuldesar/.local/share/zinit/plugins/Aloxaf---fzf-tab/lib)

autoload -Uz compinit && compinit

zinit cdreplay -q


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
tmux source-file ~/.config/tmux/tmux.conf >/dev/null 2>&1

. /opt/homebrew/opt/asdf/libexec/asdf.sh

export EDITOR='nvim'
export HOMEBREW_NO_AUTO_UPDATE=1

# Custom aliases 
for file in ~/.config/aliases/*; do
    source "$file"
done

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTFILESIZE=5000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups



PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

alias ls="ls --color"
alias ft="yazi"

alias fzfind='fzf -m --preview="bat --color=always {}"'
alias nvfind='nvim $(fzf -m --preview="bat --color=always {}")'

# `thefuck` : correcting incorrect prompts. 
eval $(thefuck --alias f)


# bun completions
[ -s "/Users/rahuldesar/.bun/_bun" ] && source "/Users/rahuldesar/.bun/_bun"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# pnpm
export PNPM_HOME="/Users/rahuldesar/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


export GOPATH="$HOME/go"
export BUN_INSTALL="$HOME/.bun"

export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$HOME/scripts"
export PATH="$GOPATH/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=/Users/Shared/DBngin/mysql/8.0.33/bin:$PATH

export LDFLAGS="-L/opt/homebrew/opt/postgresql@17/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@17/include"

export DENO_INSTALL="/Users/rahuldesar/.deno"
export ANDROID_HOME="/Users/rahuldesar/Library/Android/sdk"

alias kubectl=kubecolor
# make completion work with kubecolor
compdef kubecolor=kubectl

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
bindkey -v


# Keybindings
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^j' jq-repl
bindkey '^[w' kill-region


PATH=~/.console-ninja/.bin:$PATH
complete -C '/usr/local/bin/aws_completer' aws

cheat() { curl "https://cheat.sh/$1"}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rahuldesar/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rahuldesar/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rahuldesar/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rahuldesar/google-cloud-sdk/completion.zsh.inc'; fi
