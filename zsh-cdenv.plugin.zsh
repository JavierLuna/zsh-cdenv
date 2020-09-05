# Auto activate/deactivate virtual environments if a git repo is detected.
# Im no POSIX expert sorry

function _zsh_cdenv_current_dir {
	git rev-parse --show-toplevel 2> /dev/null
}

function _zsh_cdenv_activate_venv {
    if [ ! -z "$POSSIBLE_ENV_NAMES" ]; then
        POSSIBLE_ENV_NAMES=( "env" "ENV" "venv" "VENV" ) # In a future version this could be customizable
    fi

    for ENV_NAME in $POSSIBLE_ENV_NAMES; do
	if [ -e "$1/$ENV_NAME/bin/activate" ]; then
		source $1/$ENV_NAME/bin/activate
                break
        fi
    done
}

function cd {
    builtin cd "$@"

    local CURRENT_REPOSITORY=$(_zsh_cdenv_current_dir)
    if [ ! -z "$VIRTUAL_ENV" ]; then
        IS_IN_VIRTUAL_ENV=1
    else
        IS_IN_VIRTUAL_ENV=0
    fi

    if [[ "$_ZSH_CDENV_LAST_REPOSITORY" != "$CURRENT_REPOSITORY" ]]; then
        if [ $IS_IN_VIRTUAL_ENV -eq 0 ]; then
        	_zsh_cdenv_activate_venv $CURRENT_REPOSITORY    
	else
	    deactivate
	    _zsh_cdenv_activate_venv $CURRENT_REPOSITORY
    	fi
    fi
    export _ZSH_CDENV_LAST_REPOSITORY=$(_zsh_cdenv_current_dir)
}

