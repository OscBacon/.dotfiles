for rc in vimrc zshrc; do
	cp "~/.${rc}" "~/.${rc}_back"
	rm "~/.${rc}"
	ln -s "~/.dotfiles/_${rc}" "~/.${rc}"
	ln -s "~/.dotfiles/init.vim" "~/.config/nvim/init.vim"
  mv nvim/config* ~/.config/nvim/config/
done

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
