filetype plugin indent on

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
set foldlevel=0
set foldlevelstart=0
set foldmethod=marker
set foldmarker={{{,}}}
set sessionoptions="curdir,folds,tabpages,options"


func! LoadPhp()
    source /home/tina/.vim/php/plugin/phpfolding.vim 
    source /home/tina/.vim/php/plugin/php-doc.vim
    source /home/tina/.vim/php/indent/php.vim 

    set foldlevel=1
    set foldlevelstart=1
    set keywordprg=:help
    set comments=s1:/*,mb:*,ex:*/,://,:#
    set makeprg=/usr/bin/php\ -e\ %

    let g:php_sql_query = 1                                                                                        
    let g:php_htmlInStrings = 1

    inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i 
    nnoremap <C-D> :call PhpDocSingle()<CR> 
    vnoremap <C-D> :call PhpDocRange()<CR> 

    inoremap <C-L> <ESC>:call RunPhp()<CR>i 
    nnoremap <C-L> :call RunPhp()<CR> 
    vnoremap <C-L> :call RunPhp()<CR> 

    inoremap <C-T> <ESC>:call RunPhpUnit()<CR>i
    nnoremap <C-T> :call RunPhpUnit()<CR>
    vnoremap <C-T> :call RunPhpUnit()<CR>
endf

func! GoThere()
endf

func! RunPhp()
    w
    make
endf

func! RunPhpUnit()
    if strridx(@%, "Test.") != -1
        tabd w
        tabnext
        !phpunit % 
    el
        call RunPhp()
    endif
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

func! OpenFold()
    if foldclosed(line('.')) != -1
        normal zo
    endif
endf

func! MyTabComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<tab>"
    else
        return "\<C-N>"
    endif
endf

if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    let g:auto_is_off = 0
    let g:sessions_project_path = "/home/tina/Projects"

    nnoremap P <ESC>P'[v']=
    nnoremap p <ESC>p'[v']=
    nnoremap G G :call OpenFold()<CR>

    inoremap <TAB> <C-R>=MyTabComplete()<CR>

    inoremap <C-N> <ESC>gt 
    nnoremap <C-N> gt
    vnoremap <C-N> <ESC>gt 

    noremap ;; :%s:::g<Left><Left><Left>
    noremap ;' :%s:::cg<Left><Left><Left><Left>
    cmap ;\ \(\)<Left><Left>

    command Noai call ToggleAuto()

    au FileType php call LoadPhp()

    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    au BufNew,BufReadPre * filetype detect 
endif

" ctrl D    - insert php doc for current class, method, function, etc
" ctrl N    - next tab 
" ctrl T    - phpunit test 
" ctrl L    - php lint 
" F5        - check syntax
" :php      - compile current file 
" :noai     - toggle auto indent
" :noh      - turn off search highlight
" <Tab>     - in insert mode to complete the current word
