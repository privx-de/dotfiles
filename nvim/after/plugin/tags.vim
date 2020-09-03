"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Gutentags
"""

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

command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

"""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Tagbar
"""

" Markdown
" @idea use markdown to ctags
" https://github.com/jszakmeister/markdown2ctags
let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
  \   'h:Heading_L1',
  \   'i:Heading_L2',
  \   'k:Heading_L3'
  \ ]
  \ }

" Terraform
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

" YAML
" @todo YAML for ansible and helm
"let g:tagbar_type_yaml = {
"  \ 'ctagstype' : 'yaml',
"  \ 'kinds' : [
"  \   'a:anchors',
"  \   's:section',
"  \   'e:entry'
"  \ ],
"  \ 'sro' : '.',
"  \ 'scope2kind': {
"  \   'section': 's',
"  \   'entry': 'e'
"  \ },
"  \ 'kind2scope': {
"  \   's': 'section',
"  \   'e': 'entry'
"  \ },
"  \ 'sort' : 0
"  \ }

" Tagbar toggle
nmap tt :TagbarToggle<CR>
