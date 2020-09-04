"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Todo
"""

" Todo labels
" TODO: Remove historically grown lowercase tags
let g:spacevim_todo_labels = [
  \ 'FIXME', 'fixme',
  \ 'IDEA', 'idea',
  \ 'QUESTION', 'question',
  \ 'TODO', 'todo'
  \ ]

" Todo timestamp string
let g:todo_timestamp_string = strftime("%Y-%m-%d %H:%M") . ' - Marius Preyers'

" Todo comment signs
let g:todo_comment_signs    = '#'
autocmd FileType terraform let g:todo_comment_signs = '//'
