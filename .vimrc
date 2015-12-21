"+++ basic settings/mappings {{{ 
filetype plugin on    " enable ftplugin scripts
filetype indent on    " enable filetype specific indent scripts
syntax on

nnoremap <leader>w  :w<CR>
nnoremap <leader>g  :e#<CR>
nnoremap <leader>v  :so ~/.vimrc<CR>

set pastetoggle=<F5>
nmap <silent><F8> :TagbarToggle<CR>
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>
"}}}
"
"+++ basic costumizations {{{ +++ tab/indent, search, wildmenu, fold and etc.
set nocompatible      " be iMproved
set mouse=n           " enable mouse
set ttyfast
set fo=crqnj1o        " read manual fo-table
set hidden            " allow swiching buffer without saving
set backspace=2       " fix <BS> problems
                      " On some systems, <BS> does not delete linebreaks,
                      " auto-inserted indentations or place where insert mode
                      " started.
set nowrap            " Disable automatic text wrapping in display, horizontal
set scroll=5          " scroll if  cursor moves out of screen
set sidescrolloff=5   " 

" tab/indent, filetype specific settings at .vim/indent/
set tabstop=2         " display tab as 2 spaces
set softtabstop=2     " insert tab as 2 spaces
set shiftwidth=2      " set each indent level as 2 spaces
set smarttab          " <BS> delete spaces according to shiftwidth
set expandtab         " expand tab to real spaces

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

" enable folding automatically
set foldenable
set foldmethod=marker
set foldopen-=block   " jump to next paragraph w/o opening folds
set foldlevel=0		    " un/open top level folds
"}}}
"
" +++ tweakings {{{
set relativenumber
set number

" *** window / buffer switching {{{
" <leader><number> is mapped to open buffer <number>
" if buffer is open in a window, switch to that window
set switchbuf+=useopen
let i = 1
while i <= 9
  execute 'nnoremap <silent><leader>'.i.' :sbuffer '.i.'<CR>'
  let i = i + 1
endwhile

nnoremap <Leader>b :ls!<CR>

" split window horizontally, and maximize
" jump to next window with C-J
" jump backward with C-K
set wmh=0
set wh=999
map <C-J> <C-W><C-W><C-W>_
map <C-K> <C-W>W<C-W>_

" delete buffer w/o changing window layout
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>e :Bclose<CR>

" window split directions
set splitright        " new window opens right when vsplit
"set splitbelow        " new window opens below when split
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
" *** Paragraph jump {{{
" use {/} jump forward/backward to the begining of next paragraph 
set whichwrap+=b,s
nnoremap { k{<Space>0
vnoremap { k{<Space>0
nnoremap } j}<BS>
vnoremap } j}<BS> "}}}
" *** remember last edit position {{{
if has("autocmd")
  au BufReadPost * 
        \ if line("'\"") > 1 && line("'\"") <= line("$") 
        \ | exe "normal! g'\"" | endif
endif
"}}}
" *** remapping <TAB>,<CR>,<BS>{{{
" for neocomplete functioning better
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

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

" toggle folding with <space>
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" delete/change word in the middle of the word
inoremap <C-BS> <C-O>b<C-O>dw
noremap <C-BS> diw
"nnoremap <expr>dw <SID>check_cursor_space() ? "dw" : "daw"
"nnoremap cw caw
"
" }}}
"
" *** Plugin/neocomplete {{{
" settings must be put before neocomplete is initialed to take effects
function! s:neocomplete_init() "{{{
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_fuzzy_completion = 1
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  "let g:neocomplete#max_list = 20

  let g:neocomplete#sources = {}
  let g:neocomplete#sources._ = ['file', 'omni', 'buffer', 'syntax', 'member', 'dictionary']
  let g:neocomplete#sources.vim = g:neocomplete#sources._ + ['vim']

  " add customized dictionaries
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default': '',
        \ 'vimshell': $HOME.'./.vimshell_hist',
        \ 'scheme': $HOME.'./.gosh_completions'
        \ }

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " remapping
  inoremap <expr><C-g> neocomplete#undo_completion()
endfunction "}}}
"}}}
"
" +++ Plugin Management [neobundle] {{{
filetype off
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

call s:neocomplete_init()

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', { 
      \ 'build' : {
      \     'mac' : 'make',
      \     'linux' : 'make',
      \    },
      \ } 

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neopairs.vim'
NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'Shougo/neco-vim'
NeoBundle 'Shougo/neco-syntax'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'chrismccord/bclose.vim'
NeoBundle 'cohama/lexima.vim'     " auto close parentheses
NeoBundle 'tpope/vim-commentary'  " comments
NeoBundle 'majutsushi/tagbar'

call neobundle#end()
filetype plugin indent on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" *** plugin/neosnippet {{{
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" }}}
" *** plugin/Unite {{{
"let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
"nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
"nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
"nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
"nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
"nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
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
"}}}
"
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
" +++ color {{{
" enable rich colors in console
if !has('gui_running')
	set t_Co=256
endif

" color scheme retouch
autocmd ColorScheme * highlight Pmenu ctermbg=brown
autocmd ColorScheme * highlight PmenuSel ctermfg=25 ctermbg=3

"has to be put at the end of file, in order to make above autocmds work
colorscheme molokai
"}}}
"
"{{{ Cheet Sheets
"{{{ Vim folding commands
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
"}}}
"
