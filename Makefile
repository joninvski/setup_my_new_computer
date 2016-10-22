.DEFAULT_GOAL := dev
.PHONY: vim awesome zsh screen fonts git tmux tmuxinator android gradle_scripts

CONFIG_DIR := ${HOME}

DEB_PACKAGES_BASIC=aptitude git vim-nox screen zsh mercurial exuberant-ctags htop rar cmake
DEB_PACKAGES_X=awesome awesome-extra fonts-inconsolata roxterm xclip suckless-tools
DEB_PACKAGES_DEV=ruby mosh ack-grep tmux vim-gtk inotify-tools astyle
DEB_PACKAGES_ANDROID=libncurses5:i386 libstdc++6:i386 zlib1g:i386

server: install_server vim screen zsh tmux
desktop: install_desktop awesome
dev: install_dev tmuxinator

LOCAL_BIN="${HOME}/bin"

base:
	mkdir -p ${LOCAL_BIN}
	sudo apt-get install ${DEB_PACKAGES_BASIC}

install_server: base
	echo "TODO - Install server stuff"

install_dev: base
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

tmuxinator:
	gem install tmuxinator --user-install --bindir ${LOCAL_BIN}
	git clone https://github.com/joninvski/tmuxinator
	make -C tmuxinator

pidcat: base
	- git clone https://github.com/JakeWharton/pidcat
	chmod a+x pidcat/pidcat.py
	cd pidcat && ln -fs `pwd`/pidcat.py ${LOCAL_BIN}/pidcat

ANDROID_SDK=android-sdk_r23.0.2-linux.tgz
BUILD_TOOLS=build-tools-19.0.3
LATEST_VERSION=19

android: pidcat base zsh oracle_java
	sudo dpkg --add-architecture i386
	sudo apt-get update
	sudo apt install ${DEB_PACKAGES_ANDROID}
	# Install repo for android aosp compilation
	wget "http://commondatastorage.googleapis.com/git-repo-downloads/repo" -O ${LOCAL_BIN}/repo
	chmod a+x ${LOCAL_BIN}/repo
	# Now get the android sdk
	- mkdir android
	wget "http://dl.google.com/android/${ANDROID_SDK}" -O android/android-sdk.tgz
	cd android && tar xvzf android-sdk.tgz
	echo -n 'ANDROID_HOME=$${ANDROID_HOME:=' > ~/zsh/paths-to-add/android
	echo "`pwd`/android/android-sdk-linux}" >> ~/zsh/paths-to-add/android
	echo 'PATH=$${PATH}:$${ANDROID_HOME}/platform-tools' >> ~/zsh/paths-to-add/android
	echo 'PATH=$${PATH}:$${ANDROID_HOME}/tools' >> ~/zsh/paths-to-add/android
	echo 'export ANDROID_HOME' >> ~/zsh/paths-to-add/android
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --all --filter tools,platform-tools       --no-ui --force
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --all --filter ${BUILD_TOOLS}             --no-ui --force
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --all --filter android-${LATEST_VERSION}  --no-ui --force
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --all --filter sysimg-${LATEST_VERSION}   --no-ui --force
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --all --filter extra-android-support      --no-ui --force
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --all --filter extra-android-m2repository --no-ui --force
	echo y | `pwd`/android/android-sdk-linux/tools/android update sdk --all --filter doc                        --no-ui --force
	ln -s `pwd`/android ${HOME}/android

android_source:
	mkdir android_source
	cd android_source; repo init -u https://android.googlesource.com/platform/manifest
	echo "Get ready, this is going to take sometime"
	cd android_source; repo sync

oracle_java:
	sudo bash -c 'echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list'
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	sudo apt-get update
	sudo apt-get install oracle-java7-installer

gradle_scripts:
	git clone https://github.com/joninvski/gradle_scripts
	make -C gradle_scripts/

roxterm:
	git clone https://github.com/joninvski/roxterm.git
	make -C roxterm/

wallpaper:
	git clone https://github.com/joninvski/cheatsheet.git
	make -C cheatsheet
