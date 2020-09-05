# ZSH cdenv
A ZSH plugin which acts as glue between git and virtualenv in my python workflow

## What does it do?

Whenever you cd in a git repository, it will check if there's a virtual environment in the root of that repository. If it does exist, activate it.

In addition, If you leave the repository, the environment will be deactivated.

Default supported environment names:

* `env`
* `ENV`
* `venv`
* `VENV`

You can override the `POSSIBLE_ENV_NAMES` environmental variable to customize the plugin with your own names, like (`.zshrc`):
```
export POSSIBLE_ENV_NAMES=( "test" )
```

## Installation

Using antigen, add this to your `.antigenrc` (or your `.zshrc`) file:

```
antigen bundle JavierLuna/zsh-cdenv
```

