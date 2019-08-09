# Dotfiles

## What?
* Small shell enhancements to make your terminal attractive!
* Works with ```zsh, bash```.

## Install
```
$ chmod +x install.sh && ./install.sh # Run as sudo
```

## Catches
* Dependency installation handled only for Debian and its downstream distros. Install missing packages if you run a different OS.
* The dotconfigs also have 3rd party tools buillt-in like [Bit.ly]() and [Pushbullet](). If you'd like to use them, you also need to configure access keys with names ```ACCESS_TOKEN``` and ```PUSH_BULLET_ACCESS_TOKEN``` in your ```.bashrc``` or ```.zshrc``` file, in accordance with whatever shell you use.

## To-do

1. Re-factor `install.sh` (OR) remove it altogether to use this with GNU Stow
2. Easy way to upgrade the dotfiles installation
3. Configure profiles like `git` while installation

## Missing Dependencies

1. `bat` CLI
2. Perf related stuff - `nmon`, `glances`, `screenfetch`, ~~`htop`~~ etc

## License
[GNU GPL v3](http://choosealicense.com/licenses/gpl-3.0/)

----

Show your shell some :heart:

