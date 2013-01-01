" Prerequire   {{{1
" source $VIMRUNTIME/vimrc_example.vim
set nocompatible

runtime! macros/matchit.vim
runtime! ftplugin/man.vim

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
nmap <F2> :Helptags<CR>
" }}}1

" General   {{{1
if has("win32")   " {{{2
    set shellslash
    "set guifont=DejaVu_Sans_Mono:h12
    set guifont=Consolas:h12
    set vb t_vb=\".  " stop beep
endif
" }}}2

if has("gui_running")   " {{{2
    set guioptions+=b  " v scroll bar
    set guioptions-=m  " delete menubar
    set winaltkeys=no
endif
" }}}2

" color   {{{2
" switch syntax highlighting on, when the terminal has colors.
" also switch on highlighting the laast used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch

    set t_Co=256  " to use molokai in terminal

    if findfile("molokai.vim", finddir("~/.vim/colors")) != ""
        colorscheme molokai
    else
        colorscheme desert
    endif

    if !has("gui_running")
        hi Normal ctermbg=none
        hi LineNr ctermbg=none
        hi NonText ctermbg=none
    endif

    hi ColorColumn ctermbg=238 guibg=darkgray
endif
" }}}2

" status line   {{{2
set laststatus=2

if has("statusline")
    set statusline=%!Statusline()
    "set statusline=
endif
" }}}2

" encoding   {{{2
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set ambiwidth=double
set fileformat=unix
" }}}2

" indent   {{{2
filetype indent on
set cin
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=8  " tab length 8
set shiftwidth=4  " indent length 4
set softtabstop=4
" }}}2

" misc {{{2
set number
set foldmethod=marker
set textwidth=79
set colorcolumn=+1
set wrap
set linebreak
set noignorecase
set incsearch  " instance search
set wildmenu
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set showmatch
set matchtime=1
set fo+=mt
"set cursorline  " heighlight current line
" }}}2

if has('mouse')
    set mouse=a
endif

set nobackup
set history=50
set autoread
set autowriteall
filetype plugin on

set path=./*/*,../include,/usr/include/*,/usr/include/c++/*/*
" }}}1

" plugin   {{{1
" ctrlp  {{{2
let g:ctrlp_show_hidden = 1
" }}}2

" doxygentoolkit   {{{2
" url: http://www.vim.org/scripts/script.php?script_id=987

"let g:doxygentoolkit_commenttype = "c++
let g:doxygentoolkit_authorname="Li Liqiang"
let g:doxygentoolkit_brieftag_funcname = "yes"
let g:doxygentoolkit_brieftag_post="- "
let g:doxygentoolkit_paramtag_post=" - "
let g:doxygentoolkit_returntag="@return - "
let g:doxygentoolkit_filetag="@file - "
let g:doxygentoolkit_versiontag="@version - "
let g:doxygentoolkit_datetag="@date - "
let g:doxygentoolkit_authortag="@author - "
let g:doxygentoolkit_licensetag="@license - "

map <f4> :dox<cr>
map <c-f4> :doxauthor<cr>
" }}}2

" python-dict   {{{2
" url: http://www.vim.org/scripts/script.php?script_id=850
" let g:pydiction_location="/home/l/.vim/ftplugin/python_dict/complete-dict"
" let g:pydiction_menu_height=15  " default
" }}}2

" clang-complete   {{{2
" url: http://www.vim.org/scripts/script.php?script_id=3302
let g:clang_use_library=1
let g:clang_library_path="/usr/local/lib"
let g:clang_auto_select=1
" }}}2

" snipmate   {{{2
" url: http://www.vim.org/scripts/script.php?script_id=3302
let g:snips_author = 'Li Liqiang'
" }}}2

" vimim   {{{2
" let g:vimim_map = 'c-bslash'
" }}}2

" vim-latex   {{{2
" starting with vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" the following changes the default filetype back to 'tex':
" let g:tex_flavor='latex'
" }}}2

" syntastic   {{{2
"let g:syntastic_check_on_open=1
let g:syntastic_mode_map = { 'mode': 'passive',
            \ "active_filetypes": [],
            \ "passive_filetypes":[]}
let g:syntastic_error_symbol='x'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler="clang++"
let g:syntastic_cpp_compiler_options=" -std=c++0x"
let g:syntastic_cpp_auto_refresh_includes = 1
nmap ,e :error<CR>
nmap ,s :syntasticcheck<CR>
nmap ,t :syntastictogglemode<CR>
" }}}2
" }}}1

" mapping   {{{1
"let mapleader = "\"
nmap 0 ^
nmap <leader>e :vsp $MYVIMRC<CR>
nmap <leader>s :so $MYVIMRC<CR>
nmap <leader>w :lcd %:p:h<CR>
nmap <C-S> <ESC>:w<CR>
nmap ,s <ESC>:w<CR>
vmap <C-C> "+y
"imap <c-v> <esc>"+gp
"nmap <c-v> "+gp
"vmap <c-v> "+gp
nmap <F5> :call <SID>run_py()<CR>
nmap <C-F5> :!pep8 %<CR>
nmap <F6> :call <SID>cfamilyformat()<cr>
" delete the blank of the line
nmap <F8> :silent!<SPACE>%s/\s\+$//g<CR>w<CR>
nmap <C-F8> :%s///g
nmap <C-N><C-H> :nohls<CR>
nmap <C-H> :h<space>
" nmap <f2> :helptags ~/.vim/doc<cr>
nmap <M-A> ^
nmap <M-L> $
nmap <F9> :call <SID>compilec_pp()<CR>
nmap <S-F9> :call <SID>runc_pp()<CR>
nmap <leader>i :call <SID>insertdomain()<CR>
nmap <leader>f :nerdtreetoggle<CR>
nmap <leader>t :tagbartoggle<CR>
" to avoid popup menu in ubuntu
imap <F10> <NOP>
nmap <F10> <NOP>
imap <C-UP> <ESC><C-W>k
imap <C-DOWN> <ESC><C-W>j
imap <C-LEFT> <ESC><C-W>h
imap <C-RIGHT> <ESC><C-W>l
imap <C-L> <C-O>:call <SID>emacs_ctrl_l()<CR>
" }}}1

" function definition   {{{1
func! <SID>run_py()   " {{{2
    if &ft != 'python'
        echo 'this file is not python'
        return
    endif

    let dir = expand("%:p:h")
    "silent execute "!gnome-terminal --working-directory='".dir."' -x bash -c \"python '".expand("%:t")."'; read -s -p 'press any key to exit...' -n 1\""

    exe 'redraw!'
endfunc " }}}2

function! <SID>cfamilyformat()   " {{{2
    let fullpath = expand("%:p")

    if has("win32")
        let docformat = '1'
    else
        let docformat = '2'
    endif

    if &ft == 'c' || &ft == 'cpp'
        execute "!astyle -a3s4ccsnlwym0mfuphjk1nz".docformat." --options=none '".fullpath."'"
        "exe "!astyle '".fullpath."'"
        echo "format finished"
    elseif &ft == 'java'
        execute "!astyle --options=none --style=java -s4ccslwymmfuphjk1nz".docformat." '".fullpath."'"
    endif

    let dummpy = input('press enter to continue...')
    execute "redraw!"
endfunction " }}}2

funct! <SID>compilec_pp()   " {{{2
    let dir=expand("%:h:t")
    let fulldir=expand("%:p:h")
    let fname=expand("%:t")
    let fullname = expand("%:p")
    let exefname = expand("%:t:r")
    let exefullname = fulldir.'/'.fname

    "call checkheader()

    if &ft == 'c'
        set makeprg=gcc\ -g\ -wall\ -o\ %<\.exe\ %
        set makeprg=clang\ -g\ -wall\ -o\ %<\.exe\ %
    elseif &ft == 'cpp'
        set makeprg=g++\ -std=c++0x\ -g\ -wall\ -o\ %<\.exe\ %
        set makeprg=clang++\ -std=c++0x\ -g\ -wall\ -o\ %<\.exe\ %
    else
        execute "!notify-send -i vim 'falurely' 'this is not a c/cpp file'"
        return
    endif

    "if findfile(exefname.'.exe', fulldir) == dir.'/'.exefname.'.exe' && \
    "delete(fulldir.'/'.exefname.'exe') != 0
        "execute "!notify-send -i vim 'falurely' 'delete falurely'"
        "return
    "endif
    make
endfunc " }}}2

"func! <SID>checkheader()   " {{{2 let g:use_thread=0 let g:use_math=0 let
"g:use_aput=0

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

"endfunc " }}}2

func! <SID>runc_pp()   " {{{2
    let dir = expand("%:p:h")
    let fname = expand("%:t:r").'.exe'
    let exefile = dir.'/'.fname
    let excmd = "!if [ -f ".exefile." ]; then gnome-terminal -x bash -c \"'".exefile."'; read -s -p 'press any key to exit...' -n 1;\" else notify-send -i vim 'there is not such a file'; fi"
    silent execute excmd
    exec 'redraw!'
endfunc " }}}2

func! <SID>insertdomain()   " {{{2
    if &ft != 'c' && &ft != 'cpp'
        return
    endif

    if has('win32')
        let newline='\r\n'
    else
        let newline='\r'
    endif

    let classname = input('input class name: ')
    let cmd = "%s/\\<\\(\\~\\?\\(\\a\\|_\\)\\w*(.*)\\s*\\w*\\s*\\);/".classname."::\\1".newline."{".newline."}".newline."/g"
    exec cmd
endfunc " }}}2

func! <SID>fileencoding()   " {{{2
    if &fenc == ""
        return ""
    endif

    let b=""

    if exists("+bomb") && &bomb
        let b = "+b"
    endif

    return "[".&fenc.b."]"
endfunc " }}}2

func! Statusline()   " {{{2
    return "%f %m%y%r".<SID>fileencoding()."%q%w[%{&ff}]%=%l,%c%v%12p"
endfunc " }}}2

func! <SID>emacs_ctrl_l()
    if !exists("b:count")  " {{{
        let b:win_line_nu = winheight(0)
        let b:cur_line_nu = winline()
        let half_lines = (b:win_line_nu - 1) / 2

        if b:cur_line_nu == 0
            " top
            let b:count = 2
        elseif b:cur_line_nu <= half_lines
            " (top, middle]
            let b:count = 1
        else
            " (middle, bottom]
            let b:count = 0
        endif
    endif
    " }}}

    if b:count == 2 " {{{
        " from top to bottom
        normal zb
    elseif b:count == 1
        " from middle to top
        normal zt
    else
        " from bottom to middle
        normal zz
    endif
    " }}}

    let b:count = (b:count + 1) % 3
endfunc
" }}}1

" autocmd   {{{1
" auto source .vimrc when saving
if has("autocmd")
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif
" }}}1

" command   {{{1
" }}}1
