#! /bin/bash

if [ ! -d .git ] && [ ! -f .git ]; then
    echo "Not a git repo"
    exit
fi;

branches=$(git for-each-ref --sort=-committerdate refs/heads/ --format='%(color:cyan)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:magenta)%(authorname)%(color:reset)' --color=always|column -ts'|') &&
branch=$(echo "$branches" | fzf --multi --ansi --height=20%)
if [ -z "${branch}" ]; 
    then return 0 
    else git switch $(echo "$branch" | sed "s/ .*//")
fi
