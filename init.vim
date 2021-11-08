syntax on
set nu
set ruler               " Show the line and column numbers of the cursor.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set modeline            " Enable modeline.
"set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
" More natural splits
set splitbelow          " Horizontal split below current.
"set splitright          " Vertical split to right of current.
if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set display+=lastline
set nostartofline       " Do not jump to first character with page commands.
set noerrorbells                " No beeps
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set showmatch                   " Do not show matching brackets by flickering
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set autoindent
set tabstop=4 shiftwidth=4 expandtab
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set clipboard=unnamed   " Enable yanking to system clipboard (mac os x pbcopy/pbpaste)

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s///g<Left><Left><Left>

" Leader key is like a command prefix.
let mapleader='z'
let maplocalleader='\'

let g:python_host_prog="/usr/bin/python3"

let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_default_to_last = 1

" set cursorcolumn
nmap <Space> <PageDown>
vmap <BS> x

" cd ~/.config/nvim/spell
" wget http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl
" set spell spelllang=pt_pt
" zg to add word to word list
" zw to reverse
" zug to remove word from word list
" z= to get list of possibilities
" set spellfile=~/.config/nvim/spellfile.add
set nospell

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugins here
call plug#begin('~/.config/nvim/plugged')
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-syntastic/syntastic'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'airblade/vim-gitgutter'
"Plug 'Valloric/YouCdompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'Chiel92/vim-autoformat'
Plug 'preservim/nerdtree'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-fugitive'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

" deoplete config
let g:deoplete#enable_at_startup = 1
"let g:deoplete#disable_auto_complete = 0
"if has("gui_running")
"    inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
"else
"    inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
"endif

" UltiSnips config
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  " set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+
endif

" nerdtree config
map <C-p> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Close Vim if NerdTree is the last open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" set working dir to current file, do not do so if file is in tmp
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror


" FZF installed via Homebrew - let it work in Vim
 set rtp+=/usr/local/bin/fzf
 nnoremap fzf :Files %:p:h<CR>
 nnoremap fh :History<CR>
 nnoremap ff :BLines<CR>
 nnoremap FF :Ag<CR>
 nnoremap fc :Commits<CR>
 nnoremap fg :!cd `git rev-parse --show-toplevel'<CR><CR>

 " Vim Terraform
let g:terraform_fmt_on_save=1
autocmd BufRead,BufNewFile *.hcl set filetype=terraform

" Terminal
" """""""""
" in file's current directory
"nnoremap <C-t> :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>
" in directory set for vim session
" nnoremap <C-t> :term<CR>
nnoremap <C-t> :split term://zsh<CR>
"set splitbelow

" Syntastic Config
" """"""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0



" airline settings
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_powerline_fonts=1
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
let g:airline_powerline_fonts=1
let g:airline_theme='minimalist'

" Folding - do not fold when opening a file
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" multiple cursors via mouse
nmap   <Leader>LeftMouse         <Plug>(VM-Mouse-Cursor)
nmap   <C--RightMouse>        <Plug>(VM-Mouse-Word)
nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)

" YouCompleteMe
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_min_num_of_chars_for_completion = 1

" Other
set mouse=a
set list

" Theme
if (has("termguicolors"))
    set termguicolors
endif
"colorscheme tender
colorscheme nord
highlight SignColumn guibg=#272822
let g:rehash256 = 1
let NERDTreeIgnore = ['_site']

" Buffer handling
" nmap L :let &number=1-&number<CR> " interferes with navigation
"nmap <leader>l :bnext<CR>
"nmap <c-h> :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>
nmap <leader>0 :set invnumber<CR>
" map :q to byffer delete
" http://stackoverflow.com/questions/7513380/vim-change-x-function-to-delete-buffer-instead-of-save-quit
cnoreabbrev <expr> q getcmdtype() == ":" && (getcmdline() == 'q' && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1) ? 'bd' : 'q'

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" reload file
nnoremap rl :checktime<CR>

" Javacomplete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Autopreview markdown
" ----- VARIABLE -----
let $VIMBROWSER='open -a Brave\ Browser'
let $OPENBROWSER='nnoremap md :!'. $VIMBROWSER .' %:p<CR>'


" ----- .md OPENER -----
augroup OpenMdFile
  autocmd!
  autocmd BufEnter *.md echom "Press ml to Open .md File"
  " Trying to make a keybind to open brave from here
  autocmd BufEnter *.md exe $OPENBROWSER
augroup END
