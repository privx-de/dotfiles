"
" vim/after/plugin/coc.vim
" https://github.com/neoclide/coc.nvim/blob/master/README.md
"

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
"
" set updatetime=100
"
" Already set. See .vimrc

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Global Extensions
let g:coc_global_extensions = [
  \   'coc-emoji',
  \   'coc-css',
  \   'coc-json',
  \   'coc-tslint',
  \   'coc-tslint-plugin',
  \   'coc-tsserver',
  \   'coc-yaml'
  \ ]
