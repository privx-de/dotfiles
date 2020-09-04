"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Cheat Sheet
"""

" Variables
let g:nvim_doc_dir = g:nvim_config_dir . '/doc'

" Edit Cheat Sheet
command! CheatSheetEdit execute 'e' g:nvim_doc_dir . '/cheatsheet.txt'

" Generate helptags
command! CheatSheetTags execute 'helptags' g:nvim_doc_dir

" Generate helptags on document save
autocmd BufWritePost */nvim/doc/*.txt CheatSheetTags
