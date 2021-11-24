" -----------------------------------------------------------------------------
" Configuration file VIM
" Author: werneazc
" Date: 2021-10-13
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" User defined functions
" -----------------------------------------------------------------------------
" grep for the word under cursor
command! -bang -nargs=* MyGrep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(expand('<cword>')), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

" -----------------------------------------------------------------------------
" Key-Mappings
" -----------------------------------------------------------------------------
let mapleader=' '
nnoremap <silent> <leader>gg :MyGrep (expand('<cword>'))<cr>

" -----------------------------------------------------------------------------
" PlugManager
" -----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'jremmen/vim-ripgrep'
Plug 'yggdroot/indentline'
Plug 'editorconfig/editorconfig-vim'
Plug 'csexton/trailertrash.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
call plug#end()

" -----------------------------------------------------------------------------
" Options
" -----------------------------------------------------------------------------

" Editor Settings
:syntax enable
:colorscheme gruvbox
set background=dark
set nu
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set nowrap
set smartcase
set cmdheight=3
set mouse=a
set signcolumn=yes:2
set noerrorbells
set showmatch
set showtabline=2

" Format settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start
set incsearch
" VIM DevIcons requires a nerd font to be install
set guifont=DejaVuSansMono\ Nerd\ Font:h11

" -----------------------------------------------------------------------------
" PlugIns
" -----------------------------------------------------------------------------

" Vim-Airline
" -----------------------------------------------------------------------------
let g:airline_powerline_fonts=1


" FZF
" -----------------------------------------------------------------------------
set rtp+=/opt/homebrew/opt/fzf
command! -bang -nargs=? FzfFd
    \  call fzf#run(fzf#wrap({'source': 'fd -t f -j 2 -- '.shellescape(<q-args>), 'sink': 'e'}, <bang>0))
let g:fzf_layout = { 'up': '40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_command_prefix = "Fzf"
let g:fzf_buffers_jump = 1
let g:fzf_commands_expect = 'enter,ctrl-x'
nnoremap <leader>f :FzfFd<cr>
nnoremap <leader>g :FzfRg<cr>
nnoremap <leader>c :FzfCommands<cr>
nnoremap <leader>l :FzfLines<cr>
nnoremap <leader>b :FzfBuffers<cr>

" Syntastic
" -----------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NerdTree
" -----------------------------------------------------------------------------
let NERDTreeHighlightCursorline=1
let NERDTreeMouseMode=2

nnoremap <leader>n :NERDTreeToggle<CR>

