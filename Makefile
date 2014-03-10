.DEFAULT_GOAL := dev
.PHONY: vim awesome zsh screen fonts git tmux tmuxinator android

CONFIG_DIR := ${HOME}

DEB_PACKAGES_BASIC=aptitude git vim-nox screen zsh mercurial exuberant-ctags
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

android:
	wget "http://commondatastorage.googleapis.com/git-repo-downloads/repo" -O ${LOCAL_BIN}/repo
	chmod a+x ${LOCAL_BIN}/repo
	mkdir android
	wget "http://dl.google.com/android/android-sdk_r22.6-linux.tgz" -O android/android-sdk.tgz
	cd android && tar xvzf android-sdk.tgz
	echo -n 'ANDROID_HOME=$${ANDROID_HOME:=' > ~/zsh/paths-to-add/android
	echo "`pwd`/android/android-sdk-linux}" >> ~/zsh/paths-to-add/android
	echo 'PATH=$${PATH}:$${ANDROID_HOME}/platform-tools' >> ~/zsh/paths-to-add/android
	echo 'PATH=$${PATH}:$${ANDROID_HOME}/tools' >> ~/zsh/paths-to-add/android
	echo 'export ANDROID_HOME' >> ~/zsh/paths-to-add/android
	wget https://dl-ssl.google.com/android/repository/build-tools_r19-linux.zip -O build-tools_r19-linux.zip
	unzip build-tools_r19-linux.zip -d android/android-sdk
	mkdir -p android/android-sdk/build-tools/
	mv  android/android-sdk/android-4.4 android/android-sdk/build-tools/19
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --filter 1,2 --no-ui --force
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --filter tools,android-19,sysimg-19,extra-android-support,extra-android-m2repository --no-ui --force
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --filter doc --no-ui --force
