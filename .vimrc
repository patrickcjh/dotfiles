set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'tpope/vim-sensible'
Plugin 'djoshea/vim-autoread'
Plugin 'szw/vim-ctrlspace'
Plugin 'taketwo/vim-ros'
Plugin 'Chiel92/vim-autoformat'
"Plugin 'scrooloose/syntastic'
"Plugin 'justmao945/vim-clang'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'pyclewn'
Plugin 'tpope/vim-fugitive'
Plugin 'ludovicchabant/vim-lawrencium'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Switch to a color scheme for dark background
set background=dark

" Change auto-complete color scheme
highlight Pmenu ctermbg=brown ctermfg=black
highlight PmenuSel ctermbg=green


" Prevent auto-indenting of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Let Vim jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Open each buffer in its own tabpage
"au BufAdd,BufNewFile * nested tab sball


" Some tuning
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set mouse=a			" Enable mouse usage (all modes)
set ruler
set number
set splitbelow
set splitright
set hidden
" Tabs settings
set expandtab
set softtabstop=0
set shiftwidth=2
set tabstop=2
" Make tab completion in command mode behave like in Bash
set wildmenu
set wildmode=longest,list
set wildignore=*.o,*.class,*.swp,*.swo,*.pyc

" Use tree view for netrw directory browsing
let g:netrw_liststyle=3

" CtrlSpace config
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceUseMouseAndArrowsInTerm = 1
let g:CtrlSpaceIgnoredFiles = '\v(tmp|temp|build|node_modules|platforms|plugins|www\/lib)[\/]'

" AutoFormat config
let g:formatprg_cpp = "astyle"
let g:formatprg_args_cpp = "--style=allman --indent=spaces=2 --pad-oper --unpad-paren --pad-header --convert-tabs"
let g:formatprg_python = "autopep8"
let g:formatprg_args_python = "-aa --max-line-length=199 --ignore=E128 -"

" YouCompleteMe config
let g:ycm_always_populate_location_list = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion = ['<C-n>']		" Disable <Down> and <TAB> key
let g:ycm_key_list_previous_completion = ['<C-p>']	" Disable <Up> and <S-TAB> key

" Associates triggers with ROS filetypes
let g:ycm_semantic_triggers = {
\   'roslaunch': ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction': ['re!^'],
\ }

" SuperTab and UltiSnips config
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger = '<TAB>'
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'


" Import mswin key mappings and behavior.
source $VIMRUNTIME/mswin.vim

" Unmap CTRL-Y(redo) to its original scroll
nunmap <C-Y>
iunmap <C-Y>

" Tap CTRL-S twice for save and exit, also in Insert mode
noremap <C-S><C-S>		:wq<CR>
vnoremap <C-S><C-S>		<C-C>:wq<CR>
inoremap <C-S><C-S>		<C-O>:wq<CR>

" Tap CTRL-W twice for exit, also in Insert mode
"noremap <C-W><C-W>		:q!<CR>
"vnoremap <C-W><C-W>		<C-C>:q!<CR>
"inoremap <C-W><C-W>		<C-O>:q!<CR>

" Insert mode shortcuts
inoremap II		<Esc>I
inoremap AA		<Esc>A
inoremap OO		<Esc>O

" AutoFormat shortcuts
"noremap <F3> :Autoformat<CR><CR>
noremap <leader>af :Autoformat<CR>

" YouCompleteMe shortcuts
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gr :YcmForceCompileAndDiagnostics<CR>

" Hard mode - disable arrow keys
map <Up>	 :echo "no!"<cr>
map <Down>	 :echo "no!"<cr>
map <Left>	 :echo "no!"<cr>
map <Right>	 :echo "no!"<cr>
inoremap <Up>		<NOP>
inoremap <Down>		<NOP>
inoremap <Left>		<NOP>
inoremap <Right>	<NOP>

" Disable Execute Mode
nmap Q	<NOP>

