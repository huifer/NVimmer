#!/bin/bash

function yellow() {
    echo -e "\033[33m\033[01m\033[05m$1\033[0m"
}

function red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

function green() {
    echo -e "\033[32m$1\033[0m"
}

function byellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}

function blue() {
    echo -e "\033[34m$1\033[0m"
}

green " _   ___     ___                               "
green "| \\ | \\ \\   / (_)_ __ ___  _ __ ___   ___ _ __ "
green "|  \\| |\\ \\ / /| | '_ \` _ \\| '_ \` _ \\ / _ \\ '__|"
green "| |\\  | \\ V / | | | | | | | | | | | |  __/ |   "
green "|_| \\_|  \\_/  |_|_| |_| |_|_| |_| |_|\\___|_|"

green "Welcome to NVimmer, Make your NeoVim/Vim perform as an IDE!!!"
blue "Email: devilyouwei@gmail.com"

echo ""
byellow '1. 如在大陆地区使用，请注意是否需要科学上网...'
echo ""
byellow '2. 中国地区请更换gem,npm,pip等包管理器的镜像为国内源'
byellow '(When in China, change the npm,gem,pip source to China Mainland)'
echo ""
byellow '3. 建议您的系统是干净的，如果已经有vim或者neovim的配置，请提前备份好，按<Ctrl-C>结束该脚本'
echo ""
byellow "Waiting for installing, 3 seconds..."
echo ""

sleep 3

echo "Install Linux Compile Tools and Env------------------------"
sudo --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install sudo"
    apt install -y sudo
fi
sudo apt update
sudo apt install -y cmake build-essential automake checkinstall git ssl-cert
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo ""
echo "Check curl-------------------------------------------------"
curl --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install Curl..."
    sudo apt install -y curl
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo ""
echo "Check snap-------------------------------------------------"
snap --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install Snap..."
    sudo apt install -y snapd
    export PATH=$PATH:/snap/bin
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check NeoVim-----------------------------------------------"
nvim -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install NeoVim..."
    sudo snap install --beta nvim --classic
    if [ "$?" != 0 ]; then
        sudo apt install -y software-properties-common
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo apt update -y
        sudo apt install -y neovim
    fi
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Node.js----------------------------------------------"
node -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install Node.js..."
    curl -o ~/.nvm/install.sh --create-dirs \
        https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh
    if [ "$?" != 0 ]; then
        red "Network Error: curl fail to download 'nvm'"
        exit 1
    fi
    bash ~/.nvm/install.sh
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm install stable
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Python (both 2 and 3)--------------------------------"
python --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install Python2..."
    sudo apt install -y python
fi

python3 --version
status=$?
if [ "$status" != 0 ]; then
    echo "Install Python3..."
    sudo apt install -y python3
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Perl-------------------------------------------------"
perl -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install Perl..."
    sudo apt install -y perl
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Ruby-------------------------------------------------"
ruby -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install ruby..."
    sudo apt install -y ruby
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Check Latex------------------------------------------------"
latexmk -v
status=$?
if [ "$status" != 0 ]; then
    echo "Install Latexmk..."
    sudo apt install -y latexmk
fi
echo "-----------------------------------------------------------"
echo ""
sleep 1

echo "Install NeoVim Providers-----------------------------------"
echo ""
echo "Node:"
npm -v
if [ "$?" -eq 0 ]; then
    npm -g install neovim
fi

echo ""
echo "Python2:"
pip --version
if [ "$?" != 0 ]; then
    sudo apt install -y python-pip
fi
pip install neovim
pip install neovim-remote

echo ""
echo "Python3:"
pip3 --version
if [ "$?" != 0 ]; then
    sudo apt install -y python3-pip
fi
pip3 install neovim
pip3 install neovim-remote

echo ""
echo "Ruby:"
gem -v
if [ "$?" -eq 0 ]; then
    sudo apt install -y ruby-dev
    sudo gem install neovim
fi

echo ""
echo "Perl:"
sudo apt install -y cpanminus pmuninstall
cpanm -v
if [ "$?" -eq 0 ]; then
    cpanm --local-lib ~/perl5 Neovim::Ext
fi
cat ~/.bashrc | grep perl5
if [ "$?" != 0 ]; then
    echo 'eval $(perl -I $HOME/perl5/lib/perl5 -Mlocal::lib)' >>~/.bashrc
fi
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install ESLint--------------------------------------------"
eslint -v
if [ "$?" != 0 ]; then
    echo "Install eslint..."
    npm -g install eslint
fi
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install Astyle--------------------------------------------"
sudo apt install -y astyle
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install Ctags---------------------------------------------"
sudo apt install -y ctags
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install the other formatters------------------------------"
sudo apt install -y clang-format
sudo snap install shfmt
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install xclip---------------------------------------------"
sudo apt install -y xclip
echo "----------------------------------------------------------"
echo ""
sleep 1

green "Curl and Config Your NeoVim-------------------------------"
curl -o ~/.config/nvim/init.vim --create-dirs \
    https://raw.githubusercontent.com/devilyouwei/NVimmer/master/nvim/init.vim
if [ "$?" != 0 ]; then
    red "Network Error: curl fail to download 'init.vim'"
    exit 1
fi

curl -o ~/.config/nvim/coc-settings.json --create-dirs \
    https://raw.githubusercontent.com/devilyouwei/NVimmer/master/nvim/coc-settings.json
if [ "$?" != 0 ]; then
    red "Network Error: curl fail to download 'coc-settings.json'"
    exit 1
fi

curl -o ~/.eslintrc.json \
    https://raw.githubusercontent.com/devilyouwei/NVimmer/master/.eslintrc.json
if [ "$?" != 0 ]; then
    red "Network Error: curl fail to download '.eslintrc.json'"
    exit 1
fi

curl -o ~/.prettierrc.json \
    https://raw.githubusercontent.com/devilyouwei/NVimmer/master/.prettierrc.json
if [ "$?" != 0 ]; then
    red "Network Error: curl fail to download '.prettierrc.json'"
    exit 1
fi
green "Config successfully!"
green "----------------------------------------------------------"
echo ""
sleep 1

echo "Install vim-plug------------------------------------------"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ "$?" != 0 ]; then
    red "Network Error: curl fail to download 'plug.vim'"
    exit 1
fi
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Clean trash and packages----------------------------------"
sudo apt autoremove -y
if [ ! -d ".git" ]; then
    rm ubuntu_install.sh
fi
echo "----------------------------------------------------------"
echo ""
sleep 1

echo "Install NeoVim Plugins------------------------------------"
nvim -c PlugInstall -c q -c q
echo "Exit NeoVim..."
echo "All the plugins are installed!"
echo "----------------------------------------------------------"
echo ""
sleep 1

read -p "Set NeoVim as the default editor or replace vim?[Y/N]: " confirm

if [ "$confirm" = "y" ] || [ "$confrim" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ]; then
    echo "export EDITOR=/snap/bin/nvim" >>~/.bashrc
    echo "alias vim='nvim'" >>~/.bashrc
    echo "alias vi='nvim'" >>~/.bashrc
fi

echo ""
echo "-------------------------------------------------------END"
echo 'Enjoy! ( ￣▽ ￣)～■ *Cheers* □ ～(￣▽ ￣)'

echo ""
echo "--------------------NVimmer-------------------------------"
green " _   ___     ___                               "
green "| \\ | \\ \\   / (_)_ __ ___  _ __ ___   ___ _ __ "
green "|  \\| |\\ \\ / /| | '_ \` _ \\| '_ \` _ \\ / _ \\ '__|"
green "| |\\  | \\ V / | | | | | | | | | | | |  __/ |   "
green "|_| \\_|  \\_/  |_|_| |_| |_|_| |_| |_|\\___|_|"

echo "--------------------Favour--------------------------------"
echo '(๑ •̀ ㅂ•́ )و ✧ Like NVimmer? Go to:'
echo ""
blue 'https://github.com/devilyouwei/NVimmer'
echo ""
yellow '☆ ☆ ☆ ☆ ☆ '
echo ""
blue 'devilyouwei@gmail.com'
blue 'https://www.devil.ren'
blue '2ND Ave Long Branch NJ US'
blue '@devilyouwei'
echo ""
byellow '(Remeber to restart the terminal or reconnect to the server, then type nvim!)'
echo ""
