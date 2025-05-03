alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

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
alias cls="clear"
alias c='clear'
# alias c='code .'

# Prompt before file changes
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Get External IP / Internet Speed
alias myip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"

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
alias xps-oil="nvim oil-ssh://xps//home/rahul/Downloads"

# Yadm Commit
function yc() {
  cd ~
  yadm enter lazygit
  cd -
}

alias a="alias | fzf"
alias e="export | fzf"

s() {
  echo "sourcing ~/.zshrc"
  source ~/.zshrc
  echo "source complete"
}

# yy() {
#   yt-dlp "$1" -J --flat-playlist --extractor-args "youtubetab:approximate_date" --playlist-start 1 --playlist-end 30 --cookies-from-browser "chrome:Profile_1" |
#     jq -r ".entries | map(keys)[1][]" >/tmp/yt-output.json
#
#   echo -e "__x_forwarded_for_ip\n_type\navailability\nchannel\nchannel_id\nchannel_is_verified\nchannel_url\ndescription\nduration\nid\nie_key\nlive_status\nrelease_timestamp\nthumbnails\ntimestamp\ntitle\nuploader\nuploader_id\nuploader_url\nurl\nview_count" >/tmp/yt-predefined_keys.txt
#
#   nvim -d /tmp/yt-predefined_keys.txt /tmp/yt-output.json
# }

yy() {
  yt-dlp "$1" -J --flat-playlist --extractor-args "youtubetab:approximate_date" --playlist-start 1 --playlist-end 30 --cookies-from-browser "chrome:Profile_1"
}
