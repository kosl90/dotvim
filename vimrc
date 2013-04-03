" Prerequire   {{{1
" source $VIMRUNTIME/vimrc_example.vim
set nocompatible

" Vundle   {{{2
filetype off
if 'bundle' !~ &rtp
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
end
" }}}2

" Variables   {{{2
let g:note_path="~/Dropbox/notes"
" }}}2
" }}}1

" Bundles   {{{1
"on github   {{{2
Bundle 'mileszs/ack.vim'
Bundle 'ujihisa/neco-ghc'
Bundle 'Shougo/vimproc'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'gmarik/vundle'
Bundle 'Rip-Rip/clang_complete'
Bundle 'kien/ctrlp.vim'

Bundle 'xuhdev/SingleCompile'
Bundle 'vim-scripts/css3'
Bundle 'vim-scripts/LargeFile'
" maybe someone will be deleted
Bundle "vim-scripts/gtk-vim-syntax"
Bundle "vim-scripts/gtk-mode"

Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'

Bundle 'majutsushi/tagbar'
Bundle 'SirVer/ultisnips'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'

Bundle 'vim-ruby/vim-ruby'
Bundle 'mattn/zencoding-vim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'kosl90/pyflakes-vim'
Bundle 'tomasr/molokai'
" }}}2

" on vim-scripts   {{{2
Bundle 'DoxygenToolkit.vim'
Bundle 'a.vim'
" Bundle 'conque'
" }}}2
" }}}1

" function definition   {{{1
func! ChangeUnimpariedMap()   " {{{2
    nmap [t :tabprevious<CR>
    nmap ]t :tabnext<CR>
    nmap [T :tabfirst<CR>
    nmap ]T :tablast<CR>
endfunc  " }}}2

func! RunPy()   " {{{2
    if &ft != 'python'
        echo 'this file is not python'
        return
    endif

    let dir = expand("%:p:h")
    silent execute "!gnome-terminal --working-directory='".dir."' -x bash -c \"python '".expand("%:t")."'; read -s -p 'press any key to exit...' -n 1\""

    exe 'redraw!'
endfunc " }}}2

function! Cfamilyformat()   " {{{2
    let fullpath = expand("%:p")

    if has("win32")
        let docformat = '1'
    else
        let docformat = '2'
    endif

    if &ft == 'c' || &ft == 'cpp'
        execute "!astyle -A3s4cCSLwYmMfUpHjk1nz".docformat." --options=none '".fullpath."'"
        "exe "!astyle '".fullpath."'"
    elseif &ft == 'java'
        execute "!astyle --options=none --style=java -A3s4cCSLwYmMfUpHjk1nz".docformat." '".fullpath."'"
    endif

    execute "redraw!"
endfunction " }}}2

funct! Compilec_pp()   " {{{2
    let dir=expand("%:h:t")
    let fulldir=expand("%:p:h")
    let fname=expand("%:t")
    let fullname = expand("%:p")
    let exefname = expand("%:t:r")
    let exefullname = fulldir.'/'.fname

    "call checkheader()

    if &ft == 'c'
        set makeprg=gcc\ -g\ -Wall\ -o\ %<\.exe\ %
        set makeprg=clang\ -g\ -Wall\ -o\ %<\.exe\ %
    elseif &ft == 'cpp'
        set makeprg=g++\ -std=c++0x\ -g\ -Wall\ -o\ %<\.exe\ %
        set makeprg=clang++\ -std=c++0x\ -g\ -Wall\ -o\ %<\.exe\ %
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

"func! Checkheader()   " {{{2
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

"endfunc " }}}2

func! Runc_pp()   " {{{2
    let dir = expand("%:p:h")
    let fname = expand("%:t:r").'.exe'
    let exefile = dir.'/'.fname
    let excmd = "!if [ -f ".exefile." ]; then gnome-terminal -x bash -c \"'".exefile."'; read -s -p 'press any key to exit...' -n 1;\" else notify-send -i vim 'there is not such a file'; fi"
    silent execute excmd
    exec 'redraw!'
endfunc " }}}2

func! Insertdomain()   " {{{2
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

func! Fileencoding()   " {{{2
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
    return "%f %m%y%r".Fileencoding()."%q%w[%{&ff}]%=%l,%c%V%12P"
endfunc " }}}2

func! Emacs_ctrl_l()   " {{{2
    let pos = s:pos_marker()

    call s:scroll(pos)
endfunc " }}}2

func! s:pos_marker()   " {{{2
    let win_line_nu = winheight(0)
    let cur_line_nu = winline()
    let half_lines = (win_line_nu + 1) / 2

    if cur_line_nu == 1
        " top
        return 2
    elseif cur_line_nu <= half_lines
        " (top, middle]
        return 1
    else
        " (middle, bottom]
        return 0
    endif
endfunc " }}}2

func! s:scroll(pos)   " {{{2
    if a:pos == 2
        " from top to bottom
        normal zb
    elseif a:pos == 1
        " from middle to top
        normal zt
    else
        " from bottom to middle
        normal zz
    endif
endfunc " }}}2

func! AutoNewLine()   " {{{2
    let last_line = getline('$')
    if last_line != ""
        call append('$', [''])
    endif
endfunc " }}}2

func! OpenVimrc()   " {{{2
    if getline(nextnonblank(1)) == ""
        e $MYVIMRC
    else
        vsp $MYVIMRC
    endif
endfunc " }}}2

func! CreateNoteFunc(name)  " {{{2
    if !exists("g:note_path")
        let g:note_path = "~/Dropbox/notes/"
    endif

    if g:note_path !~ '/$'
        let g:note_path = g:note_path . '/'
    endif

    exec "edit " . g:note_path . a:name
endfunc   "}}}2

func! TabMapAux(num)   " {{{2
    let num = a:num == 0 ? 10 : a:num
    exec "map <leader>".num." ".num."gt"
endfunc " }}}2

func! TabMap()  " {{{2
    let i = 0
    while i < 10
        call TabMapAux(i)
        let i += 1
    endwhile
endfunc " }}}2

function! MyTabLine()   " {{{2
  let s = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, 'buftype')
    if buftype == 'nofile'
      if file =~ '\/.'
        let file = substitute(file, '.*\/\ze.', '', '')
      endif
    else
      let file = fnamemodify(file, ':p:t')
    endif
    if file == ''
      let file = '[No Name]'
    endif
    let s .= string(i) . ":"
    let file = strpart(file, 0, 10)
    let s .= file
    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return s
endfunction "}}}2

func! DeleteTrailingBlank()   " {{{2
    " TODO: this is wrong, fix it
    exec ':silent! %s/\s\+$//g'
endfunc " }}}2
" }}}1

" General   {{{1
" misc {{{2
filetype indent plugin on
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
set cursorline  " heighlight current line
set autochdir

if has('mouse')
    set mouse=a
endif

set nobackup
set history=50
set autoread
set autowriteall

let $PATH=$PATH . ':' . expand('~/.cabal/bin')
set path=.,./*/*,../include,/usr/include/*,/usr/include/c++/*/*
set wildignore=*.o,*.obj,*.exe,a.out,*.pdf,*~,*.chm,#*#

let auto_new_line = 1
" }}}2

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

    if findfile("molokai.vim", finddir("~/.vim/bundle/molokai/colors")) != ""
        colorscheme molokai
    else
        colorscheme desert
    endif

    if !has("gui_running")
        hi Normal ctermbg=none
        hi LineNr ctermbg=none
        hi NonText ctermbg=none
        hi Comment ctermfg=228
    endif

    hi ColorColumn ctermbg=238 guibg=darkgray
endif
" }}}2

" status line   {{{2
set laststatus=2

if has("statusline")
    set statusline=%!Statusline()
    " set statusline=
endif
" }}}2

" Tab line setting {{{2
call TabMap()
set tabline=%!MyTabLine()  " custom tab pages line
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
set cinoptions=:0,l1,g0,(0
set listchars=tab:>-,trail:-
set list
" }}}2
" }}}1

" autocmd   {{{1
au VimEnter * call ChangeUnimpariedMap()

" set filetype   {{{2
au BufReadPost,BufNewFile .xmobarrc,xmobarrc set filetype=haskell
au BufReadPost,BufNewFile *.zsh* set filetype=zsh
au BufReadPost,BufNewFile *.md,*.note set filetype=markdown
" }}}2

" auto source .vimrc when saving
au BufWritePost .vimrc source $MYVIMRC

" auto complete   {{{2
au FileType haskell set omnifunc=necoghc#omnifunc
au FileType python set omnifunc=pythoncomplete#Complete
au FileType ruby set omnifunc=rubycomplete#Complete
" }}}2

if exists('auto_new_line') && auto_new_line
    au BufWritePre,FileWritePre,BufUnload *.c,*.cc,*.cpp call AutoNewLine()
endif

au BufWritePre,FileWritePre,BufUnload * call DeleteTrailingBlank()
" }}}1

" command   {{{1
command! -nargs=1 CreateNote :call CreateNoteFunc(<q-args>)
" }}}1

" plugin   {{{1
runtime! macros/matchit.vim
runtime! ftplugin/man.vim

" UltiSnips   {{{2
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }}}2

" haskell indent   " {{{2
let g:haskell_indent_if = 0
" }}}2

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

map <F4> :Dox<CR>
map <C-F4> :Doxauthor<CR>
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
            \ 'active_filetypes': ['javascript'],
            \ 'passive_filetypes':[]}
let g:syntastic_error_symbol='x'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++0x'
let g:syntastic_cpp_auto_refresh_includes = 1
nmap ,e :Error<CR>
nmap ,c :SyntasticCheck<CR>
nmap ,t :SyntasticToggleMode<CR>
" }}}2
" }}}1

" mapping   {{{1
nmap 0 ^
nmap <leader>e :call OpenVimrc()<CR>
nmap <leader>s :so $MYVIMRC<CR>
nmap <leader>w :lcd %:p:h<CR>
nmap <C-S> <ESC>:w<CR>
nmap ,s <ESC>:w<CR>
vmap <C-C> "+y
"imap <c-v> <esc>"+gp
"nmap <c-v> "+gp
"vmap <c-v> "+gp
nmap <F5> :call RunPy()<CR>
nmap <C-F5> :!pep8 %<CR>
nmap <F6> :call Cfamilyformat()<cr>

" delete the blank of the line
nmap <F8> :call DeleteTrailingBlank()<CR>
nmap <C-F8> :%s///g
nmap <C-N><C-H> :nohls<CR>
" nmap <f2> :helptags ~/.vim/doc<cr>
nmap <M-A> ^
nmap <M-L> $
nmap <F9> :call Compilec_pp()<CR>
nmap <S-F9> :call Runc_pp()<CR>
nmap <leader>i :call Insertdomain()<CR>
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>t :TagbarToggle<CR>
" to avoid popup menu in ubuntu
imap <F10> <NOP>
nmap <F10> <NOP>
imap <C-UP> <ESC><C-W>ka
imap <C-DOWN> <ESC><C-W>ja
imap <C-LEFT> <ESC><C-W>ha
imap <C-RIGHT> <ESC><C-W>la
imap <C-L> <C-O>:call Emacs_ctrl_l()<CR>
nmap <C-L> :call Emacs_ctrl_l()<CR>
nnoremap <leader>l <C-L>
nmap <C-H> :h<space>
nmap <C-E> :set fileencoding=utf8
" }}}1
