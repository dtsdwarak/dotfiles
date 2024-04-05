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
sudo apt -y install pydf build-essential libyaml-dev libssl-dev postgresql-client \
pv jq fonts-inconsolata python3-pip i3lock vim htop lighttpd xsel pigz ncdu tmux \
ruby-build direnv thefuck software-properties-common stow bash zsh coreutils img2pdf

# fzf install
# Install via git to include shell-bindings since it is currently not supported if installed via package manager in Ubuntu
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install || echo "fzf already installed" 

# ASDF Install
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 || echo "asdf already installed"

# Install SDKMan
if [ ! -d "$HOME/.sdkman" ]; then
    echo "sdkman could not be found. Installing..."
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

printf "\n\n${GREEN} Copying source files... ${RESET_COLOR} \n"

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

printf "\n\n${GREEN} Setting up Git... ${RESET_COLOR} \n"

# Install gitconfig
cat $HOME/dwarak_dotfiles/git/gitconfig > $HOME/.gitconfig

# Completion for git in zsh shell
mkdir -p $HOME/.zsh/functions && cp $HOME/dwarak_dotfiles/git/git-completion.zsh $HOME/.zsh/functions/_git


##################
# Setup VIM
##################

printf "\n\n${GREEN} Setting up vim configs... ${RESET_COLOR} \n"

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

printf "\n\n${GREEN} Setting up kitty... ${RESET_COLOR} \n"

# Setup Kitty
mkdir -p $HOME/.config/kitty/
cp $HOME/dwarak_dotfiles/kitty/kitty.conf $HOME/.config/kitty/kitty.conf


###########################
# Setup command line tools
###########################

# Setup base directory
mkdir -p $HOME/apps/

##############################

case `echo $SHELL | rev | cut -d'/' -f1 | rev` in
  bash)
    source $HOME/.bashrc
    ;;
  zsh)
    source $HOME/.zshrc
    ;;
esac

printf "\n\n${GREEN} Copied all source files ${RESET_COLOR} \n"

# For ruby version install check https://stackoverflow.com/a/77857095/2981954
printf "\n\n${GREEN} Installing ruby... ${RESET_COLOR} \n"
asdf plugin add ruby || echo "Ruby already installed"
asdf install ruby 3.3.0 || echo "Ruby already installed"
asdf global ruby 3.3.0 || echo "Ruby already installed"

printf "\n\n${GREEN} Installing nodejs... ${RESET_COLOR} \n"
asdf plugin add nodejs || echo "nodejs already installed"
asdf install nodejs 20.12.0 || echo "nodejs already installed"
asdf global nodejs 20.12.0 || echo "nodejs already installed"

printf "\n\n${GREEN} Installing python... ${RESET_COLOR} \n"
asdf plugin add python || echo "python already installed"
asdf install python 3.12.0 || echo "python already installed"
asdf global python 3.12.0 || echo "python already installed"

printf "\n\n${GREEN} Installing pip packages... ${RESET_COLOR} \n"
sudo pip install Pygments tldr csvkit pgcli pyyaml || echo "All packages already installed"

printf "\n\n${GREEN} Installing rust... ${RESET_COLOR} \n"
asdf plugin add rust || echo "rust already installed"
asdf install rust 1.77.0 || echo "rust already installed"
asdf global rust 1.77.0 || echo "rust already installed"

printf "\n\n${GREEN} Installing rust binaries... ${RESET_COLOR} \n"
cargo install bat exa fd-find procs du-dust ripgrep eva lsd
asdf reshim rust # Need to reshim post cargo binary installs https://github.com/code-lever/asdf-rust/issues/14


printf "\n\n${GREEN}Dotfile installation successful! ${RESET_COLOR} \n"