"==================================================
"   settings/mappings 
"==================================================
" +++ minimal {{{
syntax on
filetype plugin on    " enable ftplugin scripts
filetype indent on    " enable filetype specific indent scripts

nnoremap ; :
nnoremap <leader>w  :w<CR>
nnoremap <leader>g  :e#<CR>
""nnoremap <silent> <Leader>ev  :e ~/.vimrc<CR>
"nnoremap <silent> <leader>sv  :so ~/.vimrc<CR>
"make vim save and load the folding of the document each time it loads"
"""also places the cursor in the last place that it was left.""
""
noremap <silent><F5> :set paste!<CR>
noremap <silent><F8> :TagbarToggle<CR>

set nocompatible      " be iMproved
set hidden            " hidden buffer: allow swiching without saving
set mouse=n           " enable mouse

" tab/indent, filetype specific settings at .vim/indent/
set tabstop=2         " display tab as 2 spaces
set softtabstop=2     " insert tab as 2 spaces
set shiftwidth=2      " set each indent level as 2 spaces
set smarttab          " <BS> delete spaces according to shiftwidth
set expandtab         " expand tab to real spaces

" enable folding automatically
set foldenable
set foldmethod=marker
set foldopen-=block   " jump to next paragraph w/o opening folds
set foldlevel=0		    " un/open top level folds

" search settings
set incsearch         " find the next match as we type
set hlsearch          " Highlight search
set viminfo^=h        " Start with no highlighting
set ignorecase        " ignore case in search
set smartcase        

" enable Tab completion in command mode
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.obj,*~ 
set wildignore+=*.so,*.swp,*.zip
set wildignore+=*/node_modules/*,*/tmp/*,*/errors/*
"}}}
" +++ more tweakings {{{ 
set ttyfast

" fix <BS> problems 
" On some systems, <BS> does not delete linebreaks,
" auto-inserted indentations or place where insert mode started.
set backspace=2       

" No text wrapping in display
" scrolling behaviour if cursor moves out of screen
set nowrap            
set scroll=5          
set sidescrolloff=5   

set number
set relativenumber

" automatical wrapping
set fo=crqnj1o        " read manual fo-table

" toggle folding with <space>
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" *** window / buffer switching {{{
" <leader><number> is mapped to open buffer <number>
" if buffer is open in a window, switch to that window
set switchbuf+=useopen
let i = 1
while i <= 9
  execute 'nnoremap <silent><leader>'.i.' :sbuffer '.i.'<CR>'
  let i = i + 1
endwhile

" window split directions
set splitright        " new window opens right when vsplit
set splitbelow        " new window opens below when split

" maximize the new horizontally split window
set wmh=0
set wh=999

" jump to downward with C-J
" jump to upward with C-K
" jump to last window with C-O
nnoremap <C-J> <C-W><C-W><C-W>_
inoremap <C-J> <C-O><C-W><C-W><C-O><C-W>_
nnoremap <C-K> <C-W>W<C-W>_
inoremap <C-K> <C-O><C-W>W<C-O><C-W>_
"nnoremap <C-O> <C-W><C-P><C-W>_
"inoremap <C-O> <C-O><C-W><C-P><C-O><C-W>_

" delete buffer w/o changing window layout
nnoremap <Leader>q :bd<CR>

"nnoremap <Leader>b :ls!<CR>
"
"}}}
" *** Status Line {{{
  set laststatus=2                             " always show statusbar  
  set statusline=  
  set statusline+=%-8n\                        " buffer number  
  set statusline+=%F\                          " filename   
  set statusline+=%h%m%r%w                     " status flags  
  set statusline+=%{HasPaste()}\               " paste mode
  set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
  set statusline+=%=                           " right align remainder  
  set statusline+=CWD:\ %{getcwd()}\           " working directory
  set statusline+=0x%-8B                       " character value  
  set statusline+=%-14(%l,%c%V%)               " line, character  
  set statusline+=%<%P                         " file position  
"}}}
" *** Paragraph jump using { / } {{{
" jump forward/backward to the begining of next paragraph 
  set whichwrap+=b,s
  nnoremap { k{<Space>0
  vnoremap { k{<Space>0
  nnoremap } j}<BS>
  vnoremap } j}<BS> 
" }}}
" *** remember last edit position {{{
"make vim save and load the folding of the document each time it loads"
"""also places the cursor in the last place that it was left.""
if has("autocmd")
  "make vim save and load the folding of the document each time it loads"
  """also places the cursor in the last place that it was left."
  au BufWinLeave *.* mkview
  au BufWinEnter *.* silent loadview

"  au BufReadPost * 
"        \ if line("'\"") > 1 && line("'\"") <= line("$") 
"        \ | exe "normal! g'\"" | endif
endif
"}}}

" delete/change word in the middle of the word
"inoremap <C-BS> <C-O>b<C-O>dw
"noremap <C-BS> diw
"nnoremap <expr>dw <SID>check_cursor_space() ? "dw" : "daw"
"nnoremap cw caw
"
" }}}
" +++ color {{{
" enable rich colors in console
if !has('gui_running')
	set t_Co=256
endif

" color scheme retouch
autocmd ColorScheme * highlight Pmenu ctermbg=brown
autocmd ColorScheme * highlight PmenuSel ctermfg=25 ctermbg=3
autocmd ColorScheme * highlight LineNr ctermfg=236

"has to be put at the end of file, in order to make above autocmds work
colorscheme molokai
"}}}
" +++ functions {{{
function! HasPaste() "{{{
  if &paste
    "return 'PASTE MODE  '
    return '[Paste]'
  en
    return ''
endfunction 
"}}}
function! s:check_cursor_space() "{{{
    let col = col('.')
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction 
"}}}
"}}}
"
"==================================================
"   Plugins Management 
"==================================================
" +++ Plugin Management [neobundle] {{{
filetype off
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'jiangmiao/auto-pairs'

NeoBundle 'Shougo/vimproc.vim', { 
      \ 'build' : {
      \     'mac' : 'make',
      \     'linux' : 'make',
      \    },
      \ } 
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'tsukkee/unite-tag'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neopairs.vim'
NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'Shougo/neco-vim'
NeoBundle 'Shougo/neco-syntax'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neomru.vim'

NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'chrismccord/bclose.vim'
NeoBundle 'tpope/vim-commentary'  " comments
NeoBundle 'majutsushi/tagbar'

call neobundle#end()
filetype plugin indent on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"}}}
"
"==================================================
"   Plugin Configs
"==================================================
if neobundle#tap('neocomplete.vim') "{{{
  let g:neocomplete#enable_at_startup = 1
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#enable_auto_pairs = 1
    let g:neocomplete#enable_fuzzy_completion = 0
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    let g:neocomplete#max_list = 20

    let g:neocomplete#sources = {}
    let g:neocomplete#sources._ = ['file', 'omni', 'buffer', 'syntax', 'directory']
    let g:neocomplete#sources.vim = g:neocomplete#sources._ + ['vim']

    inoremap <expr><C-g> neocomplete#undo_completion()

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  endfunction
  call neobundle#untap()
endif "}}}
if neobundle#tap('auto-pairs') " {{{
  let g:AutoPairsMapBS=0
  call neobundle#untap()
endif "}}}
if neobundle#tap('ctrlp.vim') "{{{
  let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
  let g:ctrlp_match_window = 'bottom'
  let g:ctrlp_extensions = ['buffertag', 'dir']
  let g:ctrlp_cmd = 'call CallCtrlP()'

  nnoremap <Leader>f :CtrlPMRU<CR>
  nnoremap <Leader>t :CtrlPBufTag<CR>
  nnoremap <C-P> <C-W>J:CtrlP<CR>

  func! CallCtrlP()
    if exists('s:called_ctrlp')
      CtrlPLastMode
    else
      let s:called_ctrlp = 1
      CtrlP
    endif
  endfunc  

  call neobundle#untap()
endif "}}}
" *** plugin/neosnippet {{{
imap <C-I>     <Plug>(neosnippet_expand_or_jump)
smap <C-I>     <Plug>(neosnippet_expand_or_jump)
xmap <C-I>     <Plug>(neosnippet_expand_target)
" }}}
" *** remapping <TAB>,<CR>,<BS>{{{
" for neocomplete functioning better
if neobundle#is_installed('neocomplete.vim') &&
      \ neobundle#is_installed('auto-pairs') 
  inoremap  <expr> <BS> pumvisible() ?
        \ neocomplete#smart_close_popup()."\<C-h>" :
        \ AutoPairsDelete()
endif

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

imap <expr><TAB> pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \ neosnippet#mappings#jump_or_expand_impl() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ neocomplete#start_manual_complete()
function! s:check_back_space()
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction 
"}}}
" *** plugin/Unite {{{
" Like ctrlp.vim settings.
"call unite#custom#profile('default', 'context', { 
"\   'start_insert': 0,
"\   'vertical': 1,
"\   'winwidth': 70,
"\   'direction': 'topleft',
"\   'prompt': '>>',
"\ })
"let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
"nnoremap <leader>f :<C-u>Unite -buffer-name=files  -start-insert file<cr>
"nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
"nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
"nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
"nnoremap <leader>e :<C-u>Unite -buffer-name=buffer  buffer<cr>
"
"" Custom mappings for the unite buffer
"autocmd FileType unite call s:unite_settings()
"function! s:unite_settings()
"  " Play nice with supertab
"  let b:SuperTabDisabled=1
"  " Enable navigation with control-j and control-k in insert mode
"  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
"  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
"endfunction

" }}}

"==================================================
"   Cheet Sheets
"==================================================
"{{{ >>> Vim folding commands
"	 ---------------------------------
"	 zf#j creates a fold from the cursor down # lines.
"	 zf/ string creates a fold from the cursor to string .
"	 zj moves the cursor to the next fold.
"	 zk moves the cursor to the previous fold.
"	 za toggle a fold at the cursor.
"	 zo opens a fold at the cursor.
"	 zO opens all folds at the cursor.
"	 zc closes a fold under cursor. 
"	 zm increases the foldlevel by one.
"	 zM closes all open folds.
"	 zr decreases the foldlevel by one.
"	 zR decreases the foldlevel to zero -- all folds will be open.
"	 zd deletes the fold at the cursor.
"	 zE deletes all folds.
"	 [z move to start of open fold.
"	 ]z move to end of open fold.
"}}}
"

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2
