# In Construction - Don't try it yet.

# My base configuration

This is used in a Fedora 25 workstation and it should work for any linux
distribution.

## Requirements

* Git
* Bash
* Python
* Python virtualenv and virtualenvwrapper installed locally

## Installing virtualenv and virtualenvwrapper locally

Make sure you have pip in your system and run the following:

```Bash
$ cd ~
$ pip install --user -U virtualenv virtualenvwrapper
```
This should put the virtualenv script at ```$HOME/.local/bin```.

## Bootstrapper

This is based on [gf3/dotfiles v1.0.0](https://github.com/gf3/dotfiles/tree/v1.0.0).

```Bash
$ bash < <( curl https://raw.githubusercontent.com/tvieira/dotfiles/master/bootstrap.sh )
```
