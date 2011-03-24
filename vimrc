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

cnoremap noai <CR>:call ToggleAuto()

func! LoadPhp()
    set omnifunc=phpcomplete#CompletePHP

    let g:php_sql_query=1                                                                                        
    let g:php_htmlInStrings=1

    source ~/.vim/plugin/php-doc.vim

    inoremap <C-C> <ESC>:call PhpDocSingle()<CR>i 
    nnoremap <C-C> :call PhpDocSingle()<CR> 
    vnoremap <C-C> :call PhpDocRange()<CR> 

    set keywordprg=:help
    set comments=s1:/*,mb:*,ex:*/,://,:#
endf

func! ToggleAuto()
    if !exists("g:auto_is_off") || g:auto_is_off == 0
        let auto_is_off = 1
        set noai nocindent
        set formatoptions=
    el
        let g:auto_is_off = 0
        set formatoptions=croa
        set ai cindent
    endif
endf

if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    au FileType php call LoadPhp()
endif

" ctrl C    - insert php doc for current class, method, function, etc
" F5        - check syntax
