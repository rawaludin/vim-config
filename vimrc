" File: .vimrc
" Author: Rahmat Awaludin <rahmat.awaludin@dmail.com>
"
" How I configure Vim :P

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Enable custom identation for each file type check .vim/ftplugin
filetype plugin indent on

call plug#begin('~/.vim/plugged')

" ----- Making Vim look good ------------------------------------------
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'bling/vim-airline'

" ----- Vim as a programmer's text editor -----------------------------
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/syntastic'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'mattn/emmet-vim'
Plug 'lokaltog/vim-easymotion'
Plug 'tomtom/tcomment_vim'

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" ----- Working with Markdown ----------------------------------------------
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'nelstrom/vim-markdown-folding'

" ----- Other text editing features -----------------------------------
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'

" ----- man pages, tmux -----------------------------------------------
Plug 'jez/vim-superman'
" Plug 'christoomey/vim-tmux-navigator'

" ---- Extras/Advanced plugins ----------------------------------------
" Highlight and strip trailing whitespace
Plug 'ntpeters/vim-better-whitespace'"

call plug#end()

" --- General settings --- 
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set ruler                 " show the cursor position all the time
set number                " line numbers
set showcmd               " display incomplete commands
set incsearch             " do incremental searching
set hlsearch
set wildmenu              " command completion on pressing <Tab>
set autowriteall
syntax enable             " syntax highlighting and fix fold on code
set clipboard=unnamed     " share clipboard with OSX
set mouse=a               " allow mouse on terminal

" Tab settings
set expandtab             " Expand tabs into spaces
set tabstop=2             " default to 2 spaces for a hard tab
set softtabstop=2         " default to 2 spaces for the soft tab
set shiftwidth=2          " for when <TAB> is pressed at the beginning of a line
filetype indent plugin on " activate filetype plugin

" Fold setings
set foldmethod=indent     " Fold based on indent
set foldnestmax=10        " deepest fold is 10 levels
set nofoldenable          " dont fold by default

" --- set leader key to space ---
let mapleader = " "

" ----- General Leader key binding ---
" quit by <space>q
nmap <silent> <leader>q :q<CR>
" force quit by <space>qq
nmap <silent> <leader>qq :q!<CR>
" save by <space>w
nmap <silent> <leader>w :w<CR>
" save and quit by <space>wq
nmap <silent> <leader>wq :wq<CR>
" next buffer by ]
map ] :bn<cr>
" previous buffer by [
map [ :bp<cr>
" delete buffer by <space>bd
map <silent> <leader>d :bd<cr>
" switch pane by <space>w arrow
nnoremap <leader>w <C-W>


" ----- On the fly vimrc file editing -----
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
" edit vimrc file by <space>v
nmap <leader>v :edit $MYVIMRC<CR>


" ----- Plugin-Specific Settings --------------------------------------

" ----- altercation/vim-colors-solarized settings -----
" Toggle this to "light" for light colorscheme
set background=dark

" Uncomment the next line if your terminal is not configured for solarized
"let g:solarized_termcolors=256

" Set the colorscheme
colorscheme solarized


" ----- bling/vim-airline settings -----
" Always show statusbar
set laststatus=2

" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" download all the .ttf files, double-click on them and click "Install"
" Finally, uncomment the next line
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1


" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with <space>t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" Open synced tree with <space>ts
nmap <silent> <leader>ts :NERDTreeFind<CR>
" To have NERDTree always open on startup set this to 1
let g:nerdtree_tabs_open_on_console_startup = 0


" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END


" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>rt :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)


" ---- kien/ctrlp.vim settings ----
" Open/close ctrlp with <space>p (jump to file)
" nmap <silent> <leader>p :CtrlP<CR>
" Open/close ctrlpfunky with <space>r (jump to method)
nmap <silent> <leader>r :CtrlPFunky<CR>

" ----- junegunn/fzf ----
nmap <silent> <leader>p :FZF<CR>
command! -bar FZFTags if !empty(tagfiles()) | call fzf#run({'source': "sed '/^\\!/d;s/\t.*//' " . tagfiles()[0] . ' | uniq',      'sink':   'tag',  }) | else | echo 'Preparing tags' | call system('ctags -R') | FZFTag | endif
" nmap <silent> <leader>r :FZFTags<CR>

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({'source':  reverse(<sid>buflist()),'sink':    function('<sid>bufopen'),'options': '+m','down':    len(<sid>buflist()) + 2})<CR>})

" ----- airblade/vim-gitgutter settings -----
" Required after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1


" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = "
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END"'"'"]"']"


" ----- jez/vim-superman settings -----
" better man page support
noremap K :SuperMan <cword><CR>


" ----- tacahiroy/ctrlp-funky -----
" syntax highlighting
let g:ctrlp_funky_syntax_highlight = 1
" matched chars highlighting
let g:ctrlp_funky_matchtype = 'path'

" ----- mattn/emmet-vim settigs -----
let g:user_emmet_install_global = 0
autocmd FileType html,css,php EmmetInstall
let g:user_emmet_leader_key='<Tab>'

" ----- text bubling -----
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
