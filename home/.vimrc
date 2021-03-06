"------------------------------
" auto reload
"------------------------------
autocmd!
augroup AutoReload
    autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd AutoReload BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd AutoReload BufWritePost $MYVIMRC source $MYVIMRC | \if has('gui_running') | source $MYGVIMRC  
    autocmd AutoReload BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif

"------------------------------
" options
"------------------------------
" no compatible
set nocompatible

" indent
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab

" search
set ignorecase
set smartcase
set wrapscan
set noincsearch
set hlsearch

" fold
set foldmethod=marker

" modeline
set modeline
set modelines=5

" clipboard
set clipboard+=unnamed

" move
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start

" display
set number
set showmatch
"set list
"set listchars=eol:$,tab:>\ ,extends:<

"------------------------------
" key map
"------------------------------
"基本的にカンマ+1文字でカテゴリわけるルール
"google testとしてcppのときには\tにマッピングするようにしちゃえばよさげ
nnoremap <silent> ,x   :QuickRun cpp-procon<CR>
nnoremap <silent> ,nes  :sp +NeoSnippetEdit<CR>
nnoremap <silent> ,ners :sp +NeoSnippetEdit-runtime<CR>
nnoremap <silent> ,ncb  :NeoComplCacheCachingBuffer<CR>
nnoremap <silent> ,uu  :Unite<Space>buffer<Space>file_mru<Space>directory_mru<Space>file<CR>
nnoremap <silent> ,ua  :Unite<Space>file_rec<CR>
nnoremap <silent> ,uf  :Unite<Space>file<CR>
nnoremap <silent> ,ub  :Unite<Space>buffer<CR>
nnoremap <silent> ,ut  :Unite<Space>tab<CR>
nnoremap <silent> ,ur  :Unite<Space>register<CR>
nnoremap <silent> ,tt  :TagbarToggle<CR>
nnoremap <silent> ,ff  :VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
nnoremap <silent> ,f2  :VimFilerDouble<CR>
nnoremap <silent> ,ss  :SaveSession<CR>
nnoremap <silent> ,sr  :RestoreSession<CR>
nnoremap <silent> ,rc  :tabnew<Space>$MYVIMRC<CR>
nnoremap <silent> ,grc :tabnew<Space>$MYGVIMRC<CR>
nnoremap <silent> ,lrc :tabnew<Space>~/.vimrc.local<CR>
nnoremap <silent> ,rr  :!sudo /etc/init.d/httpd restart<CR>
nnoremap <silent> ,dd  :VDBIDatasource<CR>

nmap     <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap <silent> <C-h> 5h
nnoremap <silent> <C-j> 5j
nnoremap <silent> <C-k> 5k
nnoremap <silent> <C-l> 5l
inoremap <C-a> <Home>
inoremap <C-e> <End>

"------------------------------
" grep
"------------------------------
set grepprg=grep\ -nH

"------------------------------
" session
"------------------------------
function! s:restore_session()
    source Session.vim
endfunction

"plugin開いてると復元時にエラーが出るのでとりあえずよく使うものを閉じる
"けど他タブとかで開いてると結局。。。
function! s:save_session_with_close_plugins()
    execute 'TagbarClose'
    execute 'VimFilerClose explorer'
    execute 'UniteClose default'
    mksession! Session.vim
endfunction 

command! RestoreSession call s:restore_session()
command! SaveSession    call s:save_session_with_close_plugins()

"完全自動保存にすると何かとじゃまだったりする
"augroup AutoSessionManagement
"  autocmd!
"  autocmd VimEnter * nested execute 'RestoreSession'
"  autocmd VimLeave * execute 'SaveSession'
"augroup END


"------------------------------
" xls as csv (csv.vim, xls2csv, xlscat is required)
"------------------------------
" xlscat不要にしたい
augroup XlsAsCsv
    autocmd!
    autocmd BufReadPre *.xls set ro | setf csv
    autocmd BufReadPost *.xls silent! %!xlscat "%"
    autocmd BufReadPost *.xls %ArrangeColumn
    autocmd BufReadPost *.xls redraw
augroup END


"------------------------------
" character code
" quoted from
" http://www.kawaz.jp/pukiwiki/?vim
"------------------------------
"""""""""""""""""""""この辺の設定をちゃんとやる


"------------------------------
" neobundle
"------------------------------
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
NeoBundle 'git://github.com/vim-scripts/surround.vim.git'
NeoBundle 'git://github.com/vim-jp/vimdoc-ja.git'
NeoBundle 'git://github.com/Shougo/neocomplcache-clang.git'
"NeoBundle 'git://github.com/Shougo/echodoc.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neosnippet.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
"NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
"NeoBundle 'git://github.com/Shougo/vim-vcs.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
"NeoBundle 'git://github.com/Shougo/vinarise.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/tyru/open-browser.vim.git'
NeoBundle 'git://github.com/mattn/zencoding-vim.git'
NeoBundle 'git://github.com/thinca/vim-qfreplace.git'
NeoBundle 'git://github.com/mattn/webapi-vim.git'
NeoBundle 'thinca/vim-ref'

" js
"NeoBundle 'git://github.com/soh335/vim-ref-jquery.git'
"NeoBundle 'git://github.com/hallettj/jslint.vim.git'
" jshint must be installed
NeoBundle 'git://github.com/walm/jshint.vim.git'
NeoBundle 'git://github.com/pangloss/vim-javascript.git'
NeoBundle  'JavaScript-syntax'

" perl
" perlomni does not need to make install ?
"NeoBundle 'git://github.com/c9s/perlomni.vim.git'

" scala
" original scala tool is git://github.com/scala/scala-dist.git
NeoBundle 'git://github.com/marcw/vim-scala.git'

" csv
NeoBundle 'git://github.com/vim-scripts/csv.vim.git'

" dbi
" webapi-vim required
" perl Plack required
NeoBundle 'git://github.com/mattn/vdbi-vim.git'

" vimproc need to make
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'

"NeoBundle 'thinca/vim-ambicmd'
"NeoBundle 'anyakichi/vim-surround'
"NeoBundle 'h1mesuke/unite-outline'
"NeoBundle 'kana/vim-textobj-user'
"NeoBundle 'kana/vim-textobj-indent'
"NeoBundle 'kana/vim-smartword'
"NeoBundle 'kana/vim-smartchr'
"NeoBundle 'ujihisa/vital.vim'
"NeoBundle 'tsukkee/lingr-vim'
"NeoBundle 'tpope/vim-pathogen'
"NeoBundle 'bkad/CamelCaseMotion'
"
"
"sonictemplete-vim
"CtrlP.vim
"migemo
"memolist.vim
"
"NeoBundle 'https://github.com/thinca/vim-tabrecent.git'
"NeoBundle 'https://github.com/mrtazz/simplenote.vim.git'
"オンラインノートsimplenoteを使う
"NeoBundle 'https://github.com/tacroe/unite-mark.git'
"マーク一覧を表示
"NeoBundle 'https://github.com/tpope/vim-speeddating.git'
"NeoBundle 'https://github.com/ujihisa/mdv.git'
"VimHacksで使われている拡張Markdown
"NeoBundle 'https://github.com/ujihisa/neco-look.git'
"NeoBundle 'https://github.com/mattn/wwwrenderer-vim.git'
"NeoBundle 'https://github.com/t9md/vim-textmanip.git'

"NeoBundle 'project.tar.gz'
NeoBundle 'Colour-Sampler-Pack'
"NeoBundle 'taglist.vim'
NeoBundle 'git://github.com/majutsushi/tagbar.git'

" Unite
NeoBundle 'git://github.com/ujihisa/unite-colorscheme.git'

syntax on
filetype plugin indent on

" colorscheme
colorscheme oceanblack

"""""""""""""""""""""この辺の設定をちゃんとやる
"------------------------------
" status line
"------------------------------
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"set statusline=[%n]%1*%m%*%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%<%{fnamemodify(getcwd(),':~')}]%-8([%{GetB()}]%)\ %-11(%l,%c%V%)\ %4P
augroup InsertHook
    autocmd!
    "autocmd BufEnter highlight StatusLine term=NONE cterm=NONE guifg=#2E4340 guibg=#ccdc90 ctermfg=white ctermbg=blue
    autocmd InsertEnter * highlight StatusLine term=NONE cterm=NONE guifg=#ccdc90 guibg=#2E4340 ctermfg=black ctermbg=yellow
    autocmd InsertLeave * highlight StatusLine term=NONE cterm=NONE guifg=#2E4340 guibg=#ccdc90 ctermfg=white ctermbg=blue
augroup END

"------------------------------
" popup
"------------------------------
highlight Pmenu guibg=#666666 ctermbg=blue
highlight PmenuSel guibg=#8cd0d3 guifg=#666666 ctermbg=red
highlight PmenuSbar guibg=#8cd0d3 guifg=#666666 ctermbg=black


"------------------------------
" language
"------------------------------
set helplang=en

"------------------------------
" neocomplcache
"------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.cpp =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'


"------------------------------
" neosnippet
"------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'

"------------------------------
" clang_complete
"------------------------------
"let g:neocomplcache_clang_use_library = 1

"------------------------------
" quickrun
"------------------------------
let g:quickrun_config = {}
" cpp-procon
let g:quickrun_config['cpp-procon'] = {
\   'type': 'cpp',
\   'command': 'g++',
\   'cmdopt': '-lgtest',
\}

"------------------------------
" openbrowser
"------------------------------
nmap <Leader>w <Plug>(openbrowser-smart-search)
vmap <Leader>w <Plug>(openbrowser-smart-search)


"""""""""""""""""""""この辺の設定をちゃんとやる
"------------------------------
" project.vim
"------------------------------
"function! :openproject()
"    if getcwd() != $HOME
"        if filereadable(getcwd() . '/.vimprojects')
"            Project .vimprojects
"        endif
"    endif
"endfunction
"autocmd BufRead * openproject

"------------------------------
" unite.vim
"------------------------------
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_limit = 500
call unite#custom_source('file_rec', 'max_candidates', 0)
call unite#custom_source('file_rec', 'filters', ['matcher_fuzzy', 'sorter_default', 'converter_default'])

"------------------------------
" load local setting
"------------------------------
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

"------------------------------
" 入れたいもの 
"------------------------------
" バッファ一覧表示、管理
" クリップボード共有
" 文字コード
" manga_osyoさんの記事を参考にしてソースコード上にシンタックスチェックを表示
" eregex
" yankring
" Pyclewn?
" irc
" API
" twitter

