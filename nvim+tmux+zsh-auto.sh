#!/bin/bash
set -e
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')
echo "${RED}clear enviroment${RESET}"

if [ -d ~/.zsh ];then
sudo rm -rf ~/.zsh
mkdir ~/.zsh
fi
echo "${BLUE} neovim zsh tmux ctags installation start"

sudo apt-get update
#sudo apt-get install -y python-software-properties
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:neovim-ppa/stable
sudo apt-get install -y curl

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-get install -y neovim
# sudo apt-get install -y python-neovim
sudo apt-get install -y python3-neovim
sudo apt-get install -y zsh
sudo apt-get install -y tmux
sudo apt-get install -y universal-ctags
sudo apt-get install -y build-essential cmake python3-dev
sudo apt-get install -y git
sudo apt-get install -y python3-pip
# sudo apt-get install -y python-pip
sudo apt-get install -y nodejs
sudo apt-get install -y yarn
sudo apt-get install -y tar
sudo pip3 install --upgrade pip
sudo pip install update
sudo pip3 install update
sudo pip install pynvim python-language-server pyls-mypy pyls-black jedi-language-server
sudo pip3 install pynvim python-language-server pyls-mypy pyls-black jedi-language-server
echo "${GREEN} neovim zsh tmux ctags installation is completed${RESET}"
echo "${BLUE}install oh my zsh${RESET}"
sudo rm -rf ~/.oh-my-zsh
echo y|sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "${GREEN} oh my zsh installation is completed${RESET}"
echo "${BLUE}make zsh default${RESET}" 

# sudo usermod -s /bin/zsh root
# sudo usermod -s /bin/zsh $USER

echo "${GREEN}  zsh  is set as default${RESET}"
echo "${BLUE}install vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim
cat ./init.vim > ~/.config/nvim/init.vim

echo "${GREEN} vim-plug installation is completed${RESET}"
echo "${BLUE}copying configration files"
rm -rf ~/.local/share/nvim
cp -rf ./nvim ~/.local/share
if [ -f ~/.zshrc ];then
sudo rm ~/.zshrc
fi
if [ -f ~/.tmux.conf ];then
sudo rm ~/.tmux.conf
fi
if [ -f ~/.config/nvim/coc-settings.json ];then
sudo rm ~/.config/nvim/coc-settings.json
fi
cat ./.zshrc > ~/.zshrc
cat ./.tmux.conf > ~/.tmux.conf
cat ./coc-settings.json > ~/.config/nvim/coc-settings.json
echo "${GREEN} configration files copy is done ${RESET}"
echo "${BLUE}installing tmux plugins"
if [ -d ~/.tmux/plugins/tpm ];then
sudo rm -r ~/.tmux/plugins/tpm
fi
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "${GREEN} tmux plugins installation is completed${RESET}"
if [ ! -d ~/.vim/tags ];then
mkdir -p ~/.vim/tags/
fi
echo "${BLUE}install fzf"
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo n|sudo ~/.fzf/install
echo "${GREEN} fzf installation is completed${RESET}"
echo "${BLUE}install zsh autosuggestions"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo git clone https://github.com/conda-incubator/conda-zsh-completion.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
echo "${GREEN} zsh autosuggestions installation is completed${RESET}"
echo "${BLUE}install zsh-syntax-highlighting"
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "${GREEN} zsh-syntax-highlighting installation is completed${RESET}"
echo "${BLUE}install lazy-git"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
echo "${GREEN} lazy-git is completed${RESET}"

echo "${GREEN}All steps is done!${RESET}"
