source $HOME/.dotfilerc/sh.rc

setopt PROMPT_SUBST # To execute function inside PS1. Refer this- http://superuser.com/a/142114

# username and hostname values
# Refer here for tput color table - http://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes
LOGIN_INFO="[$(whoami) @ $(hostname)]"

# To execute everytime before the prompt is set. More on that here: http://zsh.sourceforge.net/Doc/Release/Functions.html
function precmd() {
    PS1_curDir
}

# For help refer here: http://www.nparikh.org/unix/prompt.php
export PS1=$'\e[1;33m$LOGIN_INFO\e[1;32m[$curDir]\e[1;36m $(val=( $(git branch 2>/dev/null | grep "*" | colrm 1 2) ); if [ ! -z "$val" ]; then echo "($val) "; fi)\n\e[1;32m\%# \e[0m'

# For Traversing up the directory structure in zsh
cd..() {
    dir_val=$(repeat ${1:-1} printf ../)
    cd $dir_val
}

# To use Option (ALT) + arrow keys in Terminals
# Ref - https://github.com/kovidgoyal/kitty/issues/838#issuecomment-770328902
# iterm
bindkey "\e\e[D" backward-word # ⌥←
bindkey "\e\e[C" forward-word # ⌥→

# kitty
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word # ⌥→

# Git completion
# zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
# `compinit` scans $fpath, so do this before calling it.
# fpath=(~/.zsh/functions $fpath)

eval "$(direnv hook zsh)"

HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Set up the prompt

# autoload -Uz promptinit
# promptinit

setopt histignorealldups sharehistory
setopt interactive_comments

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Use modern completion system
# Making this load faster - https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

export CLICOLOR=YES
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"