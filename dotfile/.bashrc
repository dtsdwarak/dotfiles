source $HOME/.dotfilerc/sh.rc

# To execute every time a prompt is set.
PROMPT_COMMAND='PS1_curDir'

# username and hostname values
# Refer here for tput color table - http://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes
LOGIN_INFO="[$(whoami) @ $(hostname)]"

# Correct spelling errors
shopt -q -s cdspell

# For bash completion of aws commands
## AWS CLI Auto Complete
complete -C aws_completer aws

# Terminal prompt
# Guide to setting up your own PS1 variable : http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
export PS1='\[\e[1;33m\]$LOGIN_INFO\[\e[1;32m\][$curDir] \[\e[1;36m\]$(val=( $(git branch 2>/dev/null | grep "*" | colrm 1 2) ); if [ ! -z "$val" ]; then echo "($val) "; fi)\n\[\e[1;32m\]$ \[\e[m\]'

# For Traversing up the directory structure in bash. Thanks to http://stackoverflow.com/a/17030976
cd..() {
    cd $(printf '%0.s../' $(seq 1 ${1:-1}))
}

# Managing shell history
# Infinite bash history - https://stackoverflow.com/a/12234989
export HISTCONTROL=ignoredups
export HISTFILESIZE=
export HISTSIZE=

# Git completion
source $HOME/.dotfilerc/git/git-completion.bash
eval "$(direnv hook bash)"

source $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"
