syntax on
filetype plugin on    " enable ftplugin scripts
filetype indent on    " enable filetype specific indent scripts

"{{{ minimal
set nocompatible      " be iMproved
set hidden            " hidden buffer: allow swiching without saving
set tabstop=8         " display tab as 8 spaces
set softtabstop=2     " replace tab with 2 spaces on editing
set shiftwidth=2      " set each indent level as 2 spaces
set expandtab         " expand tab to real spaces
set smarttab          " <BS> delete spaces according to shiftwidth
set backspace=2       " fix backspace problem on mac
set number            " line number
set relativenumber
set foldmethod=marker
set mouse=n
set textwidth=76
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
"{{{ mappings
nnoremap ; :
nnoremap <leader>w  :w<CR>
nnoremap <leader>g  :e#<CR>
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <C-d> :sh<CR>
"}}}
"{{{ color
if !has('gui_running')
	set t_Co=256
endif

" autocmd ColorScheme * highlight Pmenu ctermbg=brown
" autocmd ColorScheme * highlight PmenuSel ctermfg=25 ctermbg=3
" autocmd ColorScheme * highlight LineNr ctermfg=236 ctermbg=234
" autocmd ColorScheme * highlight CursorLineNr ctermbg=234
" autocmd ColorScheme * highlight FoldColumn ctermfg=12 ctermbg=235
" autocmd ColorScheme * highlight Folded cterm=bold ctermfg=12 ctermbg=234

colorscheme molokai
let python_highlight_all = 1

hi MatchParen cterm=underline,bold ctermbg=none ctermfg=14
"}}}

" +++ last edit position {{{
if has("autocmd")
  au BufWinLeave *.* mkview
  au BufWinEnter *.* silent loadview
endif
"}}}
"{{{ +++ Fast wrap
" move matched parenthesis to end of next word
nnoremap <c-e> :call FastWrap()<CR>
inoremap <c-e> <Esc>l:call FastWrap()<CR>
"}}}
" +++ Cursor shape {{{
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
" }}}


function! FastWrap() "{{{

  if s:check_cursor_space()
    normal vwxEp
  else
    normal xEp
  end
endfunction
" }}}
function! HasPaste() "{{{
  if &paste
    return '[paste]'
  else
    return ''
endfunction 
"}}}
function! s:check_cursor_space() "{{{
  let col = col('.')
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction 
" }}}

"{{{  Vundle 
filetype off
set nocompatible               " be improved
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tomtom/tcomment_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'sentientmachine/Pretty-Vim-Python'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()            " required
filetype plugin indent on    " required
"}}}
"{{{ >>> YCM <<<
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
"}}}
"{{{ >>> ctrlp.vim <<<
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 600
let g:ctrlp_max_depth = 5
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_match_window = 'bottom'
let g:ctrlp_extensions = ['buffertag', 'dir']
let g:ctrlp_cmd = 'call CallCtrlP()'

nnoremap <Leader>f :CtrlP<CR>
nnoremap <Leader>t :CtrlPBufTag<CR>

func! CallCtrlP()
  wincmd J
  if exists('s:called_ctrlp')
    CtrlPLastMode
  else
    let s:called_ctrlp = 1
    CtrlPMRU
  endif
endfunc  
"}}}
"{{{ >>> auto-pairs >>>
let g:AutoPirsFlyMode=1
"}}}

autocmd FILETYPE python set tabstop=8 shiftwidth=4 softtabstop=4 expandtab 
