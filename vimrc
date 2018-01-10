" ===========================  Table of contents  ==========================
"   Select TOC_XX and press * to go to the corresponding section
func! FunctionForMultilineComment438971049723904()

TOC_01 Vundle stuff
TOC_02 Variables
TOC_03 Global settings
TOC_04 File-local settings
TOC_05 Plugin settings
TOC_06 Colors
TOC_07 Mappings
TOC_08 Compile/Run functions
TOC_09 Russian language
TOC_10 Git
TOC_11 Colemak
TOC_12 Miscellaneous

endf

" =============================  Vundle stuff  =======================TOC_01

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
" todo: oblitum/YouCompleteMe
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mbbill/undotree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'luochen1990/rainbow'
Plugin 'vim-airline/vim-airline'
Plugin 'ifsmirnov/vim-searchindex'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'metakirby5/codi.vim'
" Plugin 'lyokha/vim-xkbswitch'
" Plugin 'artur-shaik/vim-javacomplete2'

call vundle#end()
filetype plugin indent on


" ===============================  Variables  ========================TOC_02
let $IFSMIRNOV=1
let $CXXFLAGS = "-O2 -std=c++17 -Wall -Wextra -DLOCAL "
let $CXXFLAGS .= "-Wno-char-subscripts -Wno-unused-result "
let $CXXFLAGS .= "-I/home/ifsmirnov/olymp "

let $CFLAGS = "-O2 -std=c89 -pedantic -Wall -Werror -Wextra"

let g:colemak = 1
let g:python = 2


" ============================  Global settings  =====================TOC_03
set nocompatible
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set number
set showcmd
set whichwrap+=h,l
set matchpairs+=<:>
set mouse=a
set ttymouse=xterm2
" set term=xterm
set complete-=i
set hlsearch
set ruler
set wildmenu
set splitright
set splitbelow
set autoread
set undofile
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//
set backspace=indent,eol,start
set timeoutlen=700
syntax on
let g:c_space_errors = 1
set list
set listchars=tab:>-
" <C-A> works on 07
set nrformats-=octal
" no new tab after namespace
set cinoptions+=N-s
set incsearch
set ignorecase
set smartcase
set conceallevel=1
set shortmess+=c
set langremap
au FileType * setlocal formatoptions-=r formatoptions-=o
au FileType markdown setlocal formatoptions+=r formatoptions+=o

func! ColemakOrQwerty()
    call system("~/bin/is_colemak")
    if v:shell_error
        return "Qwerti"
    else
        return "Colemak"
    fi
endf


" ==========================  File-local settings  ===================TOC_04
autocmd BufEnter *.html set shiftwidth=2
autocmd BufEnter *.html set tabstop=2
autocmd BufEnter *.html set softtabstop=2
autocmd BufEnter Makefile set noet
autocmd BufLeave Makefile set et

autocmd BufEnter *.json setlocal conceallevel=0

au BufRead,BufNewFile *.in setfiletype text
au BufRead,BufNewFile *.gradle setfiletype groovy
au BufEnter,BufRead,BufNewFile *.md setfiletype markdown


" ============================  Plugin settings  =====================TOC_05
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/mysnippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

let g:NERDTreeMapOpenExpl = "j" " thnx Colemak
au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]

let g:ctrlp_custom_ignore='/build/'

let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings = 1
let g:ycm_complete_in_comments = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_auto_trigger = 0

let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1

let g:searchindex_next_key = g:colemak ? 'l' : 'n'

let g:ctrlp_working_path_mode = 'a'

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1

" let g:XkbSwitchEnabled = 1
" let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
" let g:XkbSwitchIMappings = ['ru']

" autocmd FileType java setlocal omnifunc=javacomplete#Complete

" let g:codi#log = '/tmp/codi_log'
" let g:codi#rightalign = 0
let g:codi#width = 80
let g:codi#rightsplit = 0


" ================================  Colors  ==========================TOC_06
set t_Co=256
colorscheme elflord
highlight DiffAdd    cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=none ctermfg=10 ctermbg=1 gui=none guifg=bg guibg=Red

highlight ColorColumn ctermbg=237


" ===============================  Mappings  =========================TOC_07
let mapleader=","

" Functions are defined later
map <F9> :call Compile()<Enter>
imap <F9> <Esc>:call Compile()<Enter>
map <F5> :call Run()<Enter>
imap <F5> <Esc>:call Run()<Enter>
map <F6> :call RunWithArgs()<Enter>
imap <F6> :call RunWithArgs()<Enter>

" Copy current file to X clipboard
map <F4> :!cl i < %<Enter><Enter>

nnoremap Q <nop>

map gc <plug>NERDCommenterComment
map gu <plug>NERDCommenterUncomment

map gd :YcmCompleter GoToImprecise<Enter>
map gD :YcmCompleter GetTypeImprecise<Enter>
map ,f :YcmCompleter FixIt<Enter>:cclose<Enter>

" Fold the function body staying in its first line
map gz HV/{<Enter>%zf:let @/=""<Enter>

nnoremap gp `[v`]
nnoremap gP `[V`]
iab uns using namespace std

map s :s/
map gb <C-^>

map <Leader>r :source ~/.vimrc<Enter>
map <Leader>n :NERDTreeToggle<Enter>
map <Leader>u :UndotreeToggle<Enter>:UndotreeFocus<Enter>

map <Leader>/ :nohlsearch<Enter>

map <C-T> :tabe<Enter>

imap {<CR> {<CR>}<Esc>O

map ; :
nnoremap q; q:i

" Do not reset indent when typing #
inoremap # X#

func! MacroInVisualMode()
    let t = nr2char(getchar())
    return "q" . t . "gv"
endf

vmap <expr> q MacroInVisualMode()

" =========================  Compile/Run functions  ==================TOC_08
func! Compile()
    write
    if &filetype == "cpp" || &filetype == "c"
        let CXXFLAGS = $CXXFLAGS
        call system("grep '#include \"jngen.h\"' " . shellescape(expand("%")))
        if !v:shell_error 
            echom "Success"
            let $CXXFLAGS .= "-DJNGEN_DECLARE_ONLY "
            let $CXXFLAGS .= "/home/ifsmirnov/olymp/jngen/lib.o "
        endif

        silent !echo
        silent !echo -e "\033[31;1m* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\033[0;m"
        silent make! %:r
        if len(getqflist()) > 1
            :!
        endif
        redraw!

        let $CXXFLAGS = CXXFLAGS
    elseif &filetype == "java"
        !javac %
    elseif &filetype == "tex"
        !pdflatex %
    else
        echom "Cannot compile file of type " . &filetype
    endif
    " redraw!
endf

func! Run()
    write
    if &filetype == "python"
        if g:python == 3
            !python3 %
        else
            !python %
        endif
    elseif &filetype == "perl"
        !perl %
    elseif &filetype == "tex"
        !evince %<.pdf 2>/dev/null &
    elseif &filetype == "sh" || &filetype == "bash"
        !bash %
    elseif &filetype == "java"
        !java %<
    elseif &filetype == "text"
        write
        wincmd w
        call Run()
        wincmd w
    else
        !./%<
    endif
endf

func! RunWithArgs()
    !xargs -L 1 ./%<
endf


" ===========================  Russian language  =====================TOC_09
" func! SetRussianLangmap()
"     let x1  = "йцукенгшщзхъфывапролджэячсмитьбю"
"     let y1  = "qwfpgjluy;[]arstdhneio'zxcvbkm,."
"     let x2  = "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
"     let y2  = "QWFPGJLUY:{}ARSTDHNEIO\\\"ZXCVBKM<>"
"     " More escaping for the god of escaping
"     " '\\\\' stands for literal '\', '\\0' stands for backref
"     let x1  = substitute(x1, ",\\|;", "\\\\\\\\\\0", "g")
"     let y1  = substitute(y1, ",\\|;", "\\\\\\\\\\0", "g")
"     let x2  = substitute(x2, ",\\|;", "\\\\\\\\\\0", "g")
"     let y2  = substitute(y2, ",\\|;", "\\\\\\\\\\0", "g")
"     let map = x1 . ";" . y1 . "," . x2 . ";" . y2
"     echo map
"     " let map = x1 . ";" . y1
"     exec "set langmap=" . map
" endf
"
" call SetRussianLangmap()
" imap оо <Esc>
" inoremap соо соо
" map Д $
" map Р ^
" cmap ц w
" imap А А
" imap с с
" langmap ru-en(colemak) to be added soon


" ==================================  Git  ===========================TOC_10
" TODO: replace these mappings with fugitive
" map gA :!git add %<Enter>
" map gB :!tig blame %<Enter>
" map gC :!git commit<Enter>
" map gD :!git df %<Enter>
" map gS :!git s<Enter>

func! DiffWithHead()
    echo expand('%')
    let relpath=system('git ls-tree --name-only --full-name HEAD ' . expand('%'))
    echo relpath
    vnew
    execute "normal V:!" . 'git cat-file blob HEAD:' . relpath
    windo diffthis
    wincmd w
endf


" ================================  Colemak  =========================TOC_11
if g:colemak
    noremap n j
    noremap e k
    noremap i zvl
    onoremap i l
    noremap l n
    noremap k i
    noremap j e
    noremap N J
    map E K
    noremap I $
    noremap L N
    noremap K I
    noremap J E

    noremap gn gj
    noremap ge gk
    noremap gl gn

    map H ^

    nnoremap <C-W>n <C-W>j
    nnoremap <C-W>e <C-W>k
    nnoremap <C-W>i <C-W>l
    nnoremap <C-W>N <C-W>J
    nnoremap <C-W>E <C-W>K
    nnoremap <C-W>I <C-W>L

    " todo: @='5n'
    " (http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_2))
    map <C-N> 5n
    map <C-E> 5e
    inoremap kk <Esc>
else
    " Not yet supposed to be working
    silent! unmap n
    silent! unmap e
    silent! unmap i
    silent! unmap l
    silent! unmap k
    silent! unmap j
    silent! unmap N
    silent! unmap E
    silent! unmap I
    silent! unmap L
    silent! unmap K
    silent! unmap J

    silent! iunmap kk
    silent! unmap <C-N>
    silent! unmap <C-E>


    imap jj <Esc>
    map <C-J> 5j
    map <C-K> 5k
endif


" =============================  Miscellaneous  ======================TOC_12
func! Switch(insert)
    echo a:insert
    echo "h: highlight"
    echo "p: paste"
    echo "c: copy (numbers & mouse)"
    echo ""
    let c = nr2char(getchar())
    if c == 'h'
        set hlsearch!
    elseif c == 'p'
        set paste!
    elseif c == 'c'
        if &mouse == 'a'
            set mouse=
        else
            set mouse=a
        endif
        set number!
    else
        echo "fail"
    endif
    if a:insert == 1
        normal l
        startinsert
    endif
endf

map <F8> :call Switch(0)<Enter>
imap <F8> <Esc>:call Switch(1)<Enter>


func! Theo()
    normal o\begin{theorem} \label{th:}
    normal mt
    normal o\end{theorem}
    normal o\begin{proof}
    normal o\end{proof}
    normal `t
endf

func! Lem()
    normal o\begin{lem} \label{th:}
    normal mt
    normal o\end{lem}
    normal o\begin{proof}
    normal o\end{proof}
    normal `t
endf

func! SubSwap(arg1, arg2, ...)
    if a:0 > 0 && a:1 == 1
        let S='%s/\V'
    else
        let S='%s/'
    endif

    exec S . a:arg1 . '/ADFLJWERFASDFWERWAFDASFEWR/g'
    exec S . a:arg2 . '/' . a:arg1 . '/g'
    exec S . 'ADFLJWERFASDFWERWAFDASFEWR/' . a:arg2 . '/g'
endf
let g:rainbow_conf = {
    \    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \    'operators': '_,_',
    \    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \    'separately': {
    \        '*': {},
    \        'tex': {
    \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \        },
    \        'lisp': {
    \            'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \        },
    \        'vim': {
    \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \        },
    \        'html': {
    \            'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \        },
    \        'css': 0,
    \    }
    \}
