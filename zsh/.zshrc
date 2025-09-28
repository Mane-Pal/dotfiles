# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Accept full autosuggestion with Alt+L
bindkey '^[l' autosuggest-accept

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Source development environment (language tools, auto-start configs)
if [ -f "$HOME/.config/shell/dev-environment" ]; then
    . "$HOME/.config/shell/dev-environment"
fi

# Use Keeper SSH agent instead of regular ssh-agent
export SSH_AUTH_SOCK='/home/manepal/.config/Keeper Password Manager/keeper-ssh-agent.sock'


# ============================================================================
# MODERN CLI TOOL REPLACEMENTS
# ============================================================================

# Better ls with eza
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --color=always --group-directories-first'
    alias ll='eza -la --color=always --group-directories-first --icons'
    alias la='eza -a --color=always --group-directories-first --icons'
    alias lt='eza -aT --color=always --group-directories-first --icons'
    alias l.='eza -a | grep -E "^\."'
fi

# Better cat with bat
if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
    alias catp='bat'
    export BAT_THEME="Catppuccin-mocha"
fi

# Initialize zoxide (smart cd)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# ============================================================================
# PRODUCTIVITY ALIASES
# ============================================================================

# File operations
alias cp='cp -v'
alias mv='mv -iv'
alias rm='rm -v'
alias mkdir='mkdir -pv'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -="cd -"

# System information
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# Network
alias ping='ping -c 5'
alias ports='netstat -tulanp'

# Development shortcuts
alias vim='nvim'
alias vi='nvim'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# ============================================================================
# FZF INTEGRATION
# ============================================================================

# Enhanced fzf configuration
export FZF_DEFAULT_OPTS="
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6ac,pointer:#f5e0dc
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6ac,hl+:#f38ba8
    --height 60% --layout reverse --border --info=inline
    --preview-window=right:50%:wrap
"

# Use fd for fzf if available
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
fi

# Enhanced fzf preview with bat
if command -v bat >/dev/null 2>&1; then
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================

# Quick file search and edit
fe() {
    local files
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# Directory search and navigation
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

# Process killer with fzf
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi
    
    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

# Search command history
fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# Extract archives
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ============================================================================
# NOTE-TAKING & KNOWLEDGE MANAGEMENT
# ============================================================================

# Quick note functions using obsidian.nvim structure
alias ni='nvim ~/notes/0-inbox/$(date +%Y%m%d%H%M).md'  # Quick inbox capture
alias ns='nvim ~/scratch/$(date +%Y%m%d%H%M).md'       # Scratch notes
alias nd='nvim ~/notes/daily/$(date +%Y-%m-%d).md'     # Daily note

# Tmux-based note functions (for seamless workflow integration)
nn() {  # New inbox note with title prompt
    echo -n "Note title: "
    read title
    if [[ -z "$title" ]]; then
        echo "No title provided, aborting."
        return 1
    fi
    
    # Clean title for filename (just the title, no date)
    local clean_title=$(echo "$title" | sed 's/[^a-zA-Z0-9 ]//g' | tr ' ' '-' | tr '[:upper:]]' '[:lower:]')
    local file="$HOME/notes/0-inbox/${clean_title}.md"
    
    # Only apply template if file doesn't exist
    if [[ ! -f "$file" ]]; then
        local nvim_cmd="nvim -c 'autocmd VimEnter * ++once ObsidianTemplate quick.md' '$file'"
    else
        local nvim_cmd="nvim '$file'"
    fi
    
    if [[ -n "$TMUX" ]]; then
        # Already in tmux
        tmux new-window -c "$HOME/notes/0-inbox" "$nvim_cmd"
    else
        # Not in tmux, create/attach to notes session
        tmux new-session -A -s notes \; new-window -c "$HOME/notes/0-inbox" "$nvim_cmd"
    fi
}

nnd() { # Daily note in tmux notes session
    local file="$HOME/notes/daily/$(date +%Y-%m-%d).md"
    
    if [[ -n "$TMUX" ]]; then
        # Already in tmux, just create new window
        tmux new-window -c "$HOME/notes/daily" "nvim '$file'"
    else
        # Not in tmux, create/attach to notes session
        tmux new-session -A -s notes \; new-window -c "$HOME/notes/daily" "nvim '$file'"
    fi
}

nns() { # Scratch note in tmux notes session
    local file="$HOME/scratch/$(date +%Y%m%d%H%M).md"
    
    if [[ -n "$TMUX" ]]; then
        # Already in tmux, just create new window
        tmux new-window -c "$HOME/scratch" "nvim '$file'"
    else
        # Not in tmux, create/attach to notes session
        tmux new-session -A -s notes \; new-window -c "$HOME/scratch" "nvim '$file'"
    fi
}

# Structured note creation
np() { # Project note
    local project_name="${1:-project}"
    nvim ~/notes/projects/${project_name}.md
}

m() { # Meeting note
    local meeting_name="${1:-meeting}"
    nvim ~/notes/meetings/$(date +%Y%m%d)-${meeting_name}.md
}

na() { # Area note (ongoing responsibilities)
    local area_name="${1:-area}"
    nvim ~/notes/areas/${area_name}.md
}

nr() { # Reference note
    local ref_name="${1:-reference}"
    nvim ~/notes/reference/${ref_name}.md
}

# Note search and navigation
nf() { # Find and edit notes
    local note
    note=$(find ~/notes -name "*.md" -type f | fzf --preview 'bat --color=always {}' --preview-window=right:50%:wrap)
    [[ -n "$note" ]] && nvim "$note"
}

nfg() { # Grep through notes and edit
    local match
    match=$(rg --type md --line-number --no-heading --color=always "${1:-}" ~/notes | fzf --ansi --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' --preview-window=right:50%:wrap)
    [[ -n "$match" ]] && nvim "+$(echo $match | cut -d: -f2)" "$(echo $match | cut -d: -f1)"
}

# Daily inbox processing
ninbox() { # Process inbox notes
    find ~/notes/0-inbox -name "*.md" -type f | head -10 | xargs -I {} echo "Processing: {}"
    find ~/notes/0-inbox -name "*.md" -type f | head -10 | fzf --preview 'bat --color=always {}' --preview-window=right:50%:wrap | xargs -I {} nvim {}
}



# Git helper functions
function git_current_branch() {
  git branch --show-current 2>/dev/null
}

# Enhanced git log with fzf
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Interactive git add
gadd() {
  git status --porcelain | fzf --multi --preview 'git diff --color=always {2}' | awk '{print $2}' | xargs git add
}

# Interactive git checkout branch
gchb() {
  git branch | fzf | sed 's/^..//' | xargs git checkout
}

export EDITOR=nvim


eval "$(just --completions zsh)"
# Created by `pipx` on 2025-09-02 12:01:31
export PATH="$PATH:/home/manepal/.local/bin"

# Starship prompt
eval "$(starship init zsh)"
