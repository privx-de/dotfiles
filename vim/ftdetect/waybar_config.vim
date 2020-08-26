"
" vim/after/ftdetect/waybar_config.vim
"
autocmd BufRead,BufNewFile */.config/waybar/config,*/config/waybar/config
  \ set ft=json
