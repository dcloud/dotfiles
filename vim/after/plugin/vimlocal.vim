" Project/dir config files
" Loading .vimlocal after enables overrides, but
" 'silent! so .vimlocal' isn't safe.
" Message the user that a .vimlocal was detected

" Figure out how to detect if file was loaded, and don't show message
if filereadable('.vimlocal') && has('dialog_con')
    let choice = confirm(".vimlocal detected. Load settings?", "&Yes\n&No", 2)
    if choice == 1
        silent! so .vimlocal
    endif
endif
