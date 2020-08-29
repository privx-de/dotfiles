"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Install vim-plug
"""

let plug_autoload_path = '/site/autoload/plug.vim'
if empty(glob(stdpath('data') .  plug_autoload_path))
  execute '!curl -fLo' stdpath('data') . plug_autoload_path '--create-dirs'
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Start vim-plug
"""

" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Onehalf colorscheme
"""

Plug 'sonph/onehalf', {'rtp': 'vim/'}

" Enable 256 colors
set t_Co=256

" Enable truecolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Airline
"""

Plug 'vim-airline/vim-airline'

let g:airline_theme='onehalfdark' " Airline colorscheme
let g:airline_powerline_fonts = 1 " Use Powerlinefonts

let g:airline#extensions#tabline#enabled = 1        " Enable tabline
let g:airline#extensions#tabline#buffer_nr_show = 1 " Show buffer number

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" FZF
"""

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NCM2
"""

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

autocmd BufEnter * call ncm2#enable_for_buffer() " Enable ncm2 for all buffers

set completeopt=noinsert,menuone,noselect " Ncm2PopupOpen for more information
set shortmess+=c                          " Suppress 'match x of y' messages

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NCM2 Sources
"""

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" End vim-plug

" Initialize vim-plug
call plug#end()

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Settings
"""

" Set colorscheme
colorscheme onehalfdark

set cursorline " Enable cursorline
set noshowmode " Hide vim mode

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Shortcuts
"""

" FZF project file search
nnoremap <C-p> :Files<Cr>
