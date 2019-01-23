" Configure vim-workspace

let g:workspace_session_directory = $HOME . '/.vim/files/sessions/'
let g:workspace_undodir = $HOME . '/.vim/files/undo'

" Don't autosave files in workspaces
let g:workspace_autosave = 0

" Only load workspace when we don't call vim with a filename arg
let g:workspace_session_disable_on_args = 1

" Ignore gitcommit buffers
let g:workspace_autosave_ignore = ['gitcommit']

" We have other things that "untrailspaces"
let g:workspace_autosave_untrailspaces = 0

" Map to toggleworkspace
nnoremap <leader>s :ToggleWorkspace<CR>
