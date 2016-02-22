#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude ".gdbinit" --exclude ".gitattributes" --exclude ".gitconfig" \
		--exclude ".gitignore" --exclude ".gvimrc" --exclude ".hgignore" \
		--exclude ".hushlogin" --exclude ".vimrc" --exclude ".vim" \
		--exclude "bin" --exclude "init" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" -avh --no-perms . ~;
	if [ -d "custom" ]; then
		rsync --exclude "notes.txt" -avh --no-perms ./custom/ ~;
	fi
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
