#!/bin/bash

update_system() {
  sudo apt-get -y update
  sudo apt -y update
  sudo apt-get -y upgrade
  sudo apt -y upgrade
  sudo apt autoremove -y
  sudo apt-get autoremove -y
}

install_python_37() {
  sudo apt-get install -o Dpkg::Options::="--force-confnew" -y \
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
    libsqlite3-dev  \
    libssl-dev  \
    openssl  \
    sqlite3  \
    tk-dev \
    uuid-dev \
    wget \
    gcc \
    cmake \
    make \
    zlib1g-dev

  export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
  current=$(pwd)
  sudo rm -rf /tmp/Python37
  mkdir -p /tmp/Python37
  cd /tmp/Python37

  wget https://www.python.org/ftp/python/3.7.8/Python-3.7.8.tgz
  tar zxvf Python-3.7.8.tgz
  cd /tmp/Python37/Python-3.7.8
  ./configure --enable-shared
  sudo make altinstall
  cd $current
  sudo rm -rf /tmp/Python37
}

install_python_38() {
  sudo apt-get install -o Dpkg::Options::="--force-confnew" -y \
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
    libsqlite3-dev  \
    libssl-dev  \
    openssl  \
    sqlite3  \
    tk-dev \
    uuid-dev \
    wget \
    gcc \
    cmake \
    make \
    zlib1g-dev

  export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
  current=$(pwd)
  sudo rm -rf /tmp/Python37
  mkdir -p /tmp/Python37
  cd /tmp/Python37

  wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
  tar zxvf Python-3.8.5.tgz
  cd /tmp/Python37/Python-3.8.5
  ./configure --enable-shared
  sudo make altinstall
  cd $current
  sudo rm -rf /tmp/Python37
}

install_node() {
  sudo apt-get install -y \
    software-properties-common \
    curl
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
  sudo apt-get install -y nodejs
  sudo npm cache clean -f
  sudo npm install -g n
  sudo n stable
  sudo npm install npm@latest -g
  sudo npm install neovim@latest -g
  sudo npm install typescript@latest -g
  sudo npm install prettier@latest -g
}

# --- Everything above this line is tested ---

install_brave() {
  sudo apt install -y curl
  curl -s https://brave-browser-apt-beta.s3.brave.com/brave-core-nightly.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-beta.gpg add -
  source /etc/os-release
  echo "deb [arch=amd64] https://brave-browser-apt-beta.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-beta-${UBUNTU_CODENAME}.list
  sudo apt update
  sudo apt install -y brave-browser-beta
}

install_ruby() {
  sudo apt update
  sudo apt install -y ruby-full
  sudo gem install -y vimgolf
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
  wget https://github.com/cli/cli/releases/download/v0.11.1/gh_0.11.1_linux_amd64.deb
  sudo dpkg -i gh_0.11.1_linux_amd64.deb
  rm gh_0.11.1_linux_amd64.deb
  sudo apt-get install -y git-extras
}

install_haskell() {
  curl -sSL https://get.haskellstack.org/ | sh
}

install_virtualenvwrapper() {
  export WORKON_HOME=$HOME/.virtualenvs
  export VIRTUALENVWRAPPER_PYTHON=$(which python3.7)
  python3.7 -m pip install --user virtualenvwrapper
  source "/usr/local/bin/virtualenvwrapper.sh"
}

function install_sshd() {
  sudo apt install -y openssh-server
}

install_blas() {
  sudo apt-get -y install libblas-dev liblapack-dev
}

install_clipboard_manager() {
  sudo add-apt-repository -y ppa:hluk/copyq
  sudo apt update
  sudo apt install -y copyq
}

install_nvim() {
  current=$(pwd)
  sudo apt-get install -y \
    build-essential \
    make \
    cmake \
    cmake-data \
    pkg-config \
    libtool-bin \
    automake \
    curl \
    gettext \
    zip
  rm -rf /tmp/nvim
  git clone git@github.com:neovim/neovim.git /tmp/nvim
  cd /tmp/nvim
  sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd $current
  sudo rm -rf /tmp/nvim
  setup_neovim_vm
}

install_fonts() {
  git clone https://github.com/powerline/fonts.git --depth=1
  current = $(pwd)
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
  mkdir -p ~/.config/fontconfig
  cd ~/.config/fontconfig
  wget https://github.com/powerline/fonts/blob/master/fontconfig/50-enable-terminess-powerline.conf
  fc-cache -vf
  fc-cache -vf ~/.local/share/fonts/
  cd $current
}

install_fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
}

setup_neovim_vm() {
  if command -v python2
  then
    mkvirtualenv -p python2 neovim2
    workon neovim2
    pip install neovim
    pip install yapf
    pip install grip
    pip install flake8
    pip install black
    deactivate
  fi
  if command -v python2
  then
    mkvirtualenv -p python3 neovim3
    workon neovim3
    pip install neovim
    pip install yapf
    pip install grip
    pip install flake8
    pip install black
    deactivate
  fi
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
  sudo apt-get install -o Dpkg::Options::="--force-confnew" -y \
    zsh \
    fonts-powerline
  mkdir -p ~/.zsh
  curl -L git.io/antigen > ~/.zsh/antigen.zsh
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
  sudo apt-get install -o Dpkg::Options::="--force-confnew" -y \
    automake \
    byacc \
    autoconf \
    build-essential \
    pkg-config \
    libevent-dev \
    libncurses5-dev
  current=$(pwd)
  sudo rm -rf /tmp/tmux
  git clone https://github.com/tmux/tmux.git /tmp/tmux
  cd /tmp/tmux
  git checkout master
  sh autogen.sh
  ./configure && make
  sudo make install
  cd $current
  sudo rm -rf /tmp/tmux
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

install_latest_firefox() {
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A6DCF7707EBC211F
  sudo apt-add-repository "deb http://ppa.launchpad.net/ubuntu-mozilla-security/ppa/ubuntu bionic main"
  sudo apt update
  sudo apt install -y firefox
}

install_java() {
  sudo apt-get install -y default-jdk
}

install_spotify_cli() {
  sudo apt install -y \
    libncursesw5-dev \
    libdbus-1-dev \
    libpulse-dev \
    libssl-dev \
    libxcb1-dev \
    libxcb-render0-dev \
    libxcb-shape0-dev \
    libxcb-xfixes0-dev

  cargo install ncspot
}

install_docker() {
  sudo apt-get remove docker docker-engine docker.io containerd runc
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker ${USER}
  sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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
