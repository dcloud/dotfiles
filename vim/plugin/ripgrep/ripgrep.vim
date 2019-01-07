" Use Ripgrep for search, if available
" fzf.vim adds an :Rg command, fwiw

if exists('g:loaded_ripgrep')
    finish
endif
let g:loaded_ripgrep = 1

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

