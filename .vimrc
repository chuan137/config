
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000
filetype plugin on
filetype indent on

set tabstop=4
set shiftwidth=4
set expandtab               " Convert tab to space
set smarttab		        " <BS> delte spaces acorrding to shiftwidth
set hlsearch                " Highlight search
set viminfo^=h              " Start with no highlighting
set number                  " Show line numbers
set mouse=a                 " enable mouse
set hidden                  " Keep buffer until killed; allow swtich without save
set foldlevel=0             " Set fold level, 'zm'/'zr' to fold more/less
set laststatus=2
"set autochdir               " Change directory to current buffer on opening

let mapleader ="\\"
let g:mapleader = "\\"
nnoremap    <leader>w      :w!<cr>;                     " fast saving
nnoremap    <leader>e      :q!<cr>;                     " fast quit
nnoremap    <leader>r      :source ~/.vimrc<cr>;        " reload rc file
nnoremap    <leader><cr>   :!<UP><cr>;                  " execute last command
nnoremap    <CR>           :nohlsearch<cr><cr>;         " disable highlight
nmap        <F2>           :set nu!<cr>;                " switch line number
nmap        <F3>           :set paste!<cr>;             " switch paste mode
nmap        <C-d>          :sh<cr>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => addons
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [[ Vundle ]]
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"Plugin 'edsono/vim-matchit'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ivalkeen/nerdtree-execute'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tomtom/tlib_vim'
Plugin 'mkitt/tabline.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-ragtag'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'vim-scripts/AutoClose'
call vundle#end()
filetype indent plugin on
syntax on

" [[ AIRLINE ]]
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 0
" ### enable Powerline Font for mac
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8q

" [[ NERDTREE ]]
map <C-e> :NERDTreeTabsToggle<CR>
"## quit if all buffer are closed, even NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" [[ Buffergator ]]
let g:buffergator_viewport_split_policy="B"
let g:buffergator_split_size=10

" [[ RagTag ]]
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

" [[ Tag Bar ]]
nmap <F8> :TagbarToggle<CR>

" [[ Atuo Pairs ]]
let g:AutoPairsShortcutToggle = '<Alt-w>'
let g:AutoPairsShortcutFastWrap = '<Alt-e>'
let g:AutoPairsShortcutJump='<Esc>n'
let g:AutoPairsShortcutBackInsert='<Esc>b'

" [[ CtrlP ]]
set wildignore+=*/node_modules/*,*/tmp/*,*.so,*.swp,*.zip,*/errors/*    " MacOSX/Linux


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Styles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi MatchParen cterm=underline ctermbg=none ctermfg=none

    
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key Mappings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs
nnoremap <C-t>          :tabnew<CR>
inoremap <C-t>          :<Esc>tabnew<CR>
nnoremap <C-j>          :tabn<CR>
nnoremap <C-k>          :tabp<CR>
nnoremap t1             1gt<CR>
nnoremap t2             2gt<CR>
nnoremap t3             3gt<CR>
nnoremap t4             4gt<CR>
nnoremap t5             5gt<CR>
nnoremap t6             6gt<CR>
nnoremap <S-Tab>        <C-w>w

" buffers
nnoremap <leader>k      :bp<CR>
nnoremap <leader>j      :bn<CR>
nnoremap <leader>g      :e#<CR>
nnoremap <leader>x      :bd<CR>
nnoremap <leader>1      :1b<CR>
nnoremap <leader>2      :2b<CR>
nnoremap <leader>3      :3b<CR>
nnoremap <leader>4      :4b<CR>
nnoremap <leader>5      :5b<CR>
nnoremap <leader>6      :6b<CR>
nnoremap <leader>7      :7b<CR>
nnoremap <leader>8      :8b<CR>
nnoremap <leader>9      :9b<CR>
nnoremap <leader>0      :10b<CR>


" ### remember last edit position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if !has('gui_running')
	set t_Co=256
endif
