" Python filetype plugin

" Enable ALE fixers

let b:ale_linters = ['flake8']
let b:ale_fixers = ['black']


iab ifmain if __name__ == '__main__':<CR>main()
