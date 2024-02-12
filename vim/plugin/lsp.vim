" Lsp

let lspOpts = #{aleSupport: v:true}
autocmd VimEnter * call LspOptionsSet(lspOpts)

let lspServers = []

" Go language server
let gopath = $HOME.'/.go/bin/gopls'
if filereadable(gopath)
    add(lspServers, #{
        \    name: 'golang',
        \    filetype: ['go', 'gomod'],
        \    path: gopath,
        \    args: ['serve'],
        \    syncInit: v:true
        \ })
endif

" Rust language server
let rustpath = $ASDF_DATA_DIR.'/shims/rust-analyzer'
if filereadable(rustpath)
    add(lspServers, #{
        \    name: 'rustlang',
        \    filetype: ['rust'],
        \    path: rustpath,
        \    args: [],
        \    syncInit: v:true
        \  })
endif
autocmd VimEnter * call LspAddServer(lspServers)
