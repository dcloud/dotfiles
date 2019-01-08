" TODO List Plugin
" Uses Ripgrep to search for TODOs, FIXMEs, etc. and loads them into a
" quickfix list.
" TODO: Add support for vanilla grep, :grep, and maybe other search tools

if exists('g:loaded_todo')
    finish
endif

let g:loaded_todo = 1

" Check for rg executable on the system
if executable("rg")
    let g:todo_command="rg --vimgrep --pcre2"
else
    finish
endif

" Stole TODO regex from atom plugin
" This syntax is not compatible with macOS grep
let todo_regex = '(?<!\\w)@?(TODO|FIXME|CHANGED|XXX|IDEA|HACK|NOTE|REVIEW|NB|BUG|QUESTION|COMBAK|TEMP|DEBUG|OPTIMIZE|WARNING)\b'

function! TODOList()
    " Define command to be called
    let todo_cmd = g:todo_command . " '". g:todo_regex . "'"
    " Make a system call and parse results into a list
    let todolist = systemlist(todo_cmd)

    " Set a title for the quickfix list we will create
    let t = 'TODO List'
    " Create a new quickfix list and populate
    " with the lines of output from Ripgrep
    call setqflist([], ' ', { 'title': t, 'lines': todolist })
    " copen the quickfix list right away, 20 lines tall
    copen 20
endfunction

command! -nargs=0 TODOList :call TODOList()
