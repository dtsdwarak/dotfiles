# Install dependencies
apt-get -y install python-pip i3lock vim htop lighttpd
pip install Pygments

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

echo "Install successful. Open a new terminal to see changes. :-) "
