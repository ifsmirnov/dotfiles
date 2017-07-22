" Fuck YCM for a moment
let g:loaded_youcompleteme = 1

let g:colemak = 1

" autocmd BufEnter *.cpp,*.h sign define dummy
" autocmd BufEnter *.cpp,*.h execute 'sign place 9 line=1 name=dummy buffer=' . bufnr('')


" General options {
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
set complete-=i
set hlsearch
set ruler
set wildmenu
set splitright
set splitbelow
set autoread
set undofile
syntax on
set backspace=indent,eol,start
" }

set directory=~/.vim/.swp
set undodir=~/.vim/.undo

autocmd BufEnter *.html set shiftwidth=2
autocmd BufEnter *.html set tabstop=2
autocmd BufEnter *.html set softtabstop=2
autocmd BufEnter Makefile set noet
autocmd BufLeave Makefile set et

au BufRead,BufNewFile *.in setfiletype text
au BufRead,BufNewFile *.gradle setfiletype groovy
au BufEnter,BufRead,BufNewFile *.md setfiletype markdown

" let g:ycm_warning_symbol = ''
" let g:ycm_error_symbol = ''

" Autocomlpletion {
" autocmd BufWritePost * exec system("make_abbr < " . bufname("%"))
" autocmd FileReadPost * exec system("make_abbr < " . bufname("%"))
" }

" YouCompleteMe {
let g:ycm_seed_identifiers_with_syntax = 1
set completeopt-=preview
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings = 1
let g:ycm_complete_in_comments = 1
let g:ycm_enable_diagnostic_signs = 0

" }

" Bad formatting highlight {
" highlight LONG_LINES ctermbg=Red
" autocmd Syntax cpp syntax match LONG_LINES /.\{81\}/ containedin=ALL
" set cc=81

let g:c_space_errors = 1
" }

" Keyboard layout stuff {
" set keymap=russian-jcukenwin
"jset iminsert=0
" set imsearch=0
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" }


let g:map_cyrillic='ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
let g:map_colemak='qwfpgjluy\\;arstdhneiozxcvbkm;qwertyuiopasdfghjkl\\;zxcvbnm,QWFPGJLUY:ARSTDHNEIOZXCVBKM;QWERTYUIOPASDFGHJKL:ZXCVBNM'

let g:current_layout='colemak'

func! SetLangMap(layout)
    echo 'Setting layout to ' . a:layout
    let g:current_layout = a:layout
    let langmap = g:map_cyrillic
    if a:layout == 'colemak'
        let langmap .= g:map_colemak
    elseif a:layout == 'qwerty'
    endif
    echo langmap
endf

func! SwitchLayout()
    if g:current_layout == 'colemak'
        call SetLangMap('qwerty')
    elseif g:current_layout == 'qwerty'
        call SetLangMap('colemak')
    endif
endf

map <F3> Ocall SwitchLayout()<Enter>

imap оо <Esc>
inoremap соо соо
map Д $
map Р ^
cmap ц w
imap А А
imap с с


" Compilation functions {
func! CompileC()
    let $CFLAGS = "-O2 -std=c89 -pedantic -Wall -Werror -Wextra"
    make! %:r
endf
func! CompileCPP()
    let $CXXFLAGS = "-O2 -std=c++11 -Wall -Wextra -DLOCAL -Wno-char-subscripts -Wno-unused-result -I/home/ifsmirnov/olymp -pthread "
    make! %:r
endf
func! CompileJava()
    exec "!javac %"
endf
func! CompileTeX()
    :!pdflatex %
endf
func! CompileFlex()
    :!flex % && g++ -std=c++0x -Wall -O2 lex.yy.c -o %<
endf

func! Compile()
    :write
    if &filetype == "cpp"
        call CompileCPP()
    elseif &filetype == "c"
        call CompileC()
    elseif &filetype == "java"
        call CompileJava()
    elseif &filetype == "tex"
        call CompileTeX()
    elseif &filetype == "lex"
        call CompileFlex()
    else
        echo "Not appropriate file type"
    endif
endf
" }

" Running functions {
func! RunTeX()
    :!evince %<.pdf
endf
" TODO: replace these functions with one: RunCommand(cmd_name)
func! RunPerl()
    :!perl %
endf
func! RunPython()
    :!python %
endf
func! RunBash()
    :!bash %
endf
func! RunLua()
    :!lua %
endf
func! RunRuby()
    :!ruby %
endf
func! RunJava()
    :!java %<
endf
func! RunThis()
    :write
    :!./%
endf

func! Run()
    :write
    if &filetype == "python"
        call RunPython()
    elseif &filetype == "perl"
        call RunPerl()
    elseif &filetype == "tex"
        call RunTeX()
    elseif &filetype == "sh" || &filetype == "bash"
        call RunBash()
    elseif &filetype == "lua"
        call RunLua()
    elseif &filetype == "ruby"
        call RunRuby()
    elseif &filetype == "java"
        call RunJava()
    elseif &filetype == "text"
        write
        wincmd w
        call Run()
        wincmd w
    else
"         :!mpirun -np 2 %<
        :!./%<
    endif
endf
func! RunWithArgs()
    " For basic Run() only!
    :!xargs -L 1 ./%<
endf
" }

" Run/compile mappings {
map <F9> :call Compile()<Enter>
imap <F9> <Esc>:call Compile()<Enter>
map <F5> :call Run()<Enter>
imap <F5> <Esc>:call Run()<Enter>
map <F6> :call RunWithArgs()<Enter>
imap <F6> :call RunWithArgs()<Enter>
map <F4> :!cl i < %<Enter><Enter>

" }

" Makefile support on <F8> & <F7> {
map <F10> :w<Enter>:!make -j<CR>
imap <F10> <Esc> :w<Enter>:!make -j<CR>
map <F7> :!./main<CR>
imap <F7> <Esc> :!./main<CR>
" }

" Comments {
func! GetCommentString()
    let str = "#"
    if &filetype == "cpp" || &filetype == "c" || &filetype == "html" || &filetype == "java"
        let str = "//"
    elseif &filetype == "vim"
        let str = "\""
    elseif &filetype == "tex"
        let str = "%"
    endif
    return str . " "
endf
func! AddComment()
    let str = GetCommentString()
    call setline(".", str . getline("."))
    let move_cnt = len(str)
    while move_cnt > 0
        normal l
        let move_cnt -= 1
    endwhile
endf
func! RemoveComment()
    " ISSUE: works bad on multiline comments and when line is a comment only
    " with no leading whitespace
    let str = GetCommentString()
    let old = getline(".")
    let new = substitute(old, "^" . str, "", "")
    if old == new
        let str = str[:-2]
        let new = substitute(old, "^" . str, "", "")
    endif
    let move_cnt = len(old) - len(new)
    while move_cnt > 0
"         normal h
        let move_cnt -= 1
    endwhile
    call setline(".", new)
endf
map gc :call AddComment()<Enter>
map gu :call RemoveComment()<Enter>

au FileType c,cpp setlocal comments-=:// comments+=f://
" }

" Folding {
map gz HV/{<Enter>%zf:let @/=""<Enter>
" }}

" TODO: FoldFunction() function (2 paren types) // DONE
" TODO (think): /* */ C++ comment for multi-line commenting
" TODO (later): how to work with tabs and use <F4> to switch a.h[pp]/a.cpp

" C // comments
" map gc :s:^\([ <Tab>]*\):\1//:<Enter>`'ll
" map gu :s:^\([ <Tab>]*\)//:\1:e<Enter>`'hh
" map gc m':s:^\([ <Tab>]*\):\1//:<Enter>`'ll
" set timeoutlen=300
set timeoutlen=300


" put English active vocabulary files in a proper form {
func! ParseAV()
    :%s/^\(E.g.\|syn\).*\n//ge
    :%s/ - .*$//ge
    :%s:/.*/$::ge
    :%s/^[1-9][0-9]*. //ge
endf
" }

" Git {
map gA :!git add %<Enter>
map gB :!tig blame %<Enter>
map gC :!git commit<Enter>
map gD :!git df %<Enter>
map gS :!git s<Enter>
" }

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

map L $
map H ^

nnoremap gp `[v`]
nnoremap gP `[V`]

iab uns using namespace std

set list
set listchars=tab:>-

" Adequate syntax hl when using vimdiff
highlight DiffAdd    cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=none ctermfg=10 ctermbg=1 gui=none guifg=bg guibg=Red

" imap jk <esc>:w<cr>
" imap kj <esc>:w<cr>
" imap {<cr> {<cr>}<esc>O

" inoremap <C-E> \emph{}<Left>
" imap <C-R> \item 
" map < a<<>><Left><Left>
" map Б a<<>><Left><Left>

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

func! DiffWithHead()
    echo expand('%')
    let relpath=system('git ls-tree --name-only --full-name HEAD ' . expand('%'))
    echo relpath
    vnew
    execute "normal V:!" . 'git cat-file blob HEAD:' . relpath
    windo diffthis
    wincmd w
endf

" imap jk <esc>:w<cr>
" imap {<cr> {<cr>}<esc>O
" set cin
" set cinw+=forn

" map j gj
" map k gk

let $IFSMIRNOV=1

" LaTeX
" set nolist wrap linebreak columns=120
" map j gj
" map k gk
" vmap j gj
" vmap k gk

map s :s/
map gb <C-^>

if g:colemak
    noremap n j
    noremap e k
    noremap i l
    noremap l n
    noremap k i
    noremap j e
    noremap N J
    noremap E K
    noremap I $
    noremap L N
    noremap K I
    noremap J E

    silent! iunmap jj
    silent! unmap <C-J> 5j

    silent! unmap <C-K> 5k

    imap kk <Esc>
    map <C-N> 5n
    map <C-E> 5e

else
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
" General mappings {
" }
