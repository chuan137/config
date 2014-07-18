" settings
set tabstop =4
set shiftwidth =4
set expandtab                           " Convert tab to space
set smarttab		                    " <BS> delte spaces acorrding to shiftwidth
set hlsearch                            " Highlight search
set viminfo^=h                          " Start with no highlighting
set autochdir                           " Change directory to current buffer on opening
set number                              " Show line numbers
set mouse=a                              " enable mouse
"set hidden                              " Keep buffer until killed
"set foldlevel=0                         " Set fold level, 'zm'/'zr' to fold more/less
set laststatus=2
if !has('gui_running')
	set t_Co=256
endif


""""""""""""""""""""""""""""""
"" addon settings
""
""""""""""""""""""""""""""""""
""
"" Vundle
""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

source /home/chuan/.vim/pluginlist

call vundle#end()
filetype indent plugin on 
syn on
""
""
"" AIRLINE
""
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 0
""
""
"" NERDTREE
""
map <C-e> :NERDTreeTabsToggle<CR>
"map <S-Tab> :tabn<CR>
"map <C-n> :tabnew<CR>
""## quit if all buffer are closed, even NERDTree is open
""autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
""## open NERDTree if no file is open on startup
""autocmd vimenter * NERDTree
""autocmd vimenter * call s:CheckToSplitTwoTrees()
"function! s:CheckToSplitTwoTrees()
    "if argc() != 1 || !isdirectory(argv(0))
        "return
    "endif
 
    "vsplit
 
    ""there should really be a better way to do this... e.g. :NERDTreeSecondary
    "call nerdtree#checkForBrowse(argv(0))
"endfunction
""
""
"" Buffergator
""
let g:buffergator_viewport_split_policy="B"
let g:buffergator_split_size=10
""
""
"" Ragtag
""
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

""""""""""""""""""""""""""""""
"" custom mappings
""
""""""""""""""""""""""""""""""
""
"" Window
""
""
nnoremap <S-Tab> <C-w>w
""
""
"" TAB
""
nnoremap <C-A-PageDown> :tabn<CR>
nnoremap <C-A-PageUp> :tabp<CR>
"nnoremap <C-Left> :tabn<CR>
"nnoremap <C-Right> :tabp<CR>
""
""
"" BUFFER
""
" \b       : list buffers
" \a \d \g : go back/forward/last-used
" \x       : close buffer
" \1 \2 \3 : go to buffer 1/2/3 etc
"nnoremap <Leader>b :ls<CR>
nnoremap <Leader>a :bp<CR>
nnoremap <Leader>d :bn<CR>
nnoremap <C-Left>  :bn<CR>
nnoremap <C-Right> :bp<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>x :bd<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
""
""
"" Excecute last command
""
nnoremap <Leader><CR> :!<UP><CR>
nmap <F2> :set nu!<CR>
nmap <C-d> :sh<CR>
nnoremap FF :w<CR>
""
""
"" put at end of file
"" Disable highlight by enter
""
noremap <CR> :nohlsearch<CR><CR>        
nnoremap Q :q!<CR>
