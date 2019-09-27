call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'chase/vim-ansible-yaml'
Plug 'airblade/vim-gitgutter'
Plug 'lifepillar/vim-mucomplete'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-surround'
Plug 'chrisbra/improvedft'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Color scheme
Plug 'sonph/onehalf', { 'rtp': 'vim/' }

call plug#end()

" Enable syntax highlighting
syntax on
set t_Co=256
set cursorline
" Set colorscheme 
colorscheme onehalfdark

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
" Show line numbers in all files
set number
" Set relative line numbers
set relativenumber
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
set tabstop=4
" When indenting with '>', use 4 spaces
set shiftwidth=4
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

" airline
" Show airline even with single file open
set laststatus=2
" Enable list of tabs/buffers across top of terminal window
let g:airline#extensions#tabline#enabled=1
" Show just the filename
let g:airline#extensions#tabline#fnamemod=':t'
" Show buffer number in tab line
" let g:airline#extensions#tabline#buffer_nr_show=1
" Gitgutter 
" Match background color
let g:gitgutter_override_sign_column_highlight=0

" Vim-mucomplete
set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert
set shortmess+=c
set belloff+=ctrlg

" File handling
" Set filetype for .jsx files to jsx
au BufNewFile,BufRead *.jsx setfiletype jsx syntax=javascript
" Set filetype for json
au BufNewFile,BufRead *.json setfiletype json syntax=javascript
" Treat .md files as markdown
au BufNewFile,BufRead *.md setlocal filetype=markdown

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

" Add fzf to vim runtime path
set rtp+=~/.fzf

" FZF shortcuts
" leader f to search files
nnoremap <silent> <leader>f :Files<cr>

" leader b for open buffers
nnoremap <silent> <leader>b :Buffers<cr>