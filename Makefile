.DEFAULT_GOAL := dev
.PHONY: vim awesome zsh screen fonts git tmux tmuxinator

CONFIG_DIR := ${HOME}

DEB_PACKAGES_BASIC=aptitude git vim-nox screen zsh mercurial
DEB_PACKAGES_X=awesome fonts-inconsolata roxterm xclip
DEB_PACKAGES_DEV=ruby mosh ack-grep tmux vim-gtk

server: install_server vim screen zsh tmux
desktop: install_desktop awesome
dev: install_dev tmuxinator

LOCAL_BIN="${HOME}/bin"

base:
	mkdir -p ${LOCAL_BIN}

install_server: base
	sudo apt-get install ${DEB_PACKAGES_BASIC}

install_dev: server
	sudo apt-get install ${DEB_PACKAGES_DEV}

install_desktop: install_server
	sudo apt-get install ${DEB_PACKAGES_X}

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
	echo "Enter the correct password if want zsh as default shell"
	- chsh -s /bin/zsh && 0

screen:
	git clone https://github.com/joninvski/screen
	make -C screen

fonts:
	sudo aptitude install xfonts-terminus 			# Usefull for awesome top bar
	git clone https://github.com/joninvski/fonts
	make -C fonts

tmux:
	git clone https://github.com/joninvski/tmux
	make -C tmux

gitconfig:
	git clone https://github.com/joninvski/gitconfig
	make -C gitconfig

tmuxinator:
	gem install tmuxinator --user-install --bindir ${LOCAL_BIN}
	git clone https://github.com/joninvski/tmuxinator
	make -C tmuxinator
