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

function! ToggleFixOnSave()
    if (g:ale_fix_on_save == 1)
        let g:ale_fix_on_save=0
    else
        let g:ale_fix_on_save=1
    endif
endfunction

command! -nargs=0 ToggleFixOnSave call ToggleFixOnSave()

nnoremap fs :ToggleFixOnSave<CR>
nnoremap ff :ALEFix<CR>

" ALE completion
let g:ale_completion_enabled = 1


