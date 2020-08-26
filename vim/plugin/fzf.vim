"
" vim/after/plugin/fzf.vim
"
let g:fzf_layout = {
  \   'window': {
  \     'width': 0.9,
  \     'height': 0.7,
  \     'border': 'sharp'
  \   }
  \ }

" Buffers command
nnoremap <silent> <Leader>b :Buffers<CR>

" Files command
nnoremap <silent> <Leader>z :Files<CR>

" Most Recently Used Files
nnoremap <silent> <Leader>m :FZFMru<CR>
