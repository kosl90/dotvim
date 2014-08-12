" Prerequire   {{{1
" source $VIMRUNTIME/vimrc_example.vim
set nocompatible

" Vundle   {{{2
filetype off
setlocal rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" }}}2

" Variables   {{{2
let g:note_path="~/Dropbox/notes"
let g:markdown_internal_inline=1
" }}}2
" }}}1

" Bundles   {{{1
"on github   {{{2
Plugin 'jelera/vim-javascript-syntax'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'gmarik/vundle'
Plugin 'szw/vim-ctrlspace'
Plugin 'peterhoeg/vim-qml'
Plugin 'groenewege/vim-less'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rking/ag.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/LargeFile'
Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'

Plugin 'kchmck/vim-coffee-script'
Plugin 'Blackrush/vim-gocode'

Plugin 'vim-scripts/css3'
Plugin 'hail2u/vim-css3-syntax'
" maybe someone will be deleted
Plugin 'vim-scripts/gtk-vim-syntax'
" Bundle 'vim-scripts/gtk-mode'

Plugin 'vim-ruby/vim-ruby'
Plugin 'mattn/emmet-vim'
Plugin 'kosl90/pyflakes-vim'
Plugin 'kosl90/qt-highlight-vim'

" Plugin 'JessicaKMcIntosh/TagmaTasks'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'tpope/vim-haml'
" Plugin 'klen/python-mode'

" Plugin 'frerich/unicode-haskell'
" Plugin 'mileszs/ack.vim'
" Plugin 'ujihisa/neco-ghc'
Plugin 'Shougo/vimproc'
" Plugin 'eagletmt/ghcmod-vim'
" Plugin 'Rip-Rip/clang_complete'
" Plugin 'xuhdev/SingleCompile'
" Plugin 'skammer/vim-css-color'
" Plugin 'jnwhiteh/vim-golang'
" }}}2

" on vim-scripts   {{{2
Bundle 'DoxygenToolkit.vim'
Bundle 'a.vim'
" Bundle 'DrawIt'
" Bundle 'conque'
" }}}2
" }}}1

" Functions {{{1
func! ChangeUnimpariedMap()   " {{{2
    unmap [b
    unmap ]b
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
        setlocal makeprg=gcc\ -g\ -Wall\ -o\ %<\.exe\ %
        setlocal makeprg=clang\ -g\ -Wall\ -o\ %<\.exe\ %
    elseif &ft == 'cpp'
        setlocal makeprg=g++\ -std=c++0x\ -g\ -Wall\ -o\ %<\.exe\ %
        setlocal makeprg=clang++\ -std=c++0x\ -g\ -Wall\ -o\ %<\.exe\ %
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
        call append(line('$'), [''])
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
    exec "map <leader>".a:num." ".a:num."gt"
endfunc " }}}2

func! TabMap()  " {{{2
    let i = 1
    while i < 10
        call TabMapAux(i)
        let i += 1
    endwhile
endfunc " }}}2

func! MyTabLine()   " {{{2
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

func! Preserve(command)  " {{{2
    let previous_search = @/
    let previous_cursor_line = line('.')
    let previous_cursor_column = col('.')

    execute a:command

    let @/ = previous_search
    call cursor(previous_cursor_line, previous_cursor_column)
endfunc  " }}}2

func! DeleteTrailingBlank()   " {{{2
    call Preserve("%s/\\s\\+$//e")
endfunc " }}}2

func! Find(args)  " {{{2
    let g = ""
    let j = ""
    let files = "%"
    let pat = ""
    let args = split(a:args)
    if empty(a:args)
        let pat = expand("<cword>")
    elseif len(args) == 1
        let pat = args[0]
    elseif len(args) == 2
        if args[0] == '-g'
            let g = 'g'
            let pat = args[1]
        elseif args[0] == '-j'
            let j = 'j'
            let pat = args[1]
        elseif args[0] == '-gj' || args[0] == '-jg'
            let g = 'g'
            let j = 'j'
            let pat = args[1]
        else
            let pat = args[0]
            let files = args[1]
        endif
    elseif len(args) >= 3
        if args[0] == '-j'
            let j = 'j'
        elseif args[0] == '-g'
            let g = 'g'
        elseif args[0] == '-gj' || args[0] == '-jg'
            let j = 'j'
            let g = 'g'
        endif

        let pat = args[1]
        let files = join(args[2:], ' ')
    endif

    exec 'vimgrep /'.pat.'/'.g.j.' '.files
endfunction  " }}}2

func! ReadTemplate() " {{{2
    let _file_type = &ft
    if filereadable('%')
        return
    end

    let template_file = {
                \ "html": "~/.vim/template/html.html",
                \ "python": "~/.vim/template/python.py",
                \ "ruby": "~/.vim/template/ruby.rb",
                \ }

    let path = get(template_file, &ft, "")

    if path != ""
        silent exec "0read ".path
    end
endfunction " }}}2
" }}}1

" General   {{{1
" misc {{{2
filetype indent plugin on
let mapleader=','
set backspace=2
set number
set foldmethod=marker
set textwidth=79
set colorcolumn=+1
set wrap
" set linebreak
set noignorecase
set incsearch  " instance search
set wildmenu
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set showmatch
set matchtime=1
set fo+=mt
set cursorline  " heighlight current line
" set cursorcolumn
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
set wildignore=*.o,*.obj,*.exe,a.out,*.pdf,*~,*.chm,#*#,*.hi,*.error*

set bufhidden=delete
set timeoutlen=300

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
    syntax enable
    set hlsearch

    set t_Co=256  " to use molokai in terminal

    if &term != "linux" && findfile("molokai.vim", finddir("~/.vim/bundle/molokai/colors")) != ""
        colorscheme molokai

        if !has("gui_running")
            hi Normal ctermbg=none
            hi LineNr ctermbg=none
            hi NonText ctermbg=none
            hi Comment ctermfg=228
        endif

        hi ColorColumn ctermbg=238 guibg=darkgray
    else
        colorscheme desert
    endif
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
" set ambiwidth=double
set fileformat=unix
" }}}2

" indent   {{{2
filetype indent on
set cin
set autoindent
set smartindent
set smarttab
set tabstop=8  " tab length 8
set cinoptions=:0,l1,g0,(0,N-s,t0
set listchars=tab:>-,eol:†
" set listchars+=trail:⎵
" set listchars+=trail:⌷
" ⌷  †  ⍊  ⍛  ♏
" }}}2
" }}}1

" autocmd   {{{1
au VimEnter * call ChangeUnimpariedMap()

augroup ReadTemplate  " {{{2
    au!
    au BufNewFile README* if !filereadable("%") | 0read ~/.vim/template/README.md | endif
    au BufNewFile * call ReadTemplate()
augroup END " }}}2

augroup FileTypeSet  " {{{2
    au!
    au BufReadPost,BufNewFile .xmobarrc,xmobarrc setlocal filetype=haskell
    au BufReadPost,BufNewFile *.zsh* setlocal filetype=zsh
    au BufReadPost,BufNewFile *.md,*.note setlocal filetype=markdown
    au BufReadPost,BufNewFile *.conf setlocal filetype=sh
augroup END
" au BufReadPost,BufNewFile *.html set filetype=html5
" }}}2

augroup SaveEvent  " {{{2
    au!
    " auto source .vimrc when saving
    au BufWritePost .vimrc source $MYVIMRC
    " au FileType coffee au BufWritePost <buffer> :!if [ -f makefile ] || [ -f Makefile ]; then make > /dev/null; fi
    au FileType c,cpp,go,python,ruby,markdown,haskell,coffee,xml,vim,javascript
                \ au BufWritePre <buffer> call DeleteTrailingBlank()
augroup END " }}}2

augroup AutoComplete  " {{{2
    au!
    au FileType haskell setlocal omnifunc=necoghc#omnifunc
    au FileType python setlocal omnifunc=pythoncomplete#Complete
augroup END
" }}}2

augroup Compiler  " {{{2
    au!
    au FileType go compiler go
augroup END  " }}}2

if exists('auto_new_line') && auto_new_line  " {{{2
    au FileType c,cpp au BufWritePre,FileWritePre,BufUnload <buffer> call AutoNewLine()
endif " }}}2

augroup List  " {{{2
    au!
    au FileType c,cpp,python,haskell,html,markdown,coffee,vim,xml,ruby,css,go
                \,javascript,make
                \ setlocal list
augroup END  " }}}2

augroup FileTypeIndent  " {{{2
    au!
    au FileType c,cpp,python,haskell,html,markdown,coffee,vim,xml
                \ setlocal expandtab
                \ shiftwidth=4
                \ softtabstop=4

    au FileType ruby,css,javascript
                \ setlocal expandtab
                \ shiftwidth=2
                \ softtabstop=2
    au FileType go setlocal nosmarttab
augroup END  " }}}2
" }}}1

" command   {{{1
command! -nargs=1 -complete=file CreateNote :call CreateNoteFunc(<q-args>)

command! -nargs=* -complete=file Find :call Find(<q-args>)

command! -nargs=0 Todo noautocmd vimgrep /TODO\|FIXME/j * | cw
" }}}1

" plugin   {{{1
runtime! macros/matchit.vim
runtime! ftplugin/man.vim

" let g:gitgutter_enabled=0

" YCM  {{{2
let g:ycm_key_list_select_completion=["<C-N>", "<Down>"]
let g:ycm_key_list_previous_completion=['<C-P>', '<Up>']
let g:ycm_key_invoke_completion='<C-C>'
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf="~/.vim/ycm_extra_conf.py"
let g:ycm_add_preview_to_completeopt = 1
" }}}2

" tcomment  {{{2
let g:tcommentLineC = {
            \ 'commentstring': '// %s'
            \ }
" }}}2

" indent-guides   {{{2
nmap <leader>g :IndentGuidesToggle<CR>
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 0
" }}}2

" UltiSnips   {{{2
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsListSnippets="<C-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" }}}2

" haskell indent   " {{{2
let g:haskell_indent_if = 0
" }}}2

" ctrlp  {{{2
let g:ctrlp_show_hidden = 1
let g:ctrlp_tabpage_position='a'
nmap <leader>m :CtrlPMRU<CR>
nmap <leader>b :CtrlPBuffer<CR>
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

map <F3> :Dox<CR>
map <C-F3> :Doxauthor<CR>
" }}}2

" python-dict   {{{2
" url: http://www.vim.org/scripts/script.php?script_id=850
" let g:pydiction_location="/home/l/.vim/ftplugin/python_dict/complete-dict"
" let g:pydiction_menu_height=15  " default
" }}}2

" clang-complete   {{{2
" url: http://www.vim.org/scripts/script.php?script_id=3302
let g:clang_use_library=1
" let g:clang_library_path="/usr/local/lib"
" let g:clang_auto_select=1
" let g:clang_close_preview=1
" let g:clang_snippets=1
" let g:clang_user_options='-std=c++0x'
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
let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': [],
            \ 'passive_filetypes':[]
            \ }
let g:syntastic_error_symbol='x'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++0x'
let g:syntastic_cpp_auto_refresh_includes = 1
nmap <leader><leader>e :Error<CR>
nmap <leader><leader>c :SyntasticCheck<CR>
nmap <leader><leader>t :SyntasticToggleMode<CR>
" }}}2
" }}}1

" mapping   {{{1
nmap 0 ^
nmap <leader>e :call OpenVimrc()<CR>
nmap <leader>s :so $MYVIMRC<CR>
" nmap <leader>c :lcd %:p:h<CR>
nmap <leader>d :bd<CR>
nmap <C-S> <ESC>:w<CR>
nmap <leader>w <ESC>:w<CR>
vmap <C-C> "+y
"imap <c-v> <esc>"+gp
"nmap <c-v> "+gp
"vmap <c-v> "+gp
nmap <F5> :call RunPy()<CR>
nmap <C-F5> :!pep8 %<CR>
nmap <F6> :call Cfamilyformat()<cr>

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
nmap <leader>to :Todo<CR>
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
" map <C-A> to move cursor to the begin of line
cnoremap <C-A> <C-B>
cmap <C-B> <Left>
cmap <C-F> <Right>
cmap <Esc>b <S-Left>
cmap <Esc>f <S-Right>
nmap <leader>a :Ag<CR>
nmap <silent> <leader>c :cclose<CR>:pc<CR>
nmap o :tabnew<space>
nmap <c-F3> :cn<CR>
nmap <S-F3> :cp<CR>
nmap <leader>o :copen<CR>
nmap 1 <C-W>o
nmap <leader>q :qa!<CR>
" turn off <C-Space>
imap <Nul> <Space>
nmap <F7> :set spell!<CR>
nmap <F4> :A<CR>
nmap <leader><leader>a :Find<CR>
" }}}1
