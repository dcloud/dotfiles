" Markdown files

setlocal spell
setlocal linebreak
setlocal breakindent
setlocal breakindentopt=column:2,sbr
setlocal showbreak=↪

" vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0

" Use pandoc to convert markdown to Jira Wiki format
nnoremap <Leader>j :%!pandoc -f markdown -t jira -<CR>
