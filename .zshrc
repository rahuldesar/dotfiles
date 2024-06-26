[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

tmux source-file ~/.config/tmux/tmux.conf >/dev/null 2>&1

# Custom aliases 
for file in ~/.config/aliases/*; do
    source "$file"
done


alias sherlock="python3 /Users/rahuldesar/Developer/Personal/test-apps/sherlock/sherlock"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
HISTFILESIZE=5000

. /opt/homebrew/opt/asdf/libexec/asdf.sh

PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# `thefuck` : correcting incorrect prompts. 
eval $(thefuck --alias f)

export EDITOR='nvim'

# bun completions
[ -s "/Users/rahuldesar/.bun/_bun" ] && source "/Users/rahuldesar/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/Library/Python/3.9/bin:$PATH"

export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$HOME/scripts"


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
export PATH="$GOPATH/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export DENO_INSTALL="/Users/rahuldesar/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"




eval "$(starship init zsh)"
