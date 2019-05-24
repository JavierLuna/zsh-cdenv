# Auto activate/deactivate virtual environments if a git repo is detected.
# Im no POSIX expert sorry

function cd {
    builtin cd "$@"
    POSSIBLE_ENV_NAMES=( "env" "ENV" "venv" "VENV" ) # In a future version this could be customizable
    REPO=$(git rev-parse --show-toplevel 2> /dev/null)
    IS_IN_REPO=$?

    if [ ! -z "$VIRTUAL_ENV" ]; then
        IS_IN_VIRTUAL_ENV=1
    else
        IS_IN_VIRTUAL_ENV=0
    fi
    if [ $IS_IN_REPO -eq 0 ]; then
        if [ $IS_IN_VIRTUAL_ENV -eq 0 ]; then
            for ENV_NAME in $POSSIBLE_ENV_NAMES; do
                if [ -e "$REPO/$ENV_NAME/bin/activate" ]; then
                    source $REPO/$ENV_NAME/bin/activate
                    break
                fi
            done
        fi
    else
        if [ $IS_IN_VIRTUAL_ENV -eq 1 ]; then
            deactivate
        fi
    fi
}

