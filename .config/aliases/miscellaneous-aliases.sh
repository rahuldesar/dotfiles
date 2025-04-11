alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias cls="clear"
function mcd() { mkdir -p "$1" && cd "$1"; }

ghd() {
  CURRENT_DIR=$(pwd)
  echo "gh-dash-config-generator \"$CURRENT_DIR\" && gh dash -c \"$HOME/.config/gh-dash/temp-custom-config.yml\""
  gh-dash-config-generator "$CURRENT_DIR" && gh dash -c "$HOME/.config/gh-dash/temp-custom-config.yml"
}

alias yt='ytfzf -t'

alias :so="source ~/.bashrc"
alias :q='exit'
alias gg='sudo pm-suspend'
alias path='echo -e ${PATH//:/\\n}'

# finde alias using grep
alias findalias="alias | sed 's/alias //' | grep"

#Tmux Bindings
alias t='tmux'
alias ct='tmux a -t'
alias nt='tmux new -s'
alias kt='tmux kill-ses -t '

alias xsc='pbcopy'

# some more ls aliases
#alias ls='exa -xG --icons --color=auto --group-directories-first '
#alias ll='exa -lF --icons --color=auto --group-directories-first '
#alias lls='exa -lF --icons --color=auto --group-directories-first --sort=size --reverse'
#alias la='exa -axG --icons --color=auto --group-directories-first '

# Enable resumable downloads with wget
alias wget='wget -c'

# Editor Bindings
alias vim='nvim'
alias c='code .'

# Prompt before file changes
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Get External IP / Internet Speed
alias myip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"

alias ctrue="ssh root@49.13.76.136"
alias ctruep="ssh root@128.140.58.77"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Cool Stuff
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "${method}"="lwp-request -m '${method}'"
done

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

alias mega="cd /Users/rahuldesar/Developer/apps/MegaBasterdMACOS_SILICON && ./MegaBasterd.run"

alias love="/Applications/love.app/Contents/MacOS/love"

# Yadm Commit
function yc() {
  cd ~
  yadm enter lazygit
  cd -
}
