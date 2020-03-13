#!/bin/bash

install_ruby() {
  sudo apt update
  sudo apt install -y ruby-full
  sudo gem install vimgolf
}

install_rust() {
  curl https://sh.rustup.rs -sSf | sh
}

install_cs() {
  wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  sudo add-apt-repository universe
  sudo apt-get install -y apt-transport-https
  sudo apt-get update
  sudo apt-get install -y dotnet-sdk-2.2
  git clone git@github.com:uncrustify/uncrustify.git
  cd uncrustify
  configure
  make install
  cd ..
  rm -rf uncrustify
  sudo rm packages-microsoft-prod.deb
}

install_pyautogui() {
  git clone git@github.com:JRasmusBm/pyautogui.git .pyautogui
  cd .pyautogui
  pipenv install
  cd ..
}

install_git_extras() {
  sudo apt-get install -y git-extras
}

install_haskell() {
  curl -sSL https://get.haskellstack.org/ | sh
}

install_python_37() {
  sudo apt-get install -y \
    build-essential \
    bzip2  \
    checkinstall \
    libbz2-dev  \
    libc6-dev \
    libffi-dev \
    libgdbm-compat-dev  \
    libgdbm-dev  \
    liblzma-dev  \
    libncursesw5-dev  \
    libreadline-dev  \
    libreadline-gplv2-dev \
    libsqlite3-dev  \
    libssl-dev  \
    openssl  \
    sqlite3  \
    tk-dev \
    uuid-dev \
    wget \
    zlib1g-dev

  current=$(pwd)
  mkdir /tmp/Python37
  pushd /tmp/Python37

  wget https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tgz
  tar zxvf Python-3.7.7.tgz
  cd /tmp/Python37/Python-3.7.7
  ./configure --enable-shared
  sudo make altinstall
  cd $current
  rm -rf /tmp/Python37
}

install_virtualenvwrapper() {
  python3.7 -m pip install virtualenvwrapper
  source "/usr/local/bin/virtualenvwrapper.sh"
}

install_clipboard_manager() {
  sudo add-apt-repository -y ppa:hluk/copyq
  sudo apt update
  sudo apt install -y copyq
}

install_nvim() {
  sudo apt-get install -y build-essential
  sudo apt-get install -y make
  sudo apt-get install -y cmake
  sudo apt-get install -y cmake-data
  sudo apt-get install -y pkg-config
  sudo apt-get install -y libtool-bin
  sudo apt-get install -y automake
  sudo apt-get install -y curl
  git clone git@github.com:neovim/neovim.git
  cd neovim
  sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd ..
  sudo rm -rf neovim
  setup_neovim_vm
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

setup_neovim_vm() {
  mkvirtualenv -p python3 neovim3
  mkvirtualenv -p python2 neovim2
  workon neovim2
  pip install neovim
  pip install yapf
  pip install grip
  pip install flake8
  pip install black
  deactivate
  workon neovim3
  pip install neovim
  pip install yapf
  pip install grip
  pip install flake8
  pip install black
  deactivate
}

install_node() {
  curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
  sudo apt install -y nodejs
  sudo npm cache clean -f
  sudo npm install -g n
  sudo n stable
  sudo npm install npm@latest -g
  sudo npm install neovim@latest -g
  sudo npm install typescript@latest -g
  sudo npm install prettier@latest -g
}

install_vim() {
  VIMVERSION=$(vim --version | head -1 | cut -d ' ' -f 5)
  git clone https://gist.github.com/d67c5c3efa1e6dbe17216fac9fd4adc8.git temp
  cd temp
  chmod +x gistfile.sh
  ./gistfile.sh
  cd ..
  rm -rf temp
}

install_zsh() {
  sudo apt-get update
  sudo apt-get install -y zsh
  sudo usermod -s $(which zsh) $(whoami)
  mkdir .zsh
  curl -L git.io/antigen > .zsh/antigen.zsh
  sudo apt-get install -y fonts-powerline
}

install_alacritty() {
  TEMP_DEB="$(mktemp)"
  wget -O $TEMP_DEB https://github.com/alacritty/alacritty/releases/download/v0.4.1/Alacritty-v0.4.1-ubuntu_18_04_amd64.deb 
  sudo dpkg -i $TEMP_DEB
  rm -f $TEMP_DEB
  sudo update-alternatives --install "$(which x-terminal-emulator)" x-terminal-emulator "$(which alacritty)" 50
  sudo update-alternatives --set x-terminal-emulator $(which alacritty)
}

uninstall_alacritty() {
  sudo dpkg --remove alacritty
}

install_tmux() {
  sudo apt-get update
  sudo apt-get install -y automake
  sudo apt-get install -y byacc
  sudo apt-get install -y autoconf
  sudo apt-get install -y build-essential
  sudo apt-get install -y pkg-config
  sudo apt-get install -y libevent-dev
  sudo apt-get install -y libncurses5-dev
  rm -fr /tmp/tmux
  git clone https://github.com/tmux/tmux.git /tmp/tmux
  cd /tmp/tmux
  git checkout master
  sh autogen.sh
  ./configure && make
  sudo make install
  cd -
  rm -rf /tmp/tmux
}

uninstall_unnecessary_stuff() {
  sudo apt-get purge -y thunderbird
  sudo apt-get purge -y rhythmbox
  sudo apt-get purge -y ubuntu-web-launchers
}

install_latest_chrome() {
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb
}

install_brave() {
  curl -s https://brave-browser-apt-beta.s3.brave.com/brave-core-nightly.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-beta.gpg add -
  source /etc/os-release
  echo "deb [arch=amd64] https://brave-browser-apt-beta.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-beta-${UBUNTU_CODENAME}.list
  sudo apt update
  sudo apt install brave-browser-beta
}

install_latest_firefox() {
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A6DCF7707EBC211F
  sudo apt-add-repository "deb http://ppa.launchpad.net/ubuntu-mozilla-security/ppa/ubuntu bionic main"
  sudo apt update
  sudo apt install firefox
}

install_java() {
  sudo apt-get install -y default-jdk
}

update_system() {
  sudo apt-get -y update
  sudo apt -y update
  sudo apt-get -y upgrade
  sudo apt -y upgrade
  sudo apt autoremove
  sudo apt-get autoremove
}

install_spotify() {
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update
  sudo apt-get install -y spotify-client
}

install_docker() {
  sudo apt update
  sudo apt install -y apt-transport-https
  sudo apt install -y ca-certificates
  sudo apt install -y curl
  sudo apt install -y software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  sudo apt update
  sudo apt install -y docker-ce
  sudo usermod -aG docker ${USER}
  sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

install_dependencies_server() {
  uninstall_unnecessary_stuff
  update_system
  install_python_37
  install_zsh
  install_node
  install_nvim
  install_tmux
  install_docker
  update_system
}

install_dependencies_desktop() {
  uninstall_unnecessary_stuff
  update_system
  install_clipboard_manager
  install_git_extras
  install_latest_chrome
  install_brave
  install_zsh
  install_alacritty
  install_python_37
  install_node
  install_nvim
  install_tmux
  install_java
  install_docker
  install_ruby
  install_spotify
  install_pyautogui
  update_system
}
