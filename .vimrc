" plugins
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
call plug#end()

" vim configurations
set nocompatible
filetype on
filetype plugin on
filetype indent on
set wildmenu
set wildmode=list:longest,list:full
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

syntax on
set nobackup   " dont back up file to backup folder see https://vi.stackexchange.com/a/16846
set showcmd    " show the commands you type on bottom right corner
set showmode   " show the current mode (insert, visual etc)

" editor config
colorscheme onedark         " editor color scheme
set cursorline              " show horizontal line on current cursor
set nowrap                  " dont wrap lines. Alow long lines to extend as far asthe line goes
set number                  " show line numbers
set shiftwidth=4            " sets the indendation for the next line. see https://superuser.com/a/594589 
set tabstop=4               " the number of white spaces to insert when pressing tab key
set expandtab               " convert tab charaters to white spaces
set scrolloff=10            " the no of lines above an below the cursor to show when scrolling
set showmatch matchtime=3   " show the opening braces when closing it see https://vimtricks.com/p/vimtrick-highlight-matching-bracket/#:~:text=Vim's%20showmatch%20feature%20might%20be,matching%20bracket%20ever%20so%20briefly.

" search config
set incsearch   " move the cursor to the nearest match
set ignorecase  " ignore case use set smartcase to capture captals
set hlsearch    " highlight the searched terms in the file

" auto cmd
let blacklist = ["nerdtree"]
autocmd InsertEnter * set hlsearch!
autocmd InsertLeave * set hlsearch!
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" && index(blacklist, &ft) < 0 |  setlocal rnu | endif " set number mode to relative
autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu && index(blacklist, &ft) < 0 | setlocal nornu | endif                   " set number mode to normal

autocmd VimEnter * NERDTree | wincmd w                                                                                         " open nerd tree when opening vim. see https://stackoverflow.com/a/7640505 
autocmd BufEnter * NERDTreeMirror                                                                                              " open the same nerd tree when opening another buffer
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif  " Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif                         " Close the tab if NERDTree is the only window remaining in it.
autocmd FileType nerdtree setlocal nornu                                                                 " disable line number in nergtree

" normal mode key maps
    " pane navigation
    nnoremap <C-h> <C-w>h
    nnoremap <C-l> <C-w>l
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k

    " toggle nerd tree
    nnoremap <F3> :NERDTreeToggle<cr>

    " move search term to screen center
    nnoremap n nzz
    nnoremap N Nzz

    " clear search highlights
    nnoremap <leader>\ :noh<CR>

    " tab navigation
    nnoremap tn :tabnew<CR>
    nnoremap th :tabprev<CR>
    nnoremap tl :tabnext<CR>

   

" insert mode key maps
    inoremap jj <esc>

" visual mode key maps
    vnoremap <C-c> :w !wl-copy<CR><CR>
 
