

set background=dark
" colorscheme starkiller

set number                 " Show line numbers
set ignorecase             " Case insensitive search by default, but see smartcase
set smartcase              " Make mixed case patterns case sensitive
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:⇨ ,trail:□,extends:❯,precedes:❮,nbsp:±,eol:↵'
else
  let &listchars = 'tab:> ,trail:-,extends:>,precedes:<,nbsp:.,eol:↵'
endif


" Add fzf to runtimepath
set runtimepath+=/usr/local/opt/fzf

" git gutter
if exists('&signcolumn')
    set signcolumn=yes
endif

" Use cursorline, toggle on/off
set cursorline             " Find the current line quickly.
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" Load lua lsp stuff
lua require('init')

" treesitter folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
