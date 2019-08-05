# Color constants
GREEN='\033[1;32m'
RED='\033[1;31m'
RESET_COLOR='\033[0m'

printf "\n${GREEN} Installing generic dependencies for Ubuntu...${RESET_COLOR}"

# Install dependencies
sudo apt-get update
sudo apt-get -y install build-essential postgresql-client pv jq fonts-inconsolata python-pip i3lock vim htop lighttpd xsel pigz ncdu
sudo pip install Pygments tldr csvkit pgcli

## Install rust and dependencies
curl https://sh.rustup.rs -sSf | sh
cargo install bat

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

if [[ -z $(grep "bashrc" $HOME/.bash_profile) ]];
then
    echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
fi

# Copy .profile settings
# Usually used for doing stuff at boot time
if [[ -z $(grep "dwarak_dotfiles" $HOME/.profile) ]];
then
    echo 'source $HOME/dwarak_dotfiles/profile.rc' >> $HOME/.profile
fi

if [[ -z $(grep "~/.profile" $HOME/.bash_profile) ]];
then
    echo 'source ~/.profile' >> $HOME/.bash_profile
fi

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


###########################
# Setup command line tools
###########################


# Setup base directory
mkdir -p $HOME/apps/

# Install fzf
# Git - https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/apps/fzf
$HOME/fzf/install

##############################


source $HOME/.bashrc
source $HOME/.zshrc
printf "\n\n${GREEN} Dotfile installation successful! ${RESET_COLOR} \n"
