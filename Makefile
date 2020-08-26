SOURCE = $(shell pwd)

symlinks:
	ln -sf "$(SOURCE)/vim" "$(HOME)/.vim"
	ln -sf "$(SOURCE)/vimrc" "$(HOME)/.vimrc"

vim_install_plug:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim_plug_update:
	vim -c 'PlugUpdate | q | q'
