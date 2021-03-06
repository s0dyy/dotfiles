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
"Plug 'jiangmiao/auto-pairs'
Plug 'jan-warchol/selenized' 
Plug 'robeirne/twodark.vim'
Plug 'chriskempson/base16-vim'
"Plug 'sainnhe/sonokai'
Plug 'wadackel/vim-dogrun'
"Plug 'relastle/bluewery.vim'
"Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'lilydjwg/colorizer'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
if isdirectory($HOME . "/.vim/plugged/YouCompleteMe")
    Plug 'Valloric/YouCompleteMe'
endif
call plug#end()

"--------------"
" VIM SETTINGS "
"--------------"

set termguicolors
colorscheme selenized
set background=dark
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guifg=#72898f guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi VertSplit guifg=#184956 guibg=NONE guisp=NONE gui=NONE cterm=NONE
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
      \ 'colorscheme': 'selenized_dark',
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
let g:indentLine_color_gui = '#72898f'
let g:indentLine_char = '.'
let g:indentLine_first_char = '.'

"-----"
" COC "
"-----"

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  "inoremap <silent><expr> <c-@> coc#refresh()
  inoremap <silent><expr> <C-CR> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"-------------"
" COC/SNIPPET "
"-------------"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
