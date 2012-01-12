set autoindent
set backspace=indent,eol,start
set bs=2
set cindent
set complete=.,w,b,u,t,i
set cursorline
set ignorecase
set incsearch
set laststatus=2
set mat=5
set nobackup
set nocompatible
set nu
set number
set ruler
set shiftwidth=2
set showmatch
set smartcase
set smarttab
set tabstop=2
set wildmenu
set wildmode=list:longest,list:full

syntax on
filetype on
filetype plugin on
filetype indent on

"set foldmethod=indent
"set foldlevel=1

" GVIM config
if has("gui_running")
	colorscheme evening
	highlight Pmenu ctermbg=238 gui=bold
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
	set guifont=Menlo:h13
endif

" Custom Keybindings
map     <C-T>       :tabnew<CR>
map			<a-s-right> :tabnext<CR>
map     <a-s-left>  		:tabprev<CR>

" GPG integration
au BufNewFile,BufReadPre *.gpg :set secure viminfo= noswapfile nobackup nowritebackup history=0 binary
au BufReadPost *.gpg :%!gpg -d 2>/dev/null
au BufWritePre *.gpg :%!gpg -e -r 'pmorgan@factech.com' 2>/dev/null
au BufWritePost *.gpg u

