

set background=dark

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

" Backup and undo options
set backup
set backupdir=~/.local/state/nvim/backup//
set undofile

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

" If Ripgrep is installed, use it as :grep program
if executable('rg') | set grepformat+=%f:%l:%c:%m grepprg=rg\ --vimgrep\ --no-heading\ --smart-case | endif

" Load lua lsp stuff
lua require('init')
