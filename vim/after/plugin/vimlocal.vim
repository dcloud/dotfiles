" Project/dir config files
" Loading .vimlocal after enables overrides, but
" 'silent! so .vimlocal' isn't safe.
" Message the user that a .vimlocal was detected

silent! so .vimlocal

" Figure out how to detect if file was loaded, and don't show message
if filereadable('.vimlocal')
    echom ".vimlocal detected. You may wish to run 'vim -S .vimlocal' to source local configuration."
endif
