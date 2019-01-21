" ALE config

let g:ale_sign_error = '🔥'
let g:ale_javascript_eslint_suppress_missing_config = 10
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'markdown': [],
\   'python': ['flake8'],
\}

" ALE fix-on-save
let g:ale_fix_on_save = 1

" ALE completion
let g:ale_completion_enabled = 1


