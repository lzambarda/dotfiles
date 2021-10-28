# lzambarda does dotfiles

Your dotfiles are how you personalize your system. These are mine.

## topical

Everything's built around topic areas. If you're adding a new area to your forked dotfiles — say, "Java" — you can simply add a `java` directory and put files in there.
Anything with an extension of `.zsh` will get automatically included into your shell.

You can also include a `.stow-local-ignore` file in a topical directory to include it in stow at installation time.

## install

```sh
git clone https://github.com/lzambarda/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

This will install and use [stow](https://www.gnu.org/software/stow/manual/stow.html) to create symlinks.

## Credits

I forked [Holman](https://github.com/holman)'s great [dotfiles](https://github.com/holman/dotfiles) and stripped it down as needed.
