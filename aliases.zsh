if (( ! $+commands[sudo] )) ; then
	alias sudo=""
fi

if (( $+commands[nvim] )) ; then
	alias vim="nvim"
fi

if (( $+commands[mplayer] )) ; then
	alias fm4="mplayer -cache 8192 -cache-min 20 http://194.232.200.150:8000"
	alias fm4.2="mplayer -cache 8192 -cache-min 20 http://198.50.155.189:8009"
fi

alias suvim="sudo -E vim"
alias root="su -m root"

((MSYS)) && alias upgrade="sudo pacman -Syu"
((OSX)) && alias upgrade="brew update && brew upgrade --all"

config() {
	if [[ $* == "zsh" ]]; then FILE=~/.zshrc && vim $FILE;
	elif [[ $* == "vim" ]]; then FILE=~/.vimrc && vim $FILE;
	else echo "not configurable"; fi
}
