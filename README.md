# ZSH cdenv
A ZSH plugin which acts as glue between git and virtualenv in my python workflow

## What does it do?

Whenever you cd in a git repository, it will check if there's a virtual environment in the root of that repository. If it does exist, activate it.

In addition, If you leave the repository, the environment will be deactivated.

Current supported environment names:

* `env`
* `ENV`
* `venv`
* `VENV`

## Installation

Using antigen, add this to your `.antigenrc` (or your `.zshrc`) file:

```
antigen bundle JavierLuna/zsh-cdenv
```

## Current limitations

There are a few limitations which are known and will be addresed as soon as I can:

* If you are in a repository A and you `cd` into a different repository B, the plugin will not recognize you've changed repos and will still use A's virtual env
* Environment names are static. It would be nice for it to be customizable.
* Virtualenv-wrapper and pipenv not supported.
