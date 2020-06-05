
let s:mode=0

function! NumbersToggle()
    if (s:mode == 0)
        set relativenumber
        augroup numbertoggle
            autocmd!
            autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
            autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
        augroup END
        let s:mode=1
    else
        set norelativenumber
        augroup disable
            au!
            au! numbertoggle
        augroup END
        let s:mode=0
    endif
endfunction

command! -nargs=0 NumbersToggle call NumbersToggle()

nnoremap <leader><space> :NumbersToggle<CR>
