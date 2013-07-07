.DEFAULT_GOAL := server
.PHONY: vim awesome zsh screen fonts config git

CONFIG_DIR := ${HOME}

DEB_PACKAGES_BASIC=aptitude git vim-nox screen zsh mercurial
DEB_PACKAGES_X=awesome fonts-inconsolata roxterm xclip

server: install_server git_sync vim screen zsh tmux
desktop: install_desktop awesome

install_server:
	sudo apt-get install ${DEB_PACKAGES_BASIC}

install_desktop: install_server
	sudo apt-get install ${DEB_PACKAGES_X}

config:
	chsh -s /bin/zsh

git:
	git clone https://github.com/joninvski/gitconfig
	make -C gitconfig/make

vim:
	git clone https://github.com/joninvski/vim
	make -C vim/make

awesome:
	git clone https://github.com/joninvski/awesome
	make -C awesome/make

zsh:
	git clone https://github.com/joninvski/oh-my-zsh
	make -C oh-my-zsh/make

screen:
	git clone https://github.com/joninvski/screen
	make -C screen/make

fonts:
	git clone https://github.com/joninvski/fonts
	make -C fonts/make

tmux:
	git clone https://github.com/joninvski/tmux
	make -C tmux/make

gitconfig:
	git clone https://github.com/joninvski/gitconfig
	make -C gitconfig/make
