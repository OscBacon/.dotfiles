# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

for f in .vimrc .zshrc .p10k.sh .tmux.conf .gitconfig; do
    mv ~/$f ~/$f.bak
	ln -s ~/.dotfiles/$f ~/$f
done

mkdir -p ~/.config/nvim

mv nvim/config/* ~/.config/nvim/config/

ln -s "~/.dotfiles/coc-settings.json" "~/.config/nvim/coc-settings.json"
ln -s "~/.dotfiles/init.vim" "~/.config/nvim/init.vim"

# Oh-my-ZSH & plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Vim plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
