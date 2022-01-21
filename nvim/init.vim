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
nnoremap <silent> <leader>ro :e#<cr>
nnoremap <silent> <C-Left> gT
nnoremap <silent> <C-Right> gt
nnoremap <silent> <leader>\ ``
nnoremap <silent> <C-t> :tabnew<cr>
nnoremap <silent> <C-c> :tabclose<cr>

" -----------------------------------------------------------------------------
" PlugManager
" -----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'ainnhe/everforest'
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
Plug 'kergoth/vim-bitbake'
call plug#end()

" -----------------------------------------------------------------------------
" Options
" -----------------------------------------------------------------------------

" Editor Settings
:syntax enable
let g:everforest_background = 'hard'
:colorscheme everforest
set background=dark
set nu
set noswapfile
set nobackup
set nowritebackup
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
set updatetime=300
set shortmess+=c

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
nnoremap <leader>t :FzfBTags<cr>

" Syntastic
" -----------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
nnoremap <silent><nowait> <leader>e  :Errors<cr>

" NerdTree
" -----------------------------------------------------------------------------
let NERDTreeHighlightCursorline=1
let NERDTreeMouseMode=2

nnoremap <leader>n :NERDTreeToggle<CR>

" CoC
" -----------------------------------------------------------------------------

let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-highlight',
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer',
    \ 'coc-markdownlint',
    \ 'coc-sh',
    \ 'coc-eslint',
    \ 'coc-yaml',
    \ 'coc-cmake',
\]

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
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
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[` and `]` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> <leader>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>] <Plug>(coc-diagnostic-next)

" Show all diagnostics.
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fs  <Plug>(coc-format-selected)
nmap <leader>fs  <Plug>(coc-format-selected)

