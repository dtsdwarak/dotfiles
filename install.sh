#! /bin/bash

# Quit if you encounter error
set -e

# Color constants
GREEN='\033[1;32m'
RED='\033[1;31m'
RESET_COLOR='\033[0m'

printf "\n${GREEN}Installing generic dependencies for Ubuntu...${RESET_COLOR}\n\n"

# Install dependencies
sudo apt update && sudo apt upgrade
sudo apt -y install pydf build-essential libssl-dev postgresql-client pv jq fonts-inconsolata python3-pip i3lock vim htop lighttpd xsel pigz ncdu tmux rbenv ruby-build direnv thefuck software-properties-common stow bash zsh coreutils img2pdf
# python3 -m ensurepip
sudo pip install Pygments tldr csvkit pgcli pyyaml

# fzf install
# Install via git to include shell-bindings since it is currently not supported if installed via package manager in Ubuntu
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# TODO
# Automate installation of asdf plugins/versions for python, ruby, rust and node
asdf plugin add ruby
# For ruby version install check https://stackoverflow.com/a/77857095/2981954
asdf plugin add nodejs
asdf plugin add python
asdf plugin add rust
cargo install bat exa fd-find procs du-dust ripgrep eva lsd
asdf reshim rust # Need to reshim post cargo binary installs https://github.com/code-lever/asdf-rust/issues/14

# Install SDKMan

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

#Copy files
cp -r dwarak_dotfiles $HOME

# Install configs over Zsh
if [[ -z $(grep "dwarak_dotfiles" $HOME/.zshrc) ]];
then
    echo 'source $HOME/dwarak_dotfiles/dwarak_zshrc' >> $HOME/.zshrc
fi

# Install configs over Bash
if [[ -z $(grep "dwarak_dotfiles" $HOME/.bashrc) ]];
then
    echo 'source $HOME/dwarak_dotfiles/dwarak_bashrc' >> $HOME/.bashrc
fi

touch $HOME/.bash_profile
if [[ -z $(grep "bashrc" $HOME/.bash_profile) ]];
then
    echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
fi

# Copy .profile settings
# Usually used for doing stuff at boot time
touch $HOME/.profile
if [[ -z $(grep "dwarak_dotfiles" $HOME/.profile) ]];
then
    echo 'source $HOME/dwarak_dotfiles/profile.rc' >> $HOME/.profile
fi

if [[ -z $(grep "~/.profile" $HOME/.bash_profile) ]];
then
    echo 'source ~/.profile' >> $HOME/.bash_profile
fi

touch $HOME/.zlogin
if [[ -z $(grep "~/.profile" $HOME/.zlogin) ]];
then
    echo 'source ~/.profile' >> $HOME/.zlogin
fi

##################
# Setup Git
##################

# Install gitconfig
cat $HOME/dwarak_dotfiles/git/gitconfig > $HOME/.gitconfig

# Completion for git in zsh shell
mkdir -p $HOME/.zsh/functions && cp $HOME/dwarak_dotfiles/git/git-completion.zsh $HOME/.zsh/functions/_git


##################
# Setup VIM
##################

# Pull vim configs over
touch $HOME/.vimrc
if [[ -z $(grep "dwarak.vim" $HOME/.vimrc) ]];
then
    echo ':so $HOME/dwarak_dotfiles/vim/dwarak.vim' >> $HOME/.vimrc
fi

# Create colors folder
mkdir -p $HOME/.vim/colors

# Copy themes
cp -R $HOME/dwarak_dotfiles/vim/colors/* $HOME/.vim/colors/

##################

# Setup Kitty
mkdir -p $HOME/.config/kitty/
cp $HOME/dwarak_dotfiles/kitty/kitty.conf $HOME/.config/kitty/kitty.conf


###########################
# Setup command line tools
###########################

# Setup base directory
mkdir -p $HOME/apps/

##############################


source $HOME/.bashrc
source $HOME/.zshrc
printf "\n\n${GREEN}Dotfile installation successful! ${RESET_COLOR} \n"
