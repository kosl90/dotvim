"==========================================================================
"                               general
"
"==========================================================================
" source $VIMRUNTIME/vimrc_example.vim

set foldmethod=marker
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

runtime! macros/matchit.vim
runtime! ftplugin/man.vim

if has("win32")
    set shellslash
    set guifont=DejaVu_Sans_Mono:h12
    set guifont=Consolas:h12
    set vb t_vb=\".  " stop beep
endif

"set ambiwidth=double
set t_Co=256
colorscheme molokai
"colorscheme desert
set nocompatible
set nobackup
set number
set wrap
"set nowrap
set noignorecase
set incsearch  " instance search
"set cursorline  " heighlight current line
set wildmenu
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set textwidth=79
"set colorcolumn=80
set history=50
set showmatch
set matchtime=1
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
    set guioptions-=m
    set winaltkeys=no
endif

set path=./*/*,../include,/usr/include/*/*


"==========================================================================
"                                encode
"==========================================================================
set encoding=utf-8
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
set softtabstop=4


"==========================================================================
"                                plugin
"==========================================================================
"==========================================================================
"                            DoxygenToolkit
" url: http://www.vim.org/scripts/script.php?script_id=987
"==========================================================================
"let g:DoxygenToolkit_commentType = "C++
let g:DoxygenToolkit_authorName="Li Liqiang"
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_briefTag_post="- "
let g:DoxygenToolkit_paramTag_post=" - "
let g:DoxygenToolkit_returnTag="@return - "
let g:DoxygenToolkit_fileTag="@file - "
let g:DoxygenToolkit_versionTag="@version - "
let g:DoxygenToolkit_dateTag="@date - "
let g:DoxygenToolkit_authorTag="@author - "
let g:DoxygenToolkit_licenseTag="@license - "

map <F4> :Dox<CR>
map <C-F4> :DoxAuthor<CR>

"==========================================================================
"                            python-dict
" url: http://www.vim.org/scripts/script.php?script_id=850
"==========================================================================
"let g:pydiction_location="/home/l/.vim/ftplugin/python_dict/complete-dict"
" let g:pydiction_menu_height=15  " default

"==========================================================================
"                            clang-complete
" url: http://www.vim.org/scripts/script.php?script_id=3302
"==========================================================================
"let g:clang_use_library=1
"let g:clang_library_path="/usr/local/lib"
"let g:clang_auto_select=1

"==========================================================================
"                               snipMate
" url: http://www.vim.org/scripts/script.php?script_id=3302
"==========================================================================
let g:snips_author = 'kosl90'

"==========================================================================
"                               vimim
"==========================================================================
"let g:vimim_map = 'c-bslash'

"==========================================================================
"                              vim-latex
"==========================================================================
" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'

"=========================================================================
"                             syntastic
"=========================================================================
"let g:syntastic_check_on_open=1
let g:syntastic_mode_map = { 'mode': 'passive',
            \ "active_filetypes": [],
            \ "passive_filetypes":[]}
let g:syntastic_error_symbol='X'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler="clang++"
let g:syntastic_cpp_compiler_options=" -std=c++0x"
let g:syntastic_cpp_auto_refresh_includes = 1
nmap ,e :Error<CR>
nmap ,s :SyntasticCheck<CR>
nmap ,t :SyntasticToggleMode<CR>



"==========================================================================
"                               shortcut
"==========================================================================
"let mapleader = "\"
nmap <leader>e :e $MYVIMRC<CR>
nmap <leader>s :so $MYVIMRC<CR>
nmap <leader>w :lcd %:p:h<CR>
nmap <C-s> <ESC>:w<CR>
"nmap ,s <ESC>:w<CR>
vmap <C-c> "+y
"imap <C-v> <esc>"+gp
"nmap <C-v> "+gp
"vmap <C-v> "+gp
nmap <F5> :call Run_Py()<CR>
nmap <C-F5> :!pep8 %<CR>
nmap <F6> :call CFamilyFormat()<CR>
" delete the blank of the line
nmap <F8> :silent! %s/\s\+$//g<CR><C-s>
nmap <C-F8> :%s///g
nmap <C-n><C-h> :nohls<cr>
nmap <C-h> :h<Space>
" nmap <F2> :helptags ~/.vim/doc<CR>
nmap <F2> :Helptags<CR>
nmap <M-a> ^
nmap <M-l> $
nmap <F9> :call CompileC_PP()<CR>
nmap <S-F9> :call RunC_PP()<CR>
nmap <leader>i :call InsertDomain()<CR>
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>t :SyntasticToggleMode<CR>
" To avoid popup menu in Ubuntu
imap <F10> <ESC>
nmap <F10> <ESC>


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

    if &ft == 'c' || &ft == 'cpp'
        execute "!astyle -A3s4cCSNLwYm0MfUpHjk1nz".docformat." --options=none '".fullpath."'"
        "exe "!astyle '".fullpath."'"
        echo "Format finished"
    elseif &ft == 'JAVA'
        execute "!astyle --options=none --style=java -s4cCSLwYmMfUpHjk1nz".docformat." '".fullpath."'"
    endif

    let dummpy = input('press enter to continue...')
    execute "redraw!"
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
        set makeprg=clang\ -g\ -Wall\ -o\ %<\.exe\ %
    elseif &ft == 'cpp'
        set makeprg=g++\ -std=c++0x\ -g\ -Wall\ -o\ %<\.exe\ %
        set makeprg=clang++\ -std=c++0x\ -g\ -Wall\ -o\ %<\.exe\ %
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
    if &ft != 'C' && &ft != 'CPP'
        return
    endif

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


" auto source .vimrc when saving
if has("autocmd")
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif

func! FileEncoding()
    if &fenc == ""
        return ""
    endif

    let b=""

    if exists("+bomb") && &bomb
        let b = "+B"
    endif

    return "[".&fenc.b."]"
endfunc

func! StatusLine()
    return "%f %m%y%r".FileEncoding()."%q%w[%{&ff}]%=%l,%c%V%12P"
endfunc

set laststatus=2
if has("statusline")
    set statusline=%!StatusLine()
    "set statusline=
endif
