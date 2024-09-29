#!/usr/bin/env zsh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

stash=$(git stash list | fzf --multi --ansi --border --multi --info inline-right --layout reverse --marker ▏ --pointer ▌ --prompt ▌ --preview 'git show --color=always $(echo {} | cut -d: -f1) | diff-so-fancy')
stash_id=$(echo $stash | cut -d: -f1)
if [ "x$stash_id" != "x" ]
then
shell_type=$(echo $0)
case "$shell_type" in
    bash ) read -p "Apply git stash id $stash_id (y/n)?" choice
            ;;
    * ) read "choice?Apply git stash id $stash_id (y/n)?"
        ;;
esac
case "$choice" in 
    y|Y ) 
        git stash apply $stash_id
        printf "\n\n${GREEN}git stash $stash_id applied ${NO_COLOR}"
        ;;
    * ) printf "\n\n${RED}stash apply aborted ${NO_COLOR}"
        ;;
esac
fi