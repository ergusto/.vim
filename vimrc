" Plugins
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

Plug 'preservim/nerdtree'

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/improvedft'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'easymotion/vim-easymotion'
Plug 'lilydjwg/colorizer'

" Text objects
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'

" Syntax
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'stephpy/vim-yaml'

" Registers
Plug 'junegunn/vim-peekaboo'

call plug#end()

" Enable syntax highlighting
syntax on
set cursorline
set cursorcolumn

" Set colorscheme 
set termguicolors
set background=dark
colorscheme gruvbox

" Set leader
map <Space> <Leader>

highlight TabLineFill guibg=#434c5e guifg=#434c5e

" Set sign column to same colour as terminal
highlight Normal ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE

" :find files recursively
set path+=**
" Ignore node_modules in :find
set wildignore+=**/node_modules/**
set wildignore+=/usr/include/**
" Probably don't need to set this, but BSTS
set nocompatible
" Show line numbers
set number
" Use relative numbers
set relativenumber
" Map jk to escape key in insert mode
inoremap jk <ESC>
" Enable filetype detection, filetype specific scripts and filetype specific indent scripts
filetype plugin indent on
" Set default encoding
set encoding=utf-8
" No empty newlines at the end of files
set binary noeol
" Show (partial) command in the last line of the screen.
set showcmd
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Let the backspace key work normally
set backspace=indent,eol,start
" Store lots of :cmdline history
set history=1000
" Hide buffers instead of closing them. 
set hidden
" Show which mode is active
set showmode
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show line number in status line
set ruler
" Show the filename in the window titlebar
set title
" Hightlight matching bracket
set showmatch
" Make vsplit place the new buffer to the right of the current buffer
set splitright
" Make split place the new buffer below the current buffer
set splitbelow
" Reload files changed outside vim
set autoread
" Turn off swap files
set noswapfile nobackup nowb
" Highlight search results
set hlsearch
" Highlight as search is typed
set incsearch
" Ignore case when searching
set ignorecase
" ...unless you type a capital
set smartcase
" Don't wrap lines
set nowrap
" Show current line
set cursorline
" Scroll three lines before horizontal window border
set scrolloff=3
" Don't resize splits when closing
set noea
" Tab length
set tabstop=2
" When indenting with '>', use 4 spaces
set shiftwidth=2
" Smartly add indentation on new lines
set autoindent smartindent
" Tab completion
set wildmenu wildmode=longest,list,full
" Put swap files, backup files and undo files in specific folders instead of the working directory
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Mappings
" Remap arrow keys to move between splits
map <up> <C-w><up>
map <down> <C-w><down>
map <left> <C-w><left>
map <right> <C-w><right>

" Capital Y to yank to end of line
nnoremap Y yg_

" Find files
nnoremap <leader>f :find<Space>

" Buffer navigation
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>

" List buffers and immediately enter command mode
nnoremap <leader>b :ls<CR>:b<Space>

" Delete current buffer without touching split
command! Bd bp|bd #
nnoremap <leader>d :Bd<CR>

" Delete all buffers except this one
command! BufOnly execute '%bdelete|edit #|normal `"'
nnoremap <leader>o :BufOnly<CR>

" Clear search results
nnoremap <leader>c :noh<CR>

" Convert current word to uppercase
nmap <c-u> viwU<esc>
imap <c-u> <esc>viwUi

" Show trailing whitespaces as dots
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

" Netrw
" Remove directory banner in netrw
let g:netrw_banner=0
" Set default netrw windowsize
let g:netrw_winsize=-30
" Hide certain files from netrw
let g:netrw_list_hide='.DS_Store,__pycache__,.*\.swp$,*/tmp/*,*.swp,\.git/'
" Hide hidden items by default
let g:netrw_hide=1
" Disable .netrwhist files
let g:netrw_dirhistmax=0
" Tree listing
let g:netrw_liststyle=3
" Remove directory recursively by default
let g:netrw_localrmdir='rm -rf'
" Netrw annoyances
autocmd FileType netrw setlocal bufhidden=delete

" Nerdtree
" Open nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" Open Nerdtree if vim opens in a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Show hidden files in Nerdtree
let NERDTreeShowHidden=1

" Set default Nertree width
let g:NERDTreeWinSize=50

" Gitgutter
"let g:gitgutter_override_sign_column_highlight = 0

" airline
" Set airline theme
let g:airline_theme='deus'
" Show airline even with single file open
set laststatus=2
" Enable list of tabs/buffers across top of terminal window
let g:airline#extensions#tabline#enabled=1
" Show just the filename
let g:airline#extensions#tabline#fnamemod=':t'

" Lightline
function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}
let g:lightline#bufferline#filename_modifier = ':t'

set showtabline=2

" Auto populate new buffers with template file, determined by buffer's
" extension
augroup templates
	au!
	autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/template.'.expand("<afile>:e")
augroup END

" Add a File text object - to operate on entire files. E.g., yaf to yank an
" entire file
onoremap af :<C-u>normal! ggVG<CR>

" Format JSON file into something easily readable
nmap =j :%!python -m json.tool<CR>

" Tab settings for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Formatting settings for project specific directories
autocmd BufRead */Kaldor/**/*.js,*/Kaldor/**/*.sass setlocal ts=2 sw=2 expandtab
autocmd BufRead */Kaldor/**/*.php setlocal ts=4 sw=4 expandtab shiftwidth=4

" < Start Automatically enter and leave paste mode when pasting 
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
" > End

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Open vimrc in a new script
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Don't add the comment prefix when hitting enter or o/O on a comment line.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Vim bufkill
let g:BufKillCreateMappings = 0

" Define a simple "search" text object.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>