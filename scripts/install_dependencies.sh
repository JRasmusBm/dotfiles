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
  sudo apt-get install -y build-essential
  sudo apt-get install -y checkinstall
  sudo apt-get install -y libreadline-gplv2-dev
  sudo apt-get install -y libncursesw5-dev
  sudo apt-get install -y libssl-dev
  sudo apt-get install -y libsqlite3-dev
  sudo apt-get install -y tk-dev
  sudo apt-get install -y libgdbm-dev
  sudo apt-get install -y libc6-dev
  sudo apt-get install -y libbz2-dev
  sudo apt-get install -y zlib1g-dev
  sudo apt-get install -y openssl
  sudo apt-get install -y libffi-dev
  sudo apt-get install -y python3-dev
  sudo apt-get install -y python3-setuptools
  sudo apt-get install -y wget

  mkdir /tmp/Python37
  cd /tmp/Python37

  wget https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tgz
  tar zxvf Python-3.7.5.tar.tgz
  cd /tmp/Python37/Python-3.7.5
  ./configure
  sudo make altinstall
  sudo update-alternatives --install /usr/bin/python /usr/local/bin/python3.7
}

install_virtualenvwrapper() {
  python3.7 -m pip install virtualenvwrapper
  source "/usr/local/bin/virtualenvwrapper.sh"
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
  sudo apt-get install -y fonts-hack-ttf
  sudo add-apt-repository ppa:system76/pop
  sudo apt-get update
  sudo apt-get install alacritty
}

install_tmux() {
  sudo apt-get update
  sudo apt-get install -y automake
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
  install_python
  install_zsh
  install_node
  install_nvim
  install_tmux
  install_docker
  update_system
}

install_dependencies_desktop() {
  uninstall_unnecessary_stuff
  install_git_extras
  install_latest_chrome
  install_brave
  install_zsh
  install_alacritty
  install_python
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
