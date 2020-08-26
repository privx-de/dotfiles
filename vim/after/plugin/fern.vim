" WIP
"
" after/plugin/fern.vim
"
let g:fern#disable_default_mappings   = 1
let g:fern#disable_drawer_auto_quit   = 1
let g:fern#disable_viewer_hide_cursor = 0

let g:fern#mark_symbol                       = '●'
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '

"
" Add FernSmartSeady function to support await like mapping call
"   https://github.com/lambdalisue/fern.vim/pull/108
"

" Let async promise
let s:Promise = vital#fern#import('Async.Promise')

" Hook promise
function! FernHookPromise(name) abort
  return s:Promise.new(
    \   { r -> fern#hook#add(a:name, r, { 'once': v:true }) }
    \ )
endfunction

" Warn on expr mapping
function! s:warn_on_expr_mapping(message) abort
  return printf("\<Esc>:echoerr '[fern] %s'\<CR>", escape(a:message, "'"))
endfunction

" FernSmartReady function to solve async mapping issues
function! FernSmartReady(expr, ...) abort
  let options = extend(
    \   {
    \     'timeout': 500,
    \   },
    \   a:0 ? a:1 : {},
    \ )
  call s:Promise.race(
    \   [
    \     FernHookPromise('read'),
    \     fern#util#sleep(options.timeout)
    \   ]
    \ )
    \.then({ -> execute(printf('normal %s', a:expr)) })
  return s:warn_on_expr_mapping(
    \   'FernSmartReady() cannot used in <expr> mapping',
    \ )
endfunction

function! FernInit() abort
  nnoremap <buffer><silent>
    \ <Plug>(fern-my-tcd:root-ready)
    \ :<C-u>call FernSmartReady("\<Plug>(fern-action-tcd:root)")<CR>

  nmap <buffer><expr>
    \ <Plug>(fern-my-open-expand-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-action-open:select)",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )

  " Perform tcd on the root node after enter or leave action
  "   https://github.com/lambdalisue/fern.vim/wiki/Tips
  nmap <buffer><Plug>(fern-my-enter-and-tcd)
    \ <Plug>(fern-action-enter)
    \ <Plug>(fern-wait)
    \ <Plug>(fern-action-tcd:root)

  nmap <buffer><Plug>(fern-my-leave-and-tcd)
    \ <Plug>(fern-action-leave)
    \ <Plug>(fern-wait)
    \ <Plug>(fern-action-tcd:root)

  nmap <buffer><nowait> > <Plug>(fern-my-enter-and-tcd)
  nmap <buffer><nowait> < <Plug>(fern-my-leave-and-tcd)

  " Enter a project root via ^
  " nmap <buffer><nowait> ^ <Plug>(fern-action-project-top)

  " nmap <buffer>
  "      \ <Plug>(fern-my-fd)
  "      \ <Plug>(fern-action-fzf-dirs)<Plug>(fern-my-tcd:root-ready)
  "nmap <buffer><Plug>(fern-my-fd)
  "  \ <Plug>(fern-action-fzf-dirs)
  "  \ <Plug>(fern-wait)
  "  \ <Plug>(fern-action-tcd:root)
  nmap <buffer> fd '<Plug>(fern-action-fzf-dirs)call: "<Plug>(fern-action-tcd:root)"'

  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> ff <Plug>(fern-action-fzf-files)
  nmap <buffer> m <Plug>(fern-action-mark-toggle)j
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> R <Plug>(fern-action-move)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> <nowait> d <Plug>(fern-action-hidden-toggle)
endfunction

noremap <silent> <Leader>d :Fern . -drawer -width=35 -toggle<CR><C-w>=
noremap <silent> <Leader>f :Fern . -drawer -reveal=% -width=35<CR><C-w>=
noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR><C-w>=

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
