# Install dependencies
apt-get -y install python-pip i3lock vim htop
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

# Pull vim configs over
if [[ -z $(grep "vim.rc" $HOME/.vimrc) ]];
then
    echo 'source $HOME/dwarak_dotfiles/vim/vim.rc' >> $HOME/.vimrc
fi

echo "Install successful. Open a new terminal to see changes. :-) "
