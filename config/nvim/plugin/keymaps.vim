" Keymaps

" set <leader>
let mapleader = ' '

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" https://github.com/mhinz/vim-galore#quickly-add-empty-lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>']

" Keymappings for :term
tnoremap <silent> <C-h> <C-W>h
tnoremap <silent> <C-j> <C-W>j
tnoremap <silent> <C-k> <C-W>k
tnoremap <silent> <C-l> <C-W>l
tnoremap <leader><Esc> <C-w>N


" List buffers and switch to a buffer
nnoremap <F5> :buffers<CR>:buffer<Space>

" Mappings for increment and decrement
nnoremap <leader>i <C-A>
nnoremap <leader>d <C-X>

" Mapping for adding semicolon to end of line
nnoremap <leader>; ms:norm A;<CR>`s

" Shortcuts for de-educating quotation marks
" char 2018: ‘
" char 2019: ’
" char 201A: ‚
" char 201B: ‛
" char 201C: “
" char 201D: ”
" char 201E: „
" char 201F: ‟
nnoremap <leader>' :.s/\(\%u2018\\|\%u2019\)/'/g<CR>
nnoremap <leader>" :.s/\(\%u201C\\|\%u201D\)/"/g<CR>

