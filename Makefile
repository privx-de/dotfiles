SOURCE = $(shell pwd)

symlinks:
	ln -sf "$(SOURCE)/vim" "$(HOME)/.vim"
	ln -sf "$(SOURCE)/vimrc" "$(HOME)/.vimrc"
