" some default settings {{{ 
colorscheme digerati
filetype plugin on
filetype indent on
syntax on
"}}}

" tab/indent
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" basic mappings
nnoremap <leader>w  :w<CR>
nnoremap <leader>g  :e#<CR>
nnoremap <leader>r  :so ~/.vimrc<CR>

"nnoremap <F5> :set paste!<CR>
set pastetoggle=<F5>

" folding
set foldenable
set foldmethod=marker
set foldopen-=block
set foldlevel=1		"leave top level folding open
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>;		
nnoremap <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"
" toggle folding with <space>
" {,} paragraph jump, ignoring empty lines inside closed folding

"wildmenu                
set wildmenu
set wildignore=*.o,*.obj,*~ 
set wildignore+=*.so,*.swp,*.zip
set wildignore+=*/node_modules/*,*/tmp/*,*/errors/*
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
        return ''
endfunction

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set hidden    "allow swiching buffer without saving
set fo+=o     "format options
set mouse=n
set ttyfast
"}}}

"{{{ Plugin management with neobundle.vim
filetype off
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'hynek/vim-python-pep8-indent'

call neobundle#end()
filetype plugin indent on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"}}}

"{{{ cheet sheets
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
"{{{
"}}}
"}}}
