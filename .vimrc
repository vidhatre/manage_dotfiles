syntax on " Syntax highlighting on
filetype on " Filetype detection
set nu!
"case insensitive
set ic
"case sensitive
"set noic
set hlsearch
"hi Search ctermfg=black ctermbg=yellow guifg=green
set background=dark
"bala highlight Normal ctermfg=grey ctermbg=yellow
highlight Normal ctermfg=grey ctermbg=green
"highlight Normal ctermfg=grey ctermbg=darkblue
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
colorscheme slate
" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=2        " tab width is 4 spaces
set shiftwidth=2     " indent also with 4 spaces
"set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
" colorscheme wombat256
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
"let g:DoxygenToolkit_authorName="John Doe <john@doe.com>"
"expand tabs to spaces
map <F8> :retab <CR> :wq! <CR>

" Enhanced keyboard mappings
"
" F2: toggle paste mode
set pastetoggle=<F2>
" F3: in normal mode save the file
nmap <F3> :w<CR>
" F3: in insert mode will exit insert, save, enters insert again
imap <F3> <ESC>:w<CR>i
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" recreate tags file with F5
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
map <F7> :make<CR>
" build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>
" goto definition with F12
map <F12> <C-]>
" in diff mode we use the spell check keys for merging
if &diff
  ” diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
"  " spell settings
"  :setlocal spell spelllang=en
"  " set the spellfile - folders must exist
"  set spellfile=~/.vim/spellfile.add
  map <M-Down> ]s
  map <M-Up> [s
endif

"https://stackoverflow.com/questions/1557893/making-inserting-a-single-character-in-vim-an-atomic-operation
nnoremap <TAB> :<C-U>call InsertChar#insert(v:count1)<CR>

hi Search ctermfg=black ctermbg=yellow guifg=green

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0

" Added vim-plug ins
call plug#begin('~/.vim/plugged')
  " Make sure you use single quotes
  Plug 'vhda/verilog_systemverilog.vim'
  Plug 'https://github.com/rhysd/vim-clang-format.git'
  " NERD tree will be loaded on the first invocation of NERDTreeToggle command
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  " plugin for scala syntax highlighting
  Plug 'derekwyatt/vim-scala'
  "Vim multiple cursor
  Plug 'terryma/vim-multiple-cursors'
  "Stuff for space-insert-single-char and "." to repeat
  Plug 'http://github.com/tpope/vim-repeat'
  Plug 'https://github.com/vim-scripts/InsertChar'
  " better bottom status bar
  Plug 'bling/vim-airline'
  " Git in Vim
  Plug 'tpope/vim-fugitive'
  " Tabularize data, visual select > :Tab /<delim>
  " http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
  Plug 'godlygeek/tabular'

call plug#end()

" Set tab to 2 spaces
filetype plugin indent on
" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab
