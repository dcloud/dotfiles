" GoYo customizations

function! s:goyo_enter()
    set linebreak
    if exists('#gitgutter')
        silent! GitGutterDisable
    endif
    if exists('#airline')
        AirlineToggle
    endif
endfunction

function! s:goyo_leave()
    set nolinebreak
    if exists('#gitgutter')
        silent! GitGutterEnable
    endif
    if exists('#airline')
        AirlineToggle
        silent! AirlineRefresh
        silent! AirlineRefresh
    endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

