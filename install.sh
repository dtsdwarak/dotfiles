#! /bin/bash

# Quit if you encounter error
set -e

# Color constants
GREEN='\033[1;32m'
RESET_COLOR='\033[0m'

printf "\n%bInstalling generic dependencies for Ubuntu...%b\n\n" "$GREEN" "$RESET_COLOR"

function get_backup {
  mv ~/"$1" ~/"$1"_"$(date +%s)" || echo "No $1 file already available for backup. Skipping"
}

# Install dependencies
sudo apt update && sudo apt -y upgrade
sudo apt remove -y fzf
sudo DEBIAN_FRONTEND=noninteractive apt -y install \
tzdata \
pydf build-essential libyaml-dev libssl-dev postgresql-client \
pv jq fonts-inconsolata python3-pip i3lock vim htop lighttpd xsel pigz ncdu tmux \
ruby-build direnv thefuck software-properties-common stow bash zsh coreutils img2pdf dateutils shellcheck

# fzf install
# Install via git to include shell-bindings since it is currently not supported if installed via package manager in Ubuntu
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && $(yes | ~/.fzf/install) || echo "fzf already installed" 

# ASDF Install
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 || echo "asdf already installed"

# Install SDKMan
if [ ! -d "$HOME/.sdkman" ]; then
    echo "sdkman could not be found. Installing..."
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

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
asdf plugin add ruby || echo "Ruby already installed"
asdf install ruby 3.3.0 || echo "Ruby already installed"
asdf global ruby 3.3.0 || echo "Ruby already installed"

printf "\n\n%b Installing nodejs... %b \n" "$GREEN" "$RESET_COLOR"
asdf plugin add nodejs || echo "nodejs already installed"
asdf install nodejs 20.12.0 || echo "nodejs already installed"
asdf global nodejs 20.12.0 || echo "nodejs already installed"

printf "\n\n%b Installing python... %b \n" "$GREEN" "$RESET_COLOR"
asdf plugin add python || echo "python already installed"
asdf install python 3.12.0 || echo "python already installed"
asdf global python 3.12.0 || echo "python already installed"

printf "\n\n%b Installing pip packages... %b \n" "$GREEN" "$RESET_COLOR"
sudo pip install Pygments tldr csvkit pgcli pyyaml || echo "All packages already installed"

printf "\n\n%b Installing rust... %b \n" "$GREEN" "$RESET_COLOR"
asdf plugin add rust || echo "rust already installed"
asdf install rust 1.77.0 || echo "rust already installed"
asdf global rust 1.77.0 || echo "rust already installed"

printf "\n\n%b Installing rust binaries... %b \n" "$GREEN" "$RESET_COLOR"
cargo install bat exa fd-find procs du-dust ripgrep eva lsd
asdf reshim rust # Need to reshim post cargo binary installs https://github.com/code-lever/asdf-rust/issues/14


printf "\n\n%bDotfile installation successful! %b \n" "$GREEN" "$RESET_COLOR"