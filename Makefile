.DEFAULT_GOAL := all

CONFIG_DIR=${HOME}

all: apt vim awesome screen zsh fonts
	
apt:
	sudo apt-get install aptitude git vim-nox screen zsh awesome fonts-inconsolata roxterm xclip

git: apt
	cd ${HOME}
	git clone https://github.com/joninvski/gitconfig
	cd gitconfig
	make

vim: apt
	cd ${HOME}
	git clone https://github.com/joninvski/vim
	cd vim
	make

awesome: apt
	cd ${HOME}
	git clone https://github.com/joninvski/awesome
	cd awesome
	make

zsh: apt
	cd ${HOME}
	git clone https://github.com/joninvski/oh-my-zsh
	cd oh-my-zsh
	make

screen: apt
	cd ${HOME}
	git clone https://github.com/joninvski/screen
	cd screen
	make

fonts: apt
	cd ${HOME}
	git clone https://github.com/joninvski/fonts
	cd fonts
	make
