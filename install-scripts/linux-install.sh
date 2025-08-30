printf "\n%bInstalling generic dependencies for Ubuntu...%b\n\n" "$GREEN" "$RESET_COLOR"

# Install dependencies
sudo apt update && apt -y upgrade
sudo apt remove -y fzf
DEBIAN_FRONTEND=noninteractive apt -y install \
tzdata \
pydf build-essential libyaml-dev libssl-dev postgresql-client \
pv jq fonts-inconsolata python3-pip i3lock vim htop lighttpd xsel pigz ncdu tmux \
ruby-build thefuck software-properties-common stow bash zsh coreutils img2pdf dateutils shellcheck

# fzf install
# Install via git to include shell-bindings since it is currently not supported if installed via package manager in Ubuntu
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && $(yes | ~/.fzf/install) || echo "fzf already installed" 

# Mise install
CPU_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then
  CPU_ARCH=arm64
fi
sudo apt install -y gpg sudo wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$CPU_ARCH] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update && sudo apt install -y mise
