for rc in vimrc zshrc; do
	cp ~/\.$rc ~/\.${rc}_back
	rm ~/\.$rc
	ln -s ~/\.dotfiles/_$rc ~/\.$rc
	ln -s ~/\.dotfiles/init.vim .config/nvim/init.vim
done
