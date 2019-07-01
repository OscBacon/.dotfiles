for rc in vimrc zshrc; do
	cp ~/\.$rc ~/\.${rc}_back
	rm ~/\.$rc
	ln -s ~/\.dotfiles/_$rc ~/\.$rc
done
