"{{{ settings
colorscheme digerati
filetype plugin on
filetype indent on

set nocompatible
set laststatus=2
set scrolloff=5
set sidescrolloff=5
set fo+=o           " use C-w to delte the comment symbol
set mouse=n
set ttyfast

set hidden
set tabstop=4
set shiftwidth=4
set expandtab       " Convert tab to space
set smarttab		" <BS> delte spaces acorrding to shiftwidth
set autoindent      " ...
set smartindent     " ...

set wildmenu                
set wildmode=longest:full,full
set wildignore=*.o,*.obj,*~ 
set wildignore+=*.so,*.swp,*.zip
set wildignore+=*/node_modules/*,*/tmp/*,*/errors/*

" search settings
set incsearch       " find the next match as we type
set hlsearch        " Highlight search
set viminfo^=h      " Start with no highlighting
set ignorecase      " ignore case in search
set smartcase        

" Folding
set foldenable
set foldmethod=marker
set foldopen-=block
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"

" Window
set splitbelow
set splitright
nnoremap <S-Tab>    <C-w>w

" mappings
nnoremap <leader>g  :e#<CR>
nnoremap <leader>q  :q!<CR>
nnoremap <leader>w  :w<CR>
nnoremap <leader>r  :source ~/.vimrc<cr>;   " Reload rc file
nmap     <C-a>      :sh<CR>
" settings }}}

"{{{ Plugin
"
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim' 
Plugin 'shougo/neocomplete'
Plugin 'shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'davidhalter/jedi-vim'
"Plugin 'SirVer/ultisnips'
"Plugin 'jordwalke/VimCompleteLikeAModernEditor'
"Plugin 'honza/vim-snippets'
Plugin 'osyo-manga/vim-marching'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
call vundle#end()
filetype plugin on
filetype indent on

"{{{ [CtrlP] 
" open last mode
let g:ctrlp_cmd = 'call CallCtrlP()'
func! CallCtrlP()
    if exists('s:called_ctrlp')
        CtrlPLastMode
    else
        let s:called_ctrlp = 1
        CtrlPMRU
    endif
endfunc  
nnoremap <leader>] :CtrlPTag<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
"}}}

" {{{ [SuperTab]
"let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}

" {{{ [neocomplete,neosnippet]
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 0

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-Tab> '\<C-p>'

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : '<Space>'

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"        \ "\<Plug>(neosnippet_expand_or_jump)"
"        \: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"        \ "\<Plug>(neosnippet_expand_or_jump)"
"        \: "\<TAB>"

"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? '\<C-n>' :
"    \ <SID>check_back_space() ? '\<TAB>' :
"    \ neocomplete#start_manual_complete()
"function! s:check_back_space() 
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"}}}

"{{{ [Jedi-Vim]
let g:jedi#completions_enabled=0
let g:jedi#auto_vim_configuration = 0
"}}}

"{{{ [UltiSnips]
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"inoremap <expr><TAB> pumvisible() ? '\<C-n>' : '\<C-R>=UltiSnips#ExpandSnippet()'
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"}}}

"{{{ [Tagbar]
nmap <F8> :TagbarToggle<CR>
"}}}

"{{{ [Vim-Surround]
map <leader>s' ysiw'
map <leader>s" ysiw"
map <leader>s( ysiw)
map <leader>s[ ysiw]
map <leader>s{ ysiw}
"}}}

"{{{ [vim-markdown]
let g:vim_markdown_folding_disabled=1
"}}}

" Plugin }}}

"{{{ Tweaks

" remember last edit position
if has("autocmd")
  au BufReadPost * 
      \ if line("'\"") > 1 && line("'\"") <= line("$") 
      \ | exe "normal! g'\"" | endif
endif

" highlight column 80 and onwards
"let &colorcolumn="80,".join(range(120,999),",")
let &colorcolumn="80"
highlight ColorColumn ctermbg=109 guibg=#2c2d27

if !has('gui_running')
	set t_Co=256
endif

au BufNewFile,BufRead *.c,*.h,*.cpp set fdm=syntax
au CompleteDone * pclose
" Tweaks }}}
