.DEFAULT_GOAL := server
.PHONY: vim awesome zsh screen fonts config git

CONFIG_DIR=${HOME}

DEB_PACKAGES_BASIC=aptitude git vim-nox screen zsh mercurial
DEB_PACKAGES_X=awesome fonts-inconsolata roxterm xclip

server: install_server vim awesome screen zsh
desktop: install_desktop
	
install_server:
	sudo apt-get install ${DEB_PACKAGES_BASIC} 

install_desktop: install_server
	sudo apt-get install ${DEB_PACKAGES_X} 

config:
	chsh /usr/bin/zsh

git: 
	cd ${CONFIG_DIR};git clone https://github.com/joninvski/gitconfig;cd gitconfig;make

vim: 
	cd ${CONFIG_DIR};git clone https://github.com/joninvski/vim;cd vim;make

awesome: 
	cd ${CONFIG_DIR};git clone https://github.com/joninvski/awesome;cd awesome;make

zsh: 
	cd ${CONFIG_DIR};git clone https://github.com/joninvski/oh-my-zsh;cd oh-my-zsh;make

screen: 
	cd ${CONFIG_DIR};git clone https://github.com/joninvski/screen;cd screen;make

fonts: 
	cd ${CONFIG_DIR};git clone https://github.com/joninvski/fonts;cd fonts;make
