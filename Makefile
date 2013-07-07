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
	make -C gitconfig/Makefile

vim:
	git clone https://github.com/joninvski/vim
	make -C vim/Makefile

awesome:
	git clone https://github.com/joninvski/awesome
	make -C awesome/Makefile

zsh:
	git clone https://github.com/joninvski/oh-my-zsh
	make -C oh-my-zsh/Makefile

screen:
	git clone https://github.com/joninvski/screen
	make -C screen/Makefile

fonts:
	git clone https://github.com/joninvski/fonts
	make -C fonts/Makefile

tmux:
	git clone https://github.com/joninvski/tmux
	make -C tmux/Makefile

gitconfig:
	git clone https://github.com/joninvski/gitconfig
	make -C gitconfig/Makefile
