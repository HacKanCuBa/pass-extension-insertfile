# pass insertfile 

A [pass](https://www.passwordstore.org/) extension that provides a convenient solution to insert a file into the store.

If you are using [passh](https://github.com/HacKanCuBa/passh) - the pass fork -, then you might prefer using [passh insert](https://github.com/HacKanCuBa/passh-extension-insert) extension.

## Usage

```
Usage:
    pass insertfile [--help,-h] [--force,-f] pass-name file-path
            Insert a file into the store. Prompt before
            overwriting existing file unless forced (--force,-f).

More information may be found in the pass-insertfile(1) man page.
```

See `man pass-insertfile` for more information.

## Example

Insert your ssh private key.

    pass insertfile Systems/General/SSHKey ~/.ssh/id_rsa

## Installation

### Linux

    git clone https://github.com/HacKanCuBa/pass-extension-insertfile.git
    cd pass-insertfile
    sudo make install

Or simply copy *insertfile.bash* to the pass extension directory (~/.password-store/.extensions by default) and set it executable to enable it: `chmod +x insertfile.bash`..

#### Requirements

In order to use extension with `pass`, you need:
* `pass 1.7.0` or greater. As of today this version has not been released yet.
Therefore you need to install it by hand from zx2c4.com:

		git clone https://git.zx2c4.com/password-store
		cd password-store
		sudo make install

* You need to enable the extensions in pass: `PASSWORD_STORE_ENABLE_EXTENSIONS=true pass`.
You can create an alias in `.bashrc`: `alias pass='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'`

## Contribution
Feedback, contributors, pull requests are all very welcome.

## License

    Copyright (C) 2017 HacKan (https://hackan.net)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

