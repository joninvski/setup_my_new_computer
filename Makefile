.DEFAULT_GOAL := server
.PHONY: vim awesome zsh screen fonts config git

CONFIG_DIR := ${HOME}

DEB_PACKAGES_BASIC=aptitude git vim-nox screen zsh mercurial
DEB_PACKAGES_X=awesome fonts-inconsolata roxterm xclip

server: install_server vim screen zsh tmux
desktop: install_desktop awesome

install_server:
	sudo apt-get install ${DEB_PACKAGES_BASIC}

install_desktop: install_server
	sudo apt-get install ${DEB_PACKAGES_X}

config:
	chsh -s /bin/zsh

git:
	git clone https://github.com/joninvski/gitconfig
	make -C gitconfig

vim:
	git clone https://github.com/joninvski/vim
	make -C vim

awesome:
	git clone https://github.com/joninvski/awesome
	make -C awesome

zsh:
	git clone https://github.com/joninvski/zsh
	make -C zsh

screen:
	git clone https://github.com/joninvski/screen
	make -C screen

fonts:
	git clone https://github.com/joninvski/fonts
	make -C fonts

tmux:
	git clone https://github.com/joninvski/tmux
	make -C tmux

gitconfig:
	git clone https://github.com/joninvski/gitconfig
	make -C gitconfig
