" Install vim-plug
if empty(glob(stdpath('data') .  '/site/autoload//plug.vim'))
  execute '!curl -fLo' stdpath('data') .  '/site/autoload//plug.vim --create-dirs'
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')


" Initialize plugin system
call plug#end()
