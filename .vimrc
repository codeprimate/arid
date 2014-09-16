call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set encoding=utf-8
set backspace=indent,eol,start
set complete=.,w,b,u,t,i
set cursorline
set ignorecase
set incsearch
set laststatus=2
set mat=5
set nocompatible
set shiftwidth=2
set showmatch
set smartcase
set wildmenu
set wildmode=list:longest,list:full
set hls

" DISABLE FOLDS
set nofoldenable

" Misc
let g:ragtag_global_maps = 1
let g:svndiff_autoupdate = 1

" Auto-complete
let g:SuperTabDefaultCompletionType = "context"
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
"set complete-=k complete+=k

" Extra Filetypes
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.html.eex set filetype=html
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
au BufRead,BufNewFile *.rake set ft=ruby

" Gist
let g:gist_post_private = 1
let g:gist_clip_command = 'pbcopy'

" GPG integration
au BufNewFile,BufReadPre *.gpg :set secure viminfo= noswapfile nobackup nowritebackup history=0 binary
au BufReadPost *.gpg :%!gpg -d 2>/dev/null
au BufWritePre *.gpg :%!gpg -e -r 'pmorgan@peopleadmin.com' 2>/dev/null
au BufWritePost *.gpg u

" RuboCop Ruby linter leader binding
let g:vimrubocop_keymap = 0
map <Leader>r :RuboCop<CR>

" Custom Keybindings
let mapleader=","
map <C-T> :tabnew<CR>
map <C-s-up> :bprev<CR>
map <C-s-down> :bnext<CR>
map <Leader>n :NERDTreeToggle<CR>
map <Leader>A :Ack<space>
map <Leader>l :TagbarToggle<CR>
map <Leader>t :call TrimWhiteSpace()<CR>

" Look and Feel
set number
set ruler
set t_Co=256
set background=dark
colorscheme slate

"" GVIM/mvim config
if has("gui_running")
  colorscheme evening
  highlight Pmenu ctermbg=238 gui=bold
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set guifont=Sauce\ Code\ Powerline:h12
else
  set mouse=a "enable mouse in console
endif

"" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"" Syntax Highlighting and indent
set bs=2
set tabstop=2
set autoindent
set cindent
set smarttab
set expandtab
syntax on
filetype on
filetype plugin on
filetype indent on

" IndentGuides
let g:indent_guides_guide_size = 1
autocmd FileType * IndentGuidesEnable
autocmd FileType calendar IndentGuidesDisable

" Vimwiki
let g:vimwiki_use_calendar = 1
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'path_html': '~/Documents/vimwiki_html/', 'diary_rel_path' : ''}]

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" Github-flavored markdown (vim-flavored-markdown)
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
