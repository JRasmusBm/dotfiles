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

install_python_39() {
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt update 
  sudo apt install -y python3.9
}

install_virtualenvwrapper() {
  export WORKON_HOME=$HOME/.virtualenvs
  export VIRTUALENVWRAPPER_PYTHON=$(which python3.7)
  python3.7 -m pip install --user virtualenv
  python3.7 -m pip install --user virtualenvwrapper
  source "$HOME/.local/bin/virtualenvwrapper.sh"
}

install_ruby() {
  sudo apt update
  ruby_version=2.7.1
  wget https://cache.ruby-lang.org/pub/ruby/2.7/ruby-$ruby_version.tar.gz
  tar zxvf ruby-$ruby_version.tar.gz
  cd ruby-$ruby_version
  ./configure
  make
  sudo make install
  cd ..
  rm -rf ruby-$ruby_version
  rm -rf ruby-$ruby_version.tar.gz
  install_ruby_extras
}

install_ruby_extras() {
 sudo gem install vimgolf
 sudo gem install neovim
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

install_brave() {
  sudo apt install -y curl
  curl -s https://brave-browser-apt-beta.s3.brave.com/brave-core-nightly.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-beta.gpg add -
  source /etc/os-release
  echo "deb [arch=amd64] https://brave-browser-apt-beta.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-beta-${UBUNTU_CODENAME}.list
  sudo apt update
  sudo apt install -y brave-browser-beta
}

install_screenkey() {
  sudo snap install --beta screenkey
}

install_git_extras() {
  TEMP_DEB="$(mktemp)"
  wget -O "$TEMP_DEB" "https://github.com/cli/cli/releases/download/v1.9.2/gh_1.9.2_linux_amd64.deb"
  sudo dpkg -i "$TEMP_DEB"
  rm -f "$TEMP_DEB"
  sudo apt-get install -y git-extras
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
  git checkout 4be0e92db
  sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd $current
  sudo rm -rf /tmp/nvim
  setup_neovim_vm
}

install_ripgrep() {
  TEMP_DEB="$(mktemp)"
  curl -L -o $TEMP_DEB https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
  sudo dpkg -i $TEMP_DEB
  rm $TEMP_DEB
}

setup_neovim_vm() {
  if ! command -v mkvirtualenv
  then
    install_virtualenvwrapper
  fi
  if command -v python2
  then
    mkvirtualenv -p $(which python2) neovim2
    workon neovim2
    pip install pynvim
    pip install yapf
    pip install grip
    pip install notedown
    pip install flake8
    pip install black
    deactivate
  fi
  if command -v python3
  then
    mkvirtualenv -p $(which python3) neovim3
    workon neovim3
    pip install pynvim
    pip install notedown
    pip install yapf
    pip install grip
    pip install flake8
    pip install black
    pip install python-language-server
    pip install pyls-black
    pip install pyls-mypy
    pip install pyls-isort
    deactivate
  fi
}

load_nvim_plugins() {
  git submodule init
  git submodule update --recursive
}

# --- Everything above this line is tested ---

install_luarocks() {
  wget https://luarocks.org/releases/luarocks-3.7.0.tar.gz
  tar zxpf luarocks-3.7.0.tar.gz
  cd luarocks-3.7.0
  ./configure --with-lua-include=/usr/include/lua5.3 
  make
  sudo make install 
  cd ..
  rm -rf luarocks-3.7.0
}

install_markdown_language_server() {
 wget -O ~/.local/bin/zeta-note https://github.com/artempyanykh/zeta-note/releases/download/2021-04-05/zeta-note-linux
 chmod +x ~/.local/bin/zeta-note
}

install_lua_language_server() {
  CURRENT_PATH=$(pwd)
  cd ~/.cache/
  git clone git@github.com:sumneko/lua-language-server.git
  cd lua-language-server
  git submodule update --init --recursive
  cd 3rd/luamake
  compile/install.sh
  cd ../..
  ./3rd/luamake/luamake rebuild
  cd $CURRENT_PATH
}

install_lua() {
  sudo apt install -y \
    lua5.3 \
    liblua5.3-dev
 install_luarocks
 install_lua_language_server
}

install_xmonad() {
  cabal install -z --lib --package-env=$HOME/.xmonad/ \
    xmonad \
    xmodbar \
    xmonad-contrib
}

install_bat() {
  sudo apt-get install bat
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
}

install_brave_stable() {
    sudo apt install -y apt-transport-https curl

    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install -y brave-browser
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

install_haskell() {
  curl -sSL https://get.haskellstack.org/ | sh
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
  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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
