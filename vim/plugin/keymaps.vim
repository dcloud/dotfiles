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

" tagbar keymap
nmap <silent> <F8> :TagbarToggle<CR>

" Mappings to move around through errors
nmap <silent> <c-k> <plug>(ale_previous_wrap)
nmap <silent> <c-j> <plug>(ale_next_wrap)


" Mappings for increment and decrement
nnoremap <leader>i <C-a>
nnoremap <leader>d <C-x>

" Mapping for adding semicolon to end of line
nnoremap <leader>; ms:norm A;<CR>`s
