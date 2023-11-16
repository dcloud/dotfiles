" Lsp

" Javascript/Typescript language server
" call LspAddServer([#{
" 	\    name: 'typescriptlang',
" 	\    filetype: ['javascript', 'typescript'],
" 	\    path: '/usr/local/bin/typescript-language-server',
" 	\    args: ['--stdio'],
" 	\  }])

" Go language server
let gopath = $HOME.'/.go/bin/gopls'
if filereadable(gopath)
    call LspAddServer([#{
        \    name: 'golang',
        \    filetype: ['go', 'gomod'],
        \    path: gopath,
        \    args: ['serve'],
        \    syncInit: v:true
        \  }])
endif

" Rust language server
let rustpath = $ASDF_DATA_DIR.'/shims/rust-analyzer'
if filereadable(rustpath)
    call LspAddServer([#{
        \    name: 'rustlang',
        \    filetype: ['rust'],
        \    path: rustpath,
        \    args: [],
        \    syncInit: v:true
        \  }])
endif


" optsions
call LspOptionsSet(#{
	\   aleSupport: v:true,
	\ })
