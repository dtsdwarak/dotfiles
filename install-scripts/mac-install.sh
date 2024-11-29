printf "\n%bInstalling generic dependencies for Mac...%b\n\n" "$GREEN" "$RESET_COLOR"

brew install lighttpd ranger jq ncdu pigz glances htop pv highlight atool poppler p7zip cabextract mhash diff-so-fancy csvtk
$(brew --prefix)/opt/fzf/install
python3 -m ensurepip
sudo pip3 install Pygments tldr csvkit pgcli pydf pyyaml

## MacPorts installation
sudo port -N install bash zsh coreutils findutils wget curl yt-dlp tree gnutar rsync less moreutils inetutils vim mc nmap parallel lscpu watch tmux tmux-pasteboard upower iproute2mac readline img2pdf poppler diffutils pstree gwhich ruby-build grep gsed gawk thefuck micro tre-tree most jless libxkbcommon lf stow mise libyaml tig fzf py-csvkit