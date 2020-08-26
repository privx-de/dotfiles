"
" Vim-Plug --------------------------------------------------------------------
"

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Better Whitespace
"
"   This plugin causes all trailing whitespace characters to be highlighted.
"   https://github.com/ntpeters/vim-better-whitespace.git
"
Plug 'ntpeters/vim-better-whitespace'

"
" Coc.nvim - https://github.com/neoclide/coc.nvim
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"
" Fern - https://github.com/lambdalisue/fern.vim
"
Plug 'lambdalisue/fern.vim'

" fern-mapping-project-top
"
"   fern.vim plugin which add project-top mapping to enter a project top.
"   https://github.com/lambdalisue/fern-mapping-project-top.vim
"
" Plug 'lambdalisue/fern-mapping-project-top.vim'

Plug 'LumaKernel/fern-mapping-fzf.vim'

"
" FZF Vim - https://github.com/junegunn/fzf.vim
"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"
" FZF Most Recently Used Files - https://github.com/pbogut/fzf-mru.vim
"
Plug 'pbogut/fzf-mru.vim'

"
" Lightline - https://github.com/itchyny/lightline.vim
"
Plug 'itchyny/lightline.vim'

"
" Lightline-Coc - https://github.com/josa42/vim-lightline-coc
"
Plug 'josa42/vim-lightline-coc'

"
" Molokai Color Scheme - https://github.com/ueaner/molokai
"
Plug 'ueaner/molokai'

"
" Volyglot - https://github.com/sheerun/vim-polyglot
"
" Plug 'sheerun/vim-polyglot'

"
" Vim-Rainbow - https://github.com/frazrepo/vim-rainbow
"
Plug 'frazrepo/vim-rainbow'

" Initialize plugin system
call plug#end()

"
" Settings --------------------------------------------------------------------
"

set cmdheight=2                " Better display for messages
set colorcolumn=80             " Show vertical line at 80 chars
set fillchars=""               " Remove the ugly splits separator
set hlsearch                   " Highlight search terms
set incsearch                  " Show search matches as you type
set laststatus=2               " Always show statusline
set noswapfile                 " Turn off swap file
set nowrap                     " Don't wrap lines
set termguicolors              " True colors
set updatetime=100             " Smaller updatetime for CursorHold
set wildmode=longest,list,full " Better better autocomplete
set wildmenu                   " Autocomplete menu
" highlight VertSplit cterm=NONE

"
" Colorscheme -----------------------------------------------------------------
"

colorscheme molokai " Set color scheme
let &t_ut=''
