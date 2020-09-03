SOURCE = $(shell pwd)

symlinks:
	ln -sf "$(SOURCE)/nvim" "$(HOME)/.config/nvim"
	ln -sf "$(SOURCE)/ctags" "$(HOME)/.ctags"

vim_plug_update:
	vim -c 'PlugUpdate | q | q'
