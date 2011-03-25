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

cnoremap noai <CR>:call ToggleAuto()<CR>

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
    set makeprg=/usr/bin/php\ -e\ %
    cnoremap php <ESC>:w<CR>:make<CR>
endf

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

if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    let g:auto_is_off = 0
    au FileType php call LoadPhp()
endif

" ctrl P    - autocomplete
" ctrl C    - insert php doc for current class, method, function, etc
" F5        - check syntax
" :php      - do compile current file 
" :noai     - toggle auto indent
