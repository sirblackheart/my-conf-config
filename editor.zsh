if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	if (( $+commands[nvim] )) ; then
		export EDITOR='nvim'
	else
		export EDITOR='vim'
	fi
fi
