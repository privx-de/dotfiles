SOURCE = $(shell pwd)

symlinks:
	ln -sf "$(SOURCE)/nvim" "$(HOME)/.config/nvim"

vim_plug_update:
	vim -c 'PlugUpdate | q | q'
