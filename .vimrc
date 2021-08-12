"----------"
" VIM-PLUG "
"----------"

" Reopen the last edited position in files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" gheck if vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | close | source $HOME/.vimrc
endif

" repos
call plug#begin('~/.vim/plugged')
Plug 'edkolev/tmuxline.vim' 
Plug 'Yggdroot/indentLine'
Plug 'sainnhe/sonokai'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'lilydjwg/colorizer'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-fugitive'
Plug 'folke/tokyonight.nvim'
call plug#end()

"--------------"
" VIM SETTINGS "
"--------------"
set termguicolors
colorscheme sonokai
let g:sonokai_style = 'andromeda'
let g:sonokai_disable_italic_comment = 1
let g:sonokai_cursor = 'green'
let g:sonokai_transparent_background = 1
set background=dark
"hi Normal guibg=NONE ctermbg=NONE
"hi LineNr guifg=#72898f guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi VertSplit guifg=NONE guibg=NONE guisp=NONE gui=NONE cterm=NONE
set showtabline=2
set laststatus=2
set encoding=UTF-8 
set fileencoding=utf-8
set nocompatible
set guioptions+=a
set number relativenumber
set tabstop=4
set expandtab    
set shiftwidth=2
set autoindent   
set smartindent  
set cindent       
set hlsearch
set ignorecase 
set history=1000 
set scrolloff=1000
set nobackup       
set noswapfile 
if !isdirectory($HOME . "/.vim/viminfo")
    call mkdir($HOME . "/.vim/viminfo", "p")
endif
set viminfo+=n~/.vim/viminfo/.viminfo
set undofile
if !isdirectory($HOME . "/.vim/vimundo")
    call mkdir($HOME . "/.vim/vimundo", "p")
endif
set undodir=~/.vim/vimundo/
autocmd BufNewFile,BufRead *.exlib set syntax=sh
autocmd BufNewFile,BufRead *.exheres-0 set syntax=sh
autocmd BufNewFile,BufRead Vagrantfile set syntax=ruby
autocmd BufNewFile,BufRead vue set syntax=javascript
filetype plugin on

imap jj <Esc>
" clear highlights search 
nmap <Enter> :nohlsearch<CR>
" save
nmap <S-w> :w<CR>
" close and keep the window/split intact (vim-bufkill plugin)
nmap <S-q> :BD<CR>
" switch buffer shift + vim key
nmap <S-l> :bnext<CR>
nmap <S-h> :bprevious<CR>
" switch window ctrl + vim key
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

"------------------"
" PLUGINS SETTINGS "
"------------------"
" lightline
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
let g:lightline.tabline = {'left': [['buffers']], 'right': [['']]}
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = {'left': '', 'right': '' }
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <C-n> :NERDTreeToggle <CR>
let g:NERDTreeWinPos = 0
let NERDTreeWinSize = 50
let NERDTreeShowHidden= 0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen= 0
let NERDTreeShowBookmarks = 1
let nerdtreeshowlinenumbers=0
let NERDTreeAutoDeleteBuffer = 1

" gitgutter
nmap <C-g> :GitGutterToggle<CR>
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1

" devicons
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0

" nerd commenter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
let mapleader = "c" 
let g:NERDCommentEmptyLines = 0
let g:NERDDefaultNesting = 0 
let g:NERDCustomDelimiters = { 'vue': { 'left': '// ','right': '' } }

" youcompleteme
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:plug_timeout = 1000

" IndentLine {{
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 1
"let g:indentLine_color_gui = '#72898f'
let g:indentLine_char = '.'
let g:indentLine_first_char = '.'
