" ALE config

let g:ale_sign_error = '🔥'
let g:ale_javascript_eslint_suppress_missing_config = 10
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'markdown': [],
\   'python': ['flake8'],
\}

" ALE fix-on-save
let g:ale_fix_on_save = 0

function! EchoALEFixOnSaveStatus()
    echom 'ALE FixOnSave is:' g:ale_fix_on_save ? 'ON' : 'OFF'
endfunction

function! ToggleFixOnSave()
    if (g:ale_fix_on_save == 1)
        let g:ale_fix_on_save=0
    else
        let g:ale_fix_on_save=1
    endif
    call EchoALEFixOnSaveStatus()
endfunction

command! -nargs=0 ToggleFixOnSave call ToggleFixOnSave()
command! -nargs=0 ALEFixStatus call EchoALEFixOnSaveStatus()

nnoremap <F1> :ToggleFixOnSave<CR>
nnoremap <F3> :ALEFix<CR>

" ALE completion
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc


" Airline status
let g:airline#extensions#ale#enabled = 1
