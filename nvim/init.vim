set nocompatible
set hidden

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

" Disable line numbers in fzf
autocmd! FileType fzf setlocal nonumber norelativenumber
  \ | call rainbow#inactivate()

" Shortcuts
nnoremap <C-b> :Buffers<Cr>
nnoremap <C-p> :Files<Cr>

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" FZF most recently used files
"""

Plug 'pbogut/fzf-mru.vim'

let g:fzf_mru_relative = 1 " Only relative files

""" MyRmu with bat preview
let g:my_mru_preview = '--preview="' . stdpath('data')
  \ . '/plugged/fzf.vim/bin/preview.sh {}"'
command! MyMru execute 'FZFMru' . g:my_mru_preview

" Shortcut
nnoremap <C-m> :MyMru<Cr>

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Yoink
"""

Plug 'svermeulen/vim-yoink'

let g:yoinkSavePersistently = 1 " Save yank history

" FZF for Yanks
function! GetYanks()
  redir => cout
  silent Yanks
  redir END
  return split(cout, "\n")[1:]
endfunction

function! UseYanks(line)
  call yoink#rotateThenPrint(a:line[0])
endfunction

command! MyYanks call fzf#run(fzf#wrap({
  \ 'source': GetYanks(),
  \ 'sink': function('UseYanks')}))
nnoremap <C-y> :MyYanks<Cr>

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" GIT Plugins
"""

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

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

Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-vim'

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" ncm2 Snippet Support
"""

Plug 'SirVer/ultisnips'
Plug 'ncm2/ncm2-ultisnips'

" Enter key trigger snippet expansion
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" ExpandTrigger default conflicts with pum movement
let g:UltiSnipsExpandTrigger = '\<Plug>(placeholder)'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" LanguageClient-neovim
"""

Plug 'autozimu/LanguageClient-neovim', {
  \   'branch': 'next',
  \   'do': 'bash install.sh',
  \ }

let g:LanguageClient_autoStart = 1          " Enable autostart
" let g:LanguageClient_completionPreferTextEdit = 1
let g:LanguageClient_diagnosticsEnable = 0  " Disable diagnostic
let g:LanguageClient_hasSnippetSupport = 1  " Enable snippet support

" Project root makers
let g:LanguageClient_rootMarkers = {
  \   'terraform': ['.terraform', '.terraform.d']
  \ }

" Language server commands
let g:LanguageClient_serverCommands = {
  \   'terraform': ['terraform-lsp'],
  \   'yaml': ['yaml-language-server', '--stdio'],
  \   'yaml.ansible': ['yaml-language-server', '--stdio'],
  \ }

" Set yaml schema
function! YamlSetSchema()
  if &ft =~# '^yaml'
    let config = json_decode(system("cat ~/.config/nvim/yaml/default.json"))
    call LanguageClient#Notify('workspace/didChangeConfiguration', { 'settings': config })
  endif
endfunction

" Trigger yaml schema
augroup LanguageClient_config
  autocmd!
  autocmd User LanguageClientStarted call YamlSetSchema()
augroup END

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Ansible
"""

Plug 'pearofducks/ansible-vim'

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Terraform
"""

Plug 'hashivim/vim-terraform'

let g:terraform_align=1 " Align settings automatically

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Better Whitespace
"""

Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1 " Enable better whitespace by default
let g:strip_only_modified_lines=1 " Strip only modified lines
let g:strip_whitespace_confirm=0  " Do not confirm
let g:strip_whitespace_on_save=1  " Strip Whitespace on save

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Rainbow Parentheses
"""

Plug 'frazrepo/vim-rainbow'

" let g:rainbow_active = 1 " Enable rainbow parentheses

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
set cmdheight=2
set signcolumn=yes
" Spaces and tabs
set expandtab     " Tabs are spaces
set tabstop=2     " Number of visual spaces per tab
set softtabstop=2 " Number of spaces in tab when editing
set shiftwidth=2  " Number of spaces to use autoindent

" Tempfiles
set nobackup   " No backup file
set noswapfile " No swap file

set cursorline            " Enable cursorline
set noshowmode            " Hide vim mode
set nowrap                " Don't wrap lines
set number                " Enable line numbers
set relativenumber
set wildmenu              " Enable command completion
set wildmode=longest:full " Tab to longest match

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Shortcuts
"""

" Clear search
noremap <silent> <c-_> :let @/ = ""<CR>

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""
