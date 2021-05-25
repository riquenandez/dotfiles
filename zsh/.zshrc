autoload -Uz compinit && compinit
# revert to default settings by executing 'emulate -LR zsh'
alias vim="/usr/local/bin/nvim"
alias vi="nvim"
# case insensitive globbing
setopt NO_CASE_GLOB

# automatic CD
setopt AUTO_CD

# enable shell history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
setopt EXTENDED_HISTORY
SAVEHIST=5000
HISTSIZE=2000

# share history across multiple zsh sessions & append
setopt SHARE_HISTORY
setopt APPEND_HISTORY
# add commands as they are typed
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

# enable zsh correction
setopt HIST_VERIFY
setopt CORRECT
setopt CORRECT_ALL

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# Set up prompt (with git branch name)
# dynamid prompt
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{blue}%1~%f%b %# '
#PROMPT='%B%F{240}%1~%f%b %# '
autoload -Uz vcs_info
precmd_vcs_info() {vcs_info}
precmd_functions+=(precmd_vcs_info)
setopt PROMPT_SUBST
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git*' formats '%F{yellow}*%b%f'
zstyle ':vcs_info:*' enable git

# search history bindkeys
bindkey '^[[A' up-line-or-search # up arrow
bindkey '^[[B' down-line-or-search # down arrow

source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

export EDITOR=nvim

