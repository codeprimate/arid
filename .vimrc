set nocompatible
set laststatus=2
set bs=2
set cursorline
set ignorecase
set showmatch
set mat=5
set nu
set ruler
set autoindent
set cindent
set shiftwidth=2
set tabstop=2
set smartcase
set smarttab
set wildmenu

syntax on
filetype on
filetype plugin on
filetype indent on

"set foldmethod=indent
"set foldlevel=1

" GVIM config
colorscheme evening
highlight Pmenu ctermbg=238 gui=bold
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Custom Keybindings
map     <C-T>       :tabnew<CR>
map     <a-s-right> :tabnext<CR>
map     <a-s-left>  :tabprev<CR>
map     <C-V>       "+gP
cmap    <C-V>       <C-R>+
vnoremap <C-C>      "+y
imap    <S-CR>    <CR><CR>end<Esc>-cc

" GPG integration
au BufNewFile,BufReadPre *.gpg :set secure viminfo= noswapfile nobackup nowritebackup history=0 binary
au BufReadPost *.gpg :%!gpg -d 2>/dev/null
au BufWritePre *.gpg :%!gpg -e -r 'patrick.morgan@gmail.com' 2>/dev/null
au BufWritePost *.gpg u
