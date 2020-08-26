"
" vim/after/plugin/lightline.vim
"
let g:lightline = { 'colorscheme': 'molokai' }
let g:lightline.active = {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['readonly', 'filename', 'modified']
  \   ],
  \   'right': [
  \     ['lineinfo'],
  \     ['percent'],
  \     ['fileformat', 'fileencoding', 'filetype'],
  \     [ 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status' ]
  \   ]
  \ }

" register coc compoments:
call lightline#coc#register()
