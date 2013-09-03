call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set encoding=utf-8
set autoindent
set backspace=indent,eol,start
set cindent
set complete=.,w,b,u,t,i
set cursorline
set ignorecase
set incsearch
set laststatus=2
set mat=5
set nocompatible
set number
set ruler
set bs=2
set tabstop=2
set shiftwidth=2
set expandtab
set showmatch
set smartcase
set smarttab
set wildmenu
set wildmode=list:longest,list:full
""set statusline=%t%{fugitive#statusline()}[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
let g:SuperTabDefaultCompletionType = "context"

let g:ragtag_global_maps = 1
let g:Powerline_symbols = 'fancy'
let g:svndiff_autoupdate = 1 

" Syntax Highlighting and indent
syntax on
filetype on
filetype plugin on
filetype indent on

" IndentGuides
let g:indent_guides_guide_size = 1
autocmd FileType * IndentGuidesEnable

" Auto-complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" GVIM/mvim config
if has("gui_running")
	colorscheme evening
	highlight Pmenu ctermbg=238 gui=bold
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
	set guifont=Source\ Code\ Pro\ for\ Powerline:h14
endif


" GPG integration
au BufNewFile,BufReadPre *.gpg :set secure viminfo= noswapfile nobackup nowritebackup history=0 binary
au BufReadPost *.gpg :%!gpg -d 2>/dev/null
au BufWritePre *.gpg :%!gpg -e -r 'patrick@patrick-morgan.net' 2>/dev/null
au BufWritePost *.gpg u

" Custom Keybindings
let mapleader=","
map     <C-T> :tabnew<CR>
map			<C-s-right> :tabnext<CR>
map     <C-s-left> :tabprev<CR>
map     <Leader>n :NERDTreeToggle<CR>
map     <Leader>A :Ag<space>
map     <Leader>l :TagbarToggle<CR>

" Gist
let g:gist_post_private = 0
let g:gist_clip_command = 'pbcopy'
