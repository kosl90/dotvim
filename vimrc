" Prerequire   {{{1
" source $VIMRUNTIME/vimrc_example.vim
set nocompatible
" }}}1

let g:go_version_warning=0
" let g:Lf_ShortcutF = '<c-p>'

" TODO: remove useless plugins
" Bundles   {{{1
call plug#begin('~/.vim/bundle')

" on github   {{{2
" syntax
" Plug 'kchmck/vim-coffee-script'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'marijnh/tern_for_vim'
" Plug 'isRuslan/vim-es6'
" Plug 'othree/yajs.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'octol/vim-cpp-enhanced-highlight'

" not always used, uncomment if needed. {{{3
" Plug 'kosl90/qt-highlight-vim'
" Plug 'derekwyatt/vim-scala'
" Plug 'lambdatoast/elm.vim'
" Plug 'guns/vim-clojure-static'
" Plug 'toyamarinyon/vim-swift'
" Plug 'keith/swift.vim' " this is better so far
" Plug 'groenewege/vim-less'
" Plug 'peterhoeg/vim-qml'
Plug 'tkztmk/vim-vala'
" Plug 'rust-lang/rust.vim'
" }}}3

Plug 'posva/vim-vue'

" Plug 'klen/python-mode'

" maybe someone will be deleted
Plug 'vim-scripts/gtk-vim-syntax'
" Bundle 'vim-scripts/gtk-mode'

" language tools
Plug 'tpope/vim-speeddating'
Plug 'kien/rainbow_parentheses.vim'
Plug 'jceb/vim-hier'
" Plug 'scrooloose/syntastic'
" Plug 'w0rp/ale'
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
Plug 'fatih/vim-go'

Plug 'mattn/emmet-vim'
Plug 'kosl90/pyflakes-vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'tomtom/tcomment_vim'

" Plug 'xuhdev/SingleCompile'
" Plug 'skammer/vim-css-color'
" Plug 'Rip-Rip/clang_complete'

" TODO: haskell-vim-now {{{3
" Plug 'zenzike/vim-haskell-unicode'
" Plug 'Phlogistique/unicode-haskell'
" Plug 'Twinside/vim-syntax-haskell-cabal'
" Plug 'ujihisa/neco-ghc'
" Plug 'eagletmt/ghcmod-vim'
" Plug 'bitc/vim-hdevtools'

" Haskell
"Plug 'raichoo/haskell-vim'
" Plug 'enomsg/vim-haskellConcealPlus'
"Plug 'Twinside/vim-hoogle'
" }}}3

" textobj family {{{3
" Plug 'kana/vim-textobj-user'
" Plug 'kana/vim-textobj-indent'
" Plug 'kana/vim-textobj-syntax'
" Plug 'kana/vim-textobj-function', { 'for': ['c', 'cpp', 'vim', 'java'] }
" Plug 'sgur/vim-textobj-parameter'
" }}}3

Plug 'tpope/vim-projectionist'

" theme
Plug 'tomasr/molokai'

" Bars, panels, and files
Plug 'bling/vim-airline'

" tools
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/nerdtree'
" Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'

Plug 'rking/ag.vim'
" Plug 'mileszs/ack.vim'

" Plug 'AndrewRadev/splitjoin.vim'
Plug 'majutsushi/tagbar'

" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/LargeFile'

" Plug 'Shougo/vimproc.vim'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'jeaye/color_coded'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Yggdroot/LeaderF'

" }}}2

" TODO: clean bundles {{{3
" Plug 'JessicaKMcIntosh/TagmaTasks'
" Plug 'jgdavey/tslime.vim'
Plug 'ervandew/supertab'
" Plug 'moll/vim-bbye'
" Plug 'vim-scripts/gitignore'

" Git
" Plug 'int3/vim-extradite'

" Text manipulation
" Plug 'vim-scripts/Align'
" Plug 'vim-scripts/Gundo'
" Plug 'tpope/vim-commentary'
" Plug 'godlygeek/tabular'
" Plug 'michaeljsmith/vim-indent-object'

" Allow pane movement to jump out of vim into tmux
" Plug 'christoomey/vim-tmux-navigator'
" }}}3

" on vim-scripts   {{{2
" Plug 'DoxygenToolkit.vim'
" Plug 'DrawIt'
" Plug 'conque'
" }}}2

" slowly download plugins  {{{2
" Plug 'szw/vim-ctrlspace'
Plug 'Valloric/YouCompleteMe'
" }}}2

call plug#end()
" }}}1


if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
else
    let g:os = substitute(system('uname'), '\n', '', '')
endif

if g:os == 'Darwin'
    let transparentBg = 0
else
    let transparentBg = 1
endif

" TODO: clean useless functions
" Functions {{{1
func! ChangeUnimpariedMap()   " {{{2
    if &loadplugins == 1
        " unmap [b
        " unmap ]b
        nmap [t :tabprevious<CR>
        nmap ]t :tabnext<CR>
        nmap [T :tabfirst<CR>
        nmap ]T :tablast<CR>
    endif
endfunc  " }}}2

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
    let half_lines = win_line_nu/2+1

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
    " TODO: check whether $MYVIMRC exist from buffers
    if getline(nextnonblank(1)) == ""
        e $MYVIMRC
    else
        vsp $MYVIMRC
    endif
endfunc " }}}2

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

func! s:goComplete(ArgLead, CmdLine, CursorPos) "{{{2
    let s:goos = $GOOS
    let s:goarch = $GOARCH

    if len(s:goos) == 0
        if exists('g:golang_goos')
            let s:goos = g:golang_goos
        elseif has('win32') || has('win64')
            let s:goos = 'windows'
        elseif has('macunix')
            let s:goos = 'darwin'
        else
            let s:goos = '*'
        endif
    endif

    if len(s:goarch) == 0
        if exists('g:golang_goarch')
            let s:goarch = g:golang_goarch
        else
            let s:goarch = '*'
        endif
    endif

    let dirs = go#package#Paths()

    if len(dirs) == 0
        " should not happen
        return []
    endif

    let ret = {}
    for dir in dirs
        " this may expand to multiple lines
        let root = split(expand(dir . '/pkg/' . s:goos . '_' . s:goarch), "\n")
        call add(root, expand(dir . '/src'))
        for r in root
            for i in split(globpath(r, a:ArgLead.'*'), "\n")
                if isdirectory(i)
                    let i .= '/'
                elseif i !~ '\.a$'
                    continue
                endif
                let i = substitute(substitute(i[len(r)+1:], '[\\]', '/', 'g'),
                                  \ '\.a$', '', 'g')
                let ret[i] = i
            endfor
        endfor
    endfor
    return sort(keys(ret))
endfunction "}}}2

" {{{2
func! s:RemoveTrailComma()
    exec ':%s/,\(\n\r\?.*[}\])]\)/\1/'
endfunction
" }}}2

" }}}1

" General   {{{1
" misc {{{2
filetype indent plugin on
" set iskeyword=@,48-57,192-255
let mapleader=','
set backspace=2
set number
set foldmethod=marker
" set textwidth=79
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
set path=.,./*/*,../include,/usr/include/,/usr/include/*,/usr/local/include,/usr/include/c++/*/*
set wildignore=*.o,*.obj,*.exe,a.out,*.pdf,*~,*.chm,#*#,*.hi,*.error*

set hidden
set bufhidden=delete
set timeoutlen=300
set cb=unnamedplus,autoselect,exclude:cons\|linux

let auto_new_line = 0
" }}}2

if has("win32")   " {{{2
    set shellslash
    "set guifont=DejaVu_Sans_Mono:h12
    set guifont=Consolas:h12
    set vb t_vb=\".  " stop beep
    set iskeyword=@,48-57,128-167,224-235
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

    if &term != "linux" && finddir("molokai", expand("~/.vim/bundle/")) != ""
        colorscheme molokai

        if !has("gui_running") && transparentBg == 1
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

" FIXME: this code is buggy
" {{{2 termguicolors for true color
if has("termguicolors")
"    echo "use true color"
    " fix bug for vim
"    set t_8f=^[[38;2%lu;%lu;%lum
"    set t_8b=^[48;2;%lu;%lu;%lum

    " enable true coloe
"    set termguicolors
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
" set tabline=%!MyTabLine()  " custom tab pages line
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
set cinoptions=:0,l1,g0,(0,W4,j1,m1,N-s,t0,f0
set listchars=tab:>-,eol:†
" set listchars+=trail:⎵
" set listchars+=trail:⌷
" ⌷  †  ⍊  ⍛  ♏
" }}}2
" }}}1

" autocmd   {{{1
au VimEnter * call ChangeUnimpariedMap()

au FileType gitcommit setlocal textwidth=80

augroup ReadTemplate  " {{{2
    au!
    au BufNewFile README* if !filereadable("%") | 0read ~/.vim/template/README.md | endif
    au BufNewFile * call ReadTemplate()
augroup END " }}}2

augroup FileTypeSet  " {{{2
    au!
    au BufReadPost,BufNewFile vim.bundles,vim.bundles.local,vim.local setlocal filetype=vim
    au BufReadPost,BufNewFile .vim.bundles,.vim.bundles.local,.vim.local setlocal filetype=vim
    au BufReadPost,BufNewFile .xmobarrc,xmobarrc setlocal filetype=haskell
    au BufReadPost,BufNewFile *.zsh* setlocal filetype=zsh
    au BufReadPost,BufNewFile *.md,*.note setlocal filetype=markdown
    au BufReadPost,BufNewFile *.conf setlocal filetype=sh
    au BufReadPost,BufNewFile Sconstruct setlocal filetype=python
    " au BufReadPost,BufNewFile *.html set filetype=html5
augroup END
" }}}2

augroup SaveEvent  " {{{2
    au!
    " auto source .vimrc when saving
    au BufWritePost vimrc,.vimrc,.vimrc.local,vimrc.local,.vim.bundles,vim.bundles,.vim.bundles.local,vim.bundles.local source $MYVIMRC
    " au FileType coffee au BufWritePost <buffer> :!if [ -f makefile ] || [ -f Makefile ]; then make > /dev/null; fi
    " au FileType c,cpp,python,ruby,markdown,haskell,coffee,xml,vim,javascript
    "             \ au BufWritePre <buffer> call DeleteTrailingBlank()
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

augroup ListChars  " {{{2
    au!
    au FileType c,cpp,python,haskell,html,markdown,coffee,vim,xml,ruby,css,go
                \,javascript,make,sh,zsh,cmake,elm,qml
                \ setlocal list
augroup END  " }}}2

augroup FileTypeIndent  " {{{2
    au!
    au FileType c,cpp,python,haskell,markdown,coffee,vim,xml,sh,zsh,objc
                \,cmake,elm,qml,vala
                \ setlocal expandtab
                \ shiftwidth=4
                \ softtabstop=4

    au FileType ruby,css,javascript,html,html5,eruby,scss,sass,yaml
                \ setlocal expandtab
                \ shiftwidth=2
                \ softtabstop=2
    au FileType go setlocal nosmarttab
augroup END  " }}}2
" }}}1

" command   {{{1
command! -nargs=1 -complete=file CreateNote call CreateNoteFunc(<q-args>)

command! -nargs=* -complete=file Find call Find(<q-args>)

command! -nargs=0 Todo noautocmd vimgrep /TODO\|FIXME/j * | cw

command! -nargs=0 Imports call go#fmt#Format(1)
command! -nargs=1 -complete=customlist,go#package#Complete Import call go#import#SwitchImport(1, '', <f-args>, '<bang>')
command! -nargs=* -complete=customlist,s:goComplete ImportAs call go#import#SwitchImport(1, <f-args>, '<bang>')
" }}}1

" plugin   {{{1
runtime! macros/matchit.vim
runtime! ftplugin/man.vim

" let g:gitgutter_enabled=0
let g:gitgutter_max_signs = 10000

" vim-go{{{2
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_structs=1
let g:go_highlight_build_constraints=1
" let g:go_fmt_command = "goimports"
" let g:syntasitc_go_checkers=['golint', 'govet', 'errcheck']
" }}}2

" Rainbow Parenthese {{{2
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
if finddir("rainbow_parentheses.vim", expand("~/.vim/bundle")) != ""
    if &loadplugins == 1
        augroup RBPT
            au!
            au VimEnter * RainbowParenthesesToggle
            au Syntax * RainbowParenthesesLoadRound
            au Syntax * RainbowParenthesesLoadSquare
            au Syntax * RainbowParenthesesLoadBraces
        augroup END
    endif
endif
" }}}2

" YCM  {{{2
let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 2
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_key_list_select_completion=["<C-N>", "<Down>"]
let g:ycm_key_list_previous_completion=['<C-P>', '<Up>']
let g:ycm_key_invoke_completion='<C-y>'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_complete_in_comments = 1
let g:ycm_global_ycm_extra_conf = '~/.dotfiles/ycm_extra_conf.py'
let g:ycm_comfirm_extra_conf=0
" let g:ycm_server_log_level='debug'
" let g:ycm_server_keep_logfiles = 1
" }}}2

" tcomment  {{{2
" let g:tcommentLineC_fmt = {
"             \ 'commentstring': '// %s'
"             \ }
" let g:tcommentInlineC = {
"             \'commentstring': '// %s'
"             \}
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
" let g:haskell_indent_if = 0
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

" map <F3> :Dox<CR>
map <C-F3> :Doxauthor<CR>
" }}}2

" python-dict   {{{2
" url: http://www.vim.org/scripts/script.php?script_id=850
" let g:pydiction_location="/home/l/.vim/ftplugin/python_dict/complete-dict"
" let g:pydiction_menu_height=15  " default
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
nnoremap ^ g0
nnoremap 0 g^
nnoremap g^ 0
nnoremap g0 ^

nnoremap gj j
nnoremap gk k
nnoremap j gj
nnoremap k gk

nmap <leader>rc :call OpenVimrc()<CR>
nmap <leader>r :so $MYVIMRC<CR>
" nmap <leader>c :lcd %:p:h<CR>
nmap <leader>d :bd<CR>
nmap <C-S> <ESC>:w<CR>
nmap <leader>w <ESC>:w<CR>
nmap <F6> :call Cfamilyformat()<cr>

nmap <F8> :%s///g
nmap <C-N><C-H> :nohls<CR>
" nmap <f2> :helptags ~/.vim/doc<cr>
nmap gl $
nmap <leader>i :call Insertdomain()<CR>
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>t :TagbarToggle<CR>
nmap <leader>to :Todo<CR>

" to avoid popup menu in ubuntu
imap <F10> <NOP>
nmap <F10> <NOP>
imap <C-L> <C-O>:call Emacs_ctrl_l()<CR>
nmap <C-L> :call Emacs_ctrl_l()<CR>
nnoremap <leader>l <C-L>
nmap <C-H> :h<space>
nmap <leader>ec :set fileencoding=utf8
" map <C-A> to move cursor to the begin of line
cmap <C-D> <Del>
" TODO: TBD
cnoremap <C-\> <C-D>
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
nmap <leader><leader>a :Find<CR>
"map <F11> :!find -name '*.h' -o -name '*.c' \| ctags -R --c++-kinds=+px --fields=+iaS --extra=+q -L<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" }}}1

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
