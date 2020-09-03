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
let g:airline#extensions#languageclient#enabled = 0 " Disable languageclient
" @fixme buffer numbers only for openfiles
let g:airline#extensions#tabline#buffer_nr_show = 1 " Show buffer number

let airline#extensions#coc#error_symbol = '🔥 '
let airline#extensions#coc#warning_symbol = '💀 '


set maxmempattern=2048

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Tags
"""
Plug 'ludovicchabant/vim-gutentags'

let g:gutentags_add_default_project_roots = 0 " Don't use default project roots
let g:gutentags_project_root = ['.git']
let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

" @todo migrate into .ctags
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

Plug  'majutsushi/tagbar'

let g:tagbar_type_terraform = {
  \ 'ctagstype' : 'terraform',
  \ 'kinds' : [
  \   'd:data sources',
  \   'm:modules',
  \   'o:outputs',
  \   'p:providers',
  \   'r:resources',
  \   't:tfvars',
  \   'v:variables'
  \ ],
  \ 'sort' : 0
  \ }

" Tagbar toggle
nmap tt :TagbarToggle<CR>


Plug 'wsdjeg/vim-todo'

let g:todo_string = strftime("%Y-%m-%d %H:%M") . ' - Marius Preyers:'
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
nnoremap <C-g> :Rg<CR>
nnoremap <C-p> :Files<Cr>

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" FZF most recently used files
"""

" WIP
" Plug 'pbogut/fzf-mru.vim'

" let g:fzf_mru_relative = 1 " Only relative files

""" MyRmu with bat preview
" let g:my_mru_preview = '--preview="' . stdpath('data')
"  \ . '/plugged/fzf.vim/bin/preview.sh {}"'
" command! MyMru execute 'FZFMru' . g:my_mru_preview

" Shortcut
" nnoremap <C-m> :MyMru<Cr>

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
" nnoremap <C-y> :MyYanks<Cr>

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" GIT Plugins
"""

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" ALE
"""

"Plug 'dense-analysis/ale'
"let g:ale_completion_enabled  = 0
"let g:ale_disable_lsp         = 1
"let g:ale_sign_column_always  = 1

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
let g:coc_global_extensions  = [
\   'coc-css',
\   'coc-diagnostic',
\   'coc-go',
\   'coc-highlight',
\   'coc-html',
\   'coc-json',
\   'coc-pairs',
\   'coc-python',
\   'coc-template',
\   'coc-sh',
\   'coc-snippets',
\   'coc-sql',
\   'coc-xml',
\   'coc-yaml',
\   'coc-yank',
\ ]
let g:coc_filetype_map = {
  \ 'ansible': 'yaml',
  \ 'helm': 'yaml',
  \ }
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Ansible
"""

"Plug 'pearofducks/ansible-vim'

"let g:ansible_unindent_after_newline = 1 " New line indentation reset

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Hashivim
"""

Plug 'hashivim/vim-packer'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-vagrant'

let g:terraform_align=1 " Align settings automatically

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Helm/Kubernetes
"""

Plug 'towolf/vim-helm'
autocmd BufRead,BufNewFile Chart.yaml,values.yaml set ft=helm

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
""" indentLine
"""
"Plug 'Yggdroot/indentLine'

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
" set wildmode=longest:full " Tab to longest match

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Shortcuts
"""

" Clear search
noremap <silent> <c-_> :let @/ = ""<CR>

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Customize colors

hi CocErrorSign guifg=#e06c75
"hi CocInfoSign guibg=#353b45
hi CocWarningSign guifg=#e5c07b
hi Pmenu guifg=#dcdfe4 guibg=#313640 gui=NONE
hi PmenuSel guifg=#313640 guibg=#61afef gui=NONE
hi PmenuSbar guibg=#474e5d
hi PmenuThumb guibg=#313640

set pumheight=16
