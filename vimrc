set nocompatible

" Show line numbers
" Plugins
call plug#begin('~/.vim/plugged')

" Colour schemes
Plug 'altercation/vim-colors-solarized'
Plug 'sainnhe/everforest'

Plug 'preservim/nerdtree'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/improvedft'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'easymotion/vim-easymotion'
Plug 'lilydjwg/colorizer'

" Text objects
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'

" Highlighting
Plug 'andymass/vim-matchup'

" Syntax
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'prisma/vim-prisma'

" Registers
Plug 'junegunn/vim-peekaboo'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

call plug#end()

" Enable syntax highlighting
syntax enable
set cursorline
set cursorcolumn
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Set colorscheme 
" Enable true color
if has('termguicolors')
	set termguicolors
endif

set background=dark

let g:everforest_background = 'dark'
colorscheme everforest

" Set leader
map <Space> <Leader>

" Set sign column to same colour as terminal
highlight Normal ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE

" :find files recursively
set path+=**
" Ignore node_modules in :find
set wildignore+=**/node_modules/**
set wildignore+=/usr/include/**
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

" Buffer navigation
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>

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

" FZF config/Mappings

" Prevent FZF commands from opening in none modifiable buffers
" https://github.com/junegunn/fzf/issues/453#issuecomment-700943343

function! FZFOpen(cmd)
    " If more than 1 window, and buffer is not modifiable or file type is
    " NERD tree or Quickfix type
    if winnr('$') > 1 && (!&modifiable || &ft == 'nerdtree' || &ft == 'qf')
        " Move one window to the right, then up
        wincmd l
    endif
    exe a:cmd
endfunction

" FZF in Open buffers
nnoremap <silent> <leader>b :call FZFOpen(":Buffers")<CR>

" FZF Search for Files
nnoremap <silent> <leader>f :call FZFOpen(":GFiles")<CR>

" Find search term within files recursively
nnoremap <silent> <leader>fi :call FZFOpen(":Rg")<CR>

" Coc and vim

" Typescript coc server
let g:coc_global_extensions = [
			\ 'coc-tsserver',
			\ 'coc-tslint',
			\ 'coc-css',
			\ 'coc-tailwindcss',
			\ 'coc-prisma'
			\ ]

" Show inferred type definition from coc.vim

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Conditionally load prettier and eslint extensions if the project contains those tools
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Apply codeaction to the current line
nmap <leader>ac <Plug>(coc-codeaction)
" Apply hotfix to problem on current line
nmap <leader>qf <Plug>(coc-fix-current)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! CheckBackspace() abort
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

" bufferline.nvim
lua << EOF
require("bufferline").setup{
	options = {
		diagnostics = "coc",
	}
}
EOF