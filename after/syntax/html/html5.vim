" runtime! syntax/html.vim
" unlet b:current_syntax

" section
syn keyword htmlTagName contained section nav article aside header footer main

" grouping content
syn keyword htmlTagName contained figure figcaption

" text-level semantics
syn keyword htmlTagName contained data time mark ruby rt rp bdi wbr

" embedded content
syn keyword htmlTagName contained embed video audio source track canvas svg math

" forms
syn keyword htmlTagName contained datalist keygen output progress meter

" interactive elements
syn keyword htmlTagName contained details summary menuitem menu

" let b:current_syntax = "html5"
