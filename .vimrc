call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set encoding=utf-8
set autoindent
set backspace=indent,eol,start
set bs=2
set cindent
set complete=.,w,b,u,t,i
set cursorline
set expandtab
set ignorecase
set incsearch
set laststatus=2
set mat=5
set nocompatible
set number
set ruler
set shiftwidth=2
set showmatch
set smartcase
set smarttab
set tabstop=2
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 

let g:ragtag_global_maps = 1
let g:Powerline_symbols = 'fancy'
let g:svndiff_autoupdate = 1 
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$' 


" Syntax Highlighting and indent
syntax on
filetype on
filetype plugin on
filetype indent on

" Auto-complete for Ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" Java commenting
autocmd FileType java let b:jcommenter_class_author='Patrick Morgan (patrick@patrick-morgan.net)' 
autocmd FileType java let b:jcommenter_file_author='Patrick Morgan (patrick@patrick-morgan.net)' 
autocmd FileType java map <Leader>c :call JCommentWriter()<CR> 

" GVIM/mvim config
if has("gui_running")
	colorscheme evening
	highlight Pmenu ctermbg=238 gui=bold
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
	set guifont=Source\ Code\ Pro\ for\ Powerline:h13
endif


" GPG integration
au BufNewFile,BufReadPre *.gpg :set secure viminfo= noswapfile nobackup nowritebackup history=0 binary
au BufReadPost *.gpg :%!gpg -d 2>/dev/null
au BufWritePre *.gpg :%!gpg -e -r 'pmorgan@crossroads.com' 2>/dev/null
au BufWritePost *.gpg u

" Custom Keybindings
let mapleader=","
map     <C-T> :tabnew<CR>
map			<C-s-right> :tabnext<CR>
map     <C-s-left> :tabprev<CR>
map     <Leader>n :NERDTreeToggle<CR>
map     <Leader>A :Ack<space>
map     <Leader>l :TagbarToggle<CR>

