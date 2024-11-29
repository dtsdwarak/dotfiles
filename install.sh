#! /bin/bash

# Quit if you encounter error
set -e

# Color constants
GREEN='\033[1;32m'
RESET_COLOR='\033[0m'

function get_backup {
  mv ~/"$1" ~/"$1"_"$(date +%s)" || echo "No $1 file already available for backup. Skipping"
}

case $(uname) in
  Linux)
    ./install-scripts/linux-install.sh
    ;;
  Darwin)
    ./install-scripts/mac-install.sh
    ;;
esac

printf "\n\n%b Stowing dotfiles... %b \n" "$GREEN" "$RESET_COLOR"

get_backup .bash_profile 
get_backup .bashrc 
get_backup .profile 
get_backup .zlogin 
get_backup .zshrc
get_backup .gitconfig
stow config -t ~/
stow dotfile -t ~/
stow vim -t ~/

# Completion for git in zsh shell
mkdir -p "$HOME"/.zsh/functions && cp "$HOME"/.dotfilerc/git/git-completion.zsh "$HOME"/.zsh/functions/_git

###########################
# Setup command line tools
###########################

# Setup base directory
mkdir -p "$HOME"/apps/

##############################

case $(echo "$SHELL" | rev | cut -d'/' -f1 | rev) in
  bash)
    source "$HOME"/.bashrc
    ;;
  zsh)
    source "$HOME"/.zshrc
    ;;
esac

printf "\n\n%b Copied all source files %b \n" "$GREEN" "$RESET_COLOR"

# For ruby version install check https://stackoverflow.com/a/77857095/2981954
printf "\n\n%b Installing ruby... %b \n" "$GREEN" "$RESET_COLOR"
mise use ruby@3.3.6 || echo "Ruby already installed"

printf "\n\n%b Installing nodejs... %b \n" "$GREEN" "$RESET_COLOR"
mise use nodejs@20.12.0 || echo "nodejs already installed"

printf "\n\n%b Installing python... %b \n" "$GREEN" "$RESET_COLOR"
mise use python@3.12.0 || echo "python already installed"

printf "\n\n%b Installing pip packages... %b \n" "$GREEN" "$RESET_COLOR"
pip install Pygments tldr csvkit pgcli pyyaml || echo "All packages already installed"

printf "\n\n%b Installing rust... %b \n" "$GREEN" "$RESET_COLOR"
mise use rust@latest || echo "rust already installed"

printf "\n\n%b Installing java... %b \n" "$GREEN" "$RESET_COLOR"
mise use java@corretto-11.0.25.9.1 || echo "java already installed"

printf "\n\n%b Installing rust binaries... %b \n" "$GREEN" "$RESET_COLOR"
cargo install bat exa fd-find procs du-dust ripgrep eva lsd

mise use direnv || echo "direnv already installed"
mise reshim direnv

printf "\n\n%bDotfile installation successful! %b \n" "$GREEN" "$RESET_COLOR"
