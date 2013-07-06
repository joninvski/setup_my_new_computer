.DEFAULT_GOAL := server

CONFIG_DIR=${HOME}

DEB_PACKAGES_BASIC="aptitude git vim-nox screen zsh"
DEB_PACKAGES_X="awesome fonts-inconsolata roxterm xclip"

server: install_server vim awesome screen zsh
desktop: install_desktop
	
install_server:
	sudo apt-get install ${DEB_PACKAGES_BASIC} 

install_desktop: install_server
	sudo apt-get install ${DEB_PACKAGES_X} 

config:
	chsh /usr/bin/zsh

git: apt
	cd ${CONFIG_DIR}
	git clone https://github.com/joninvski/gitconfig
	cd gitconfig
	make

vim: apt
	cd ${CONFIG_DIR}
	git clone https://github.com/joninvski/vim
	cd vim
	make

awesome: apt
	cd ${CONFIG_DIR}
	git clone https://github.com/joninvski/awesome
	cd awesome
	make

zsh: apt
	cd ${CONFIG_DIR}
	git clone https://github.com/joninvski/oh-my-zsh
	cd oh-my-zsh
	make

screen: apt
	cd ${CONFIG_DIR}
	git clone https://github.com/joninvski/screen
	cd screen
	make

fonts: apt
	cd ${CONFIG_DIR}
	git clone https://github.com/joninvski/fonts
	cd fonts
	make
