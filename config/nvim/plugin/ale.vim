" ALE config
" For fixing mainly, linting alternatively

let g:ale_sign_error = '🔥'
" Turn off virtualtext: messes up rendering sometimes
let g:ale_virtualtext_cursor=0
let g:ale_javascript_eslint_suppress_missing_config = 10

" Linter defaults
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'markdown': ['vale'],
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

autocmd UIEnter * ++once call EchoALEFixOnSaveStatus()
