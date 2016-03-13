postOSInstall() {
	unamestr=`uname`
	LINUX=0
	OSX=0
	MSYS=0
	if [[ "$unamestr" == "Linux" ]]; then
		export LINUX=1
		export OS_NAME="linux"
	elif [[ "$unamestr" == "Darwin" ]]; then
		export OSX=1
		export OS_NAME="osx"
	elif [[ "$unamestr" == "MSYS"* ]]; then
		export MSYS=1
		export OS_NAME="msys"
	fi
	export XDG_CONFIG_HOME=$HOME/.config

	( ! hash sudo ) && alias sudo=""

	if (( LINUX )); then
		sudo pacman --noconfirm -Syu
		sudo pacman --noconfirm --needed -S base-devel zsh git neovim make cmake
		sudo chsh -s /bin/zsh sirblackheart
	fi

	if (( MSYS )); then
		sudo pacman -Syu --noconfirm
		sudo pacman -S --noconfirm --needed  zsh
		sudo pacman -S --noconfirm --needed  git
		sudo pacman -S --noconfirm --needed  tar
		sudo pacman -S --noconfirm --needed  vim
		sudo pacman -S --noconfirm --needed  make
		sudo pacman -S --noconfirm --needed  cmake
		sudo pacman -S --noconfirm --needed  autoconf
		sudo pacman -S --noconfirm --needed  automake
		cd bin && curl -J -O -L "http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=gitcredentialstore&DownloadId=834616&FileTime=130434786227870000&Build=21031"
	fi

	if (( OSX )); then
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew update
		brew install zsh git brew cask automake autoconf pgk-config source-highlight neovim
		sudo chsh -s /usr/local/bin/zsh
	fi

	rm -rf $XDG_CONFIG_HOME
	cd $HOME && git clone --recursive https://github.com/sirblackheart/.config
	cp $XDG_CONFIG_HOME/git/$OS_NAME/config.os $$XDG_CONFIG_HOME/git/config.os

	if (( MSYS )); then cd $HOME && curl -fsSLO https://raw.githubusercontent.com/sirblackheart/rc/master/.minttyrc
	fi

	if (( MSYS )); then
		cd $XDG_CONFIG_HOME/zsh-custom/plugins/zsh-syntax-highlighting
		cp zsh-syntax-highlighting.zsh zsh-syntax-highlighting.plugin.zsh
	fi
	cd $XDG_CONFIG_HOME/zsh-custom/plugins/zsh-git-prompt
	if (( MSYS )); then
		cp zshrc.sh zsh-git-prompt.plugin.zsh
	else
		ln -s zshrc.sh zsh-git-prompt.plugin.zsh
	fi

	if (( LINUX )); then
		sudo ln -s `which nvim` /usr/bin/vim
	fi

	if (( OSX )); then
		sudo rm /usr/bin/vim
		sudo ln -s `which nvim` /usr/bin/vim
	fi

	sudo zsh -c touch /etc/zsh/zshenv && print "export ZDOTDIR=$HOME/.config/zsh" >> /etc/zsh/zshenv
	sudo zsh -c touch /etc/zsh/zshenv && print "export HISTFILE=$HOME/.local/share/history" >> /etc/zsh/zshenv

	vim -c "PlugInstall"
}
