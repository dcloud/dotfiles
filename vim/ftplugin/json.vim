" JSON

autocmd BufReadPre *.json if getfsize(expand("%")) > 100000 | syntax sync clear | endif

" Fold based on syntax, but keep first 2 levels open
setlocal foldmethod=syntax foldlevel=2

let b:ale_fixers = ['prettier', 'jq']
