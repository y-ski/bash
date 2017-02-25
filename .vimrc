" NeoBundle
if has('vim_starting')
    " set paht for the first time
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " if neobundle is not installed, then install
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" My Bundles here:

" show full space or half space
NeoBundle 'bronson/vim-trailing-whitespace'
" show indentation
NeoBundle 'Yggdroot/indentLine'
" toggle comment by twice ctrl+-
NeoBundle 'tomtom/tcomment_vim'
let g:tcommentMapLeader1='<C-_>'
" show buffer list in status line
NeoBundle 'vim-scripts/buftabs'
let g:buftabs_only_basename=1   " show only file name
let g:buftabs_in_statusline=1   " show in status line
let g:buftabs_active_highlight_group='Visual'   " highlight current buffer

" right align from this
set statusline=%=
" readonly
set statusline+=%r
" encoding/line encoding
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
set statusline+=[%{(&fenc!=''?&fenc:&enc)}/%{ff_table[&ff]}]
" line number/total line
set statusline+=[%l/%L]
" show status line always
set laststatus=2

" for makdown
NeoBundle 'tpope/vim-markdown'
autocmd BufNewFile,BufReadPost *.md,*.txt set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'php']
" for json
NeoBundle 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

"----------------------------------------------------------
call neobundle#end()

" in some plugin, filetype indentaion is set off, so here set on again
filetype plugin indent on

" if there is not-installed plugin, then confirm installation.
NeoBundleCheck

" vim encoding
set encoding=utf-8
scriptencoding utf-8
" file encoding
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

" cursor move
" move to line top or line end
inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^i
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^i
" move to next line top beyond line end
set whichwrap=h,l
" in line wrap mode, move line by display line number
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
" enable <back space>
set backspace=indent,eol,start

" move cursor into paren.
" imap {} {}<Left>
" imap [] []<Left>
" imap () ()<Left>
" imap "" ""<Left>
" imap '' ''<Left>
" imap <> <><Left>

" move cursor into center in search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Paste from clipboard by Shift+Insert
inoremap <silent><S-Insert> <Esc>:set paste<CR> i <MiddleMouse>
noremap <silent><S-Insert> <Esc>:set paste<CR> i <MiddleMouse>
" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" split window
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
" switch window
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sw <C-w>w
" :cloase  -- close current window
" :qall :qa  -- close all window
" buffer
nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
" :e <filename>  -- edit buffer
" :bd[elete]  -- delete buffer

" tab/indent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

" enable align format excluding comment
set formatoptions-=c

" hilight search word
set hlsearch
" incremental search
set incsearch
" ignore case
set ignorecase
set smartcase
" switch hilight by twice ESC
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" ruler
set ruler
" line number
set number
" hilight cursor line
" set nocursorline
set cursorline
" hilight matched paren
set showmatch
:source $VIMRUNTIME/macros/matchit.vim
" hilight invisivle character
" set list

" beep off
set visualbell t_vb=
set noerrorbells

" confirm to save file before close
set confirm
" autoload when edit file
set autoread
" don't create backup file
set nobackup
" don't create swap file
set noswapfile

" title
set title
" status line
set laststatus=2
" completation at status line
set wildmenu wildmode=list:longest,full

" syntax
syntax on

" color scheme
colorscheme elflord

" change cursor form in normal mode or insert mode
if &term =~ "screen"
    let &t_ti.="\eP\e[1 q\e\\"
    let &t_SI.="\eP\e[5 q\e\\"
    let &t_EI.="\eP\e[1 q\e\\"
    let &t_te.="\eP\e[0 q\e\\"
elseif &term =~ "xterm"
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endif

