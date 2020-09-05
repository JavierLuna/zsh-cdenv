# Auto activate/deactivate virtual environments if a git repo is detected.
# Im no POSIX expert sorry

function _zsh_cdenv_current_repo {
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
    local LAST_REPOSITORY=$(_zsh_cdenv_current_repo)
    builtin cd "$@"
    local CURRENT_REPOSITORY=$(_zsh_cdenv_current_repo)
    
    if [ ! -z "$VIRTUAL_ENV" ]; then
        local IS_IN_VIRTUAL_ENV=1
    else
        local IS_IN_VIRTUAL_ENV=0
    fi

    if [[ "$LAST_REPOSITORY" != "$CURRENT_REPOSITORY" ]]; then
        if [ $IS_IN_VIRTUAL_ENV -eq 0 ]; then
        	_zsh_cdenv_activate_venv $CURRENT_REPOSITORY    
	else
	    deactivate
	    _zsh_cdenv_activate_venv $CURRENT_REPOSITORY
    	fi
    fi
}

