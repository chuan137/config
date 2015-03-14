
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000

filetype plugin on
filetype indent on

" default indent settings
set tabstop=4
set shiftwidth=4
set expandtab               " Convert tab to space
set smarttab		        " <BS> delte spaces acorrding to shiftwidth
set smartindent

" search settings
set incsearch               " find the next match as we type
set hlsearch                " Highlight search
set viminfo^=h              " Start with no highlighting
set ignorecase              " ignore case in search
set smartcase               

set wildmenu                " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing
set wildignore+=*.so,*.swp,*.zip
set wildignore+=*/node_modules/*,*/tmp/*,*/errors/*

" folding  [ 'zm'/'zr' to fold more/less ]
set foldmethod=indent       " fold based on indent
set foldnestmax=0           " deepest fold is 3 levels
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

set formatoptions-=o        " dont continue comments when pushing o/O

set number                  " Show line numbers

set mouse=a                 " enable mouse

set hidden                  " Keep buffer until killed; allow swtich without save

set laststatus=2

" set autochdir               " Change directory to current buffer on opening

let mapleader ="\\"
let g:mapleader = "\\"

nnoremap    <leader>w      :w!<cr>;                 " fast saving
nnoremap    <leader>x      :q<cr>;                  " fast quit
nnoremap    <leader>X      :q!<cr>;                 " fast quit
nnoremap    <leader>r      :source ~/.vimrc<cr>;	" reload rc file
nnoremap    <leader><cr>   :!<UP><cr>;              " execute last command
nnoremap    <CR>           :nohlsearch<cr><cr>;     " disable highlight
nmap        <F2>           :set nu!<cr>;            " switch line number
nmap        <F3>           :set paste!<cr>;         " switch paste mode
nmap        <C-d>          :sh<cr>
nnoremap    <C-f>          <C-d>
nnoremap    <C-b>          <C-u>
nnoremap    <C-n>          :cn<cr>
nnoremap    <C-m>          :cp<cr>

" highlight column 80 and onwards
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => addons
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>VUNDLE<<< 
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"---------------------------------------
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
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/RltvNmbr.vim'
"---------------------------------------
call vundle#end()
filetype indent plugin on
syntax on

" >>>AIRLINE<<<
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8q
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 0
let g:airline_detect_whitespace=0
" enable Powerline Font for mac
let g:Powerline_symbols = 'fancy'   

" >>>NERDTREE<<<
map <C-x> :NERDTreeTabsToggle<CR>
" quit if all buffer are closed, even NERDTree is open
autocmd bufenter * 
            \ if (winnr("$") == 1 && 
            \ exists("b:NERDTreeType") && b:NERDTreeType == "primary") 
            \ | q | endif

" >>>Buffergator<<<
let g:buffergator_viewport_split_policy="B"
let g:buffergator_split_size=10

" >>>RagTag<<<
"inoremap <M-o>       <Esc>o
"inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

" >>>Tag Bar<<<
nmap <F8> :TagbarToggle<CR>

" >>>Ctrl<<<


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Styles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi MatchParen cterm=underline ctermbg=none ctermfg=none

    
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key Mappings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs
nnoremap <S-Tab>        <C-w>w
nnoremap <C-t><C-n>     :tabnew<CR>
nnoremap <Leader>n      :tabn<CR>
nnoremap <Leader>m      :tabp<CR>
nnoremap <leader>1      1gt<CR>
nnoremap <leader>2      2gt<CR>
nnoremap <leader>3      3gt<CR>
nnoremap <leader>4      4gt<CR>
nnoremap <leader>5      5gt<CR>
nnoremap <leader>6      6gt<CR>
nnoremap <leader>7      7gt<CR>
nnoremap <leader>8      8gt<CR>
nnoremap <leader>9      9gt<CR>
nnoremap <leader>0      10gt<CR>

" buffers
nnoremap <leader>k      :bp<CR>
nnoremap <leader>j      :bn<CR>
nnoremap <leader>g      :e#<CR>
nnoremap <leader>d      :bd<CR>

" remember last edit position
if has("autocmd")
  au BufReadPost * 
              \ if line("'\"") > 1 && line("'\"") <= line("$") 
              \ | exe "normal! g'\"" | endif
endif

if !has('gui_running')
	set t_Co=256
endif

"" fix meta-keys which generate <Esc>a .. <Esc>z
"let c='a'
"while c <= 'z'
  "exec "set <M-".toupper(c).">=\e".c
  "exec "imap \e".c." <M-".toupper(c).">"
  "let c = nr2char(1+char2nr(c))
"endw
