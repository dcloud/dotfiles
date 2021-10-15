" SQL settings

let b:ale_fixers = ['pgformatter']

" Turn off completions since we don't have dbext vim plugin
" :help sql-completion-customization
let b:omni_sql_no_default_maps = 1
