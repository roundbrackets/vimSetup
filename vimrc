filetype plugin on

set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=85
set autoindent
set cindent
set history=2000
set ruler
set number
set formatoptions=cro
set hlsearch
set ruler
set undolevels=5000 
set autowrite

nnoremap P <ESC>P P'[v']=
nnoremap p <ESC>p p'[v']=

inoremap <TAB> <C-R>=MyTabComplete()<CR>

command Noai call ToggleAuto()

if !exists("LoadPhp_loaded")
    let LoadPhp_loaded = 1
    func! LoadPhp()
        set omnifunc=phpcomplete#CompletePHP

        let g:php_sql_query=1                                                                                        
        let g:php_htmlInStrings=1

        inoremap <C-C> <ESC>:call PhpDocSingle()<CR>i 
        nnoremap <C-C> :call PhpDocSingle()<CR> 
        vnoremap <C-C> :call PhpDocRange()<CR> 

        set keywordprg=:help
        set comments=s1:/*,mb:*,ex:*/,://,:#
        set makeprg=/usr/bin/php\ -e\ %
        command Php call RunPhp()
    endf
endif

if !exists("RunPhp_loaded")
    let RunPhp_loaded = 1
    func! RunPhp()
        w
        make
    endf
endif

if !exists("ToggleAuto_loaded")
    let ToggleAuto_loaded = 1
    func! ToggleAuto()
        if g:auto_is_off == 0
            let g:auto_is_off = 1
            set noai nocindent
            set formatoptions=
            echo "Auto indent is off."
        el
            let g:auto_is_off = 0
            set formatoptions=croa
            set ai cindent
            echo "Auto indent is on."
        endif
    endf
endif

if !exists("MyTabComplete_loaded")
    let MyTabComplete_loaded = 1
    func! MyTabComplete()
        let col = col('.')-1
        if !col || getline('.')[col-1] !~ '\k'
            return "\<tab>"
        else
            return "\<C-N>"
        endif
    endf
endif

if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    let g:auto_is_off = 0
    au FileType php call LoadPhp()
endif

" ctrl C    - insert php doc for current class, method, function, etc
" F5        - check syntax
" :php      - compile current file 
" :noai     - toggle auto indent
" :noh      - turn off search highlight
" <Tab>     - in insert mode to complete the current word
