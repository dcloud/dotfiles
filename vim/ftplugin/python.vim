" Python filetype plugin

" Enable ALE fixers

let b:ale_linters = ['ruff']
let b:ale_fixers = ['ruff']


iab ifmain if __name__ == '__main__':<CR>main()
