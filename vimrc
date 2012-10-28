"==========================================================================
"                               general
"
"==========================================================================
" source $VIMRUNTIME/vimrc_example.vim

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

if has("win32")
    set shellslash
    set guifont=DejaVu_Sans_Mono:h12
    set guifont=Consolas:h12
    set vb t_vb=\".  " stop beep
endif

set ambiwidth=double
colorscheme molokai
"colorscheme desert
set nocompatible
set nobackup
set number
set wrap
"set nowrap
set ignorecase
set incsearch  " instance search
" set cursorline  " heighlight current line
set wildmenu
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set textwidth=79
set colorcolumn=80
set history=50
set autoread
set autowriteall
set lbr  " linebreak
set fo+=mb  " m:chinese wrap, b:
" set sm  " auto match patheses
" set spell
filetype plugin indent on

" Switch syntax highlighting on, when the terminal has colors.
" Also switch on highlighting the laast used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

if has("gui_running")
    set guioptions+=b  " v scroll bar
endif



"==========================================================================
"                                encode
"==========================================================================
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileformat=unix



"==========================================================================
"                                indent
"==========================================================================
set cin
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=8  " tab length 8
set shiftwidth=4  " indent length 4



"==========================================================================
"                                plugin
"==========================================================================
"==========================================================================
"                                totd
" url: http://www.vim.org/scripts/script.php?script_id=88
" =========================================================================
nmap <leader><F1> :TipOfTheDay<CR>

"==========================================================================
"                            DoxygenToolkit
" url: http://www.vim.org/scripts/script.php?script_id=987
"==========================================================================
"let g:DoxygenToolkit_commentType = "C++
let g:DoxygenToolkit_authorName="kosl90"
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_briefTag_post="- "
let g:DoxygenToolkit_paramTag_post=" - "
let g:DoxygenToolkit_returnTag="@return - "
let g:DoxygenToolkit_fileTag="@file - "
let g:DoxygenToolkit_versionTag="@version - "
let g:DoxygenToolkit_dateTag="@date - "
let g:DoxygenToolkit_authorTag="@author - "
"let g:DoxygenToolkit_licenseTag="My own license - "

map <F4> :Dox<CR>
map <C-F4> :DoxAuthor<CR>

"==========================================================================
"                            python-dict
" url: http://www.vim.org/scripts/script.php?script_id=850
"==========================================================================
let g:pydiction_location="/home/l/.vim/ftplugin/python_dict/complete-dict"
" let g:pydiction_menu_height=15  " default

"==========================================================================
"                            clang-complete
" url: http://www.vim.org/scripts/script.php?script_id=3302
"==========================================================================
let g:clang_use_library=1
let g:clang_library_path="/usr/local/lib"
let g:clang_auto_select=1

"==========================================================================
"                               snipMate
" url: http://www.vim.org/scripts/script.php?script_id=3302
"==========================================================================
let g:snips_author = 'kosl90'
" <tab> is conflicted with pydiction's
" if the section is selected, <tab> to next, otherwise <C-j>
"if &ft == "python"
    "ino <C-j> <c-r>=TriggerSnippet()<CR>
    "snor <C-j> <esc>i<right><c-r>=TirggerSnippet()<cr>
"endif

"==========================================================================
"                               vimim
"==========================================================================
let g:vimim_map = 'c-bslash'

"==========================================================================
"                              vim-latex
"==========================================================================
" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'



"==========================================================================
"                               shortcut
"==========================================================================
"let mapleader = "\"
nmap <leader>e :e $MYVIMRC<CR>
nmap <leader>s :so $MYVIMRC<CR>
nmap <leader>w :lcd %:p:h<CR>
nmap <C-s> <ESC>:w<CR>
nmap ,s <ESC>:w<CR>
vmap <C-c> "+y
"imap <C-v> <esc>"+gp
"nmap <C-v> "+gp
"vmap <C-v> "+gp
"nmap <F5> :!gnome-terminal -x sh -c "python '%'; read -s -p 'press any key to exit...' -n 1;"<CR>
nmap <F5> :call Run_Py()<CR>
nmap <C-F5> :!pep8 %<CR>
nmap <F6> :call CFamilyFormat()<CR>
" delete the blank of the line
nmap <F8> :silent! %s/\s\+$//g<CR><C-s>
nmap <C-F8> :%s///g
nmap <C-n><C-h> :nohls<cr>
nmap <C-h> :h 
nmap <F2> :helptags ~/.vim/doc<CR>
nmap <M-a> ^
nmap <M-l> $
"au BufRead * try | execute "compiler ".&filetype | catch /./ | endtry 
nmap <F9> :call CompileC_PP()<CR>
nmap <C-F9> :call RunC_PP()<CR>
nmap <C-i> :call InsertDomain()<CR>


"==========================================================================
"                             function definition
"==========================================================================
func! Run_Py()
    if &ft != 'python'
        echo 'this file is not python'
        return
    endif

    let dir = expand("%:p:h")
    silent execute "!gnome-terminal --working-directory='".dir."' -x bash -c \"python '".expand("%:t")."'; read -s -p 'press any key to exit...' -n 1\""

    exe 'redraw!'
endfunc


function! CFamilyFormat()
    let fullpath = expand("%:p")

    if has("win32")
        let docformat = '1'
    else
        let docformat = '2'
    endif

    if &ft == 'C' || &ft == 'CPP'
        "execute "!astyle -A3s4cCSNLwYm0MfUpHjk1nz".docformat." --options=none '".fullpath."'"
        exe "!astyle '".fullpath."'"
    elseif &ft == 'JAVA'
        execute "!astyle --options=none --style=java -s4cCSLwYmMfUpHjk1nz".docformat." '".fullpath."'"
    endif
endfunction


funct! CompileC_PP()
    let dir=expand("%:h:t")
    let fulldir=expand("%:p:h")
    let fname=expand("%:t")
    let fullname = expand("%:p")
    let exefname = expand("%:t:r")
    let exefullname = fulldir.'/'.fname

    "call CheckHeader()

    if &ft == 'c'
        set makeprg=gcc\ -g\ -Wall\ -o\ %<\.exe\ %
    elseif &ft == 'cpp'
        set makeprg=g++\ -g\ -Wall\ -o\ %<\.exe\ %
    else
        execute "!notify-send -i vim 'Falurely' 'this is not a C/CPP file'"
        return
    endif

    "if findfile(exefname.'.exe', fulldir) == dir.'/'.exefname.'.exe' && \
    "delete(fulldir.'/'.exefname.'exe') != 0
        "execute "!notify-send -i vim 'Falurely' 'delete falurely'"
        "return
    "endif
    make
endfunc


"func! CheckHeader()
    "let g:use_thread=0
    "let g:use_math=0
    "let g:use_aput=0

    "for line in getline()
        "if !~ "#include"
        "endif

        "if =~ "<pthread.h>"
            "exec "let g:use_thread=1"
        "endif

        "if =~ "<math.h>"
            "exec "let g:use_math=1"
        "endif

        "if =~ "\"apue.h\""
            "exec "let g:use_apue=1"
        "endif
    "endfor

"endfunc


func! RunC_PP()
    let dir = expand("%:p:h")
    let fname = expand("%:t:r").'.exe'
    let exefile = dir.'/'.fname
    let excmd = "!if [ -f ".exefile." ]; then gnome-terminal -x bash -c \"'".exefile."'; read -s -p 'press any key to exit...' -n 1;\" else notify-send -i vim 'there is not such a file'; fi"
    silent execute excmd
    exec 'redraw!'
endfunc

func! InsertDomain()
    if has('win32')
        let newline='\r\n'
    else
        let newline='\r'
    endif

    let classname = input('Input Class Name: ')
    let cmd = "%s/\\<\\(\\~\\?\\(\\a\\|_\\)\\w*(.*)\\s*\\w*\\s*\\);/".classname."::\\1".newline."{".newline."}".newline."/g"
    exec cmd
endfunc

nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
