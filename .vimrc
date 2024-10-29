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

Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'djoshea/vim-autoread'
Plugin 'farhanmustar/gv.vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'vim-ctrlspace/vim-ctrlspace'

" Linting
Plugin 'vim-autoformat/vim-autoformat'

" HTML
Plugin 'alvan/vim-closetag'
Plugin 'AndrewRadev/tagalong.vim'
" Astro
Plugin 'wuelnerdotexe/vim-astro'
" Svelte
Plugin 'evanleck/vim-svelte'
" Golang
Plugin 'fatih/vim-go'
" Rust
Plugin 'rust-lang/rust.vim'
" Terraform
Plugin 'hashivim/vim-terraform'
" Puppet
Plugin 'rodjek/vim-puppet'
" Markdown
Plugin 'dhruvasagar/vim-table-mode'
" RestructuredText
Plugin 'erisian/rest_tools'
" Coverage result visualization
Plugin 'google/vim-maktaba'
Plugin 'google/vim-coverage'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype off
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


""" General settings

" Inherit aliases from ~/.bash_aliases
let $BASH_ENV = "~/.bash_aliases"


" Switch to a color scheme for dark background
set background=dark

" Fix diff color scheme
highlight DiffText term=reverse cterm=bold ctermbg=124 gui=bold guibg=Red3

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

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" Use tree view for netrw directory browsing
let g:netrw_liststyle=3

" Indentation config for html and htmldjango
let g:html_indent_inctags = 'body,head,tbody,p'


""" Plugins settings

" vim-ctrlspace
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceUseMouseAndArrowsInTerm = 1
let g:CtrlSpaceIgnoredFiles = '\v(tmp|temp|build|dist|env|node_modules|platforms|plugins|www\/lib)[\/]'

" vim-autoformat
let g:autoformat_verbosemode = 1
" Disable fallbacks
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
"! astyle version 2.05 or higher is required
let g:formatdef_astyle_cpp = '"astyle --mode=c --style=allman --indent=spaces=2 --pad-oper --unpad-paren --pad-header --convert-tabs"'
let g:formatters_cpp = ['astyle_cpp']
"! sudo apt-get install python-autopep8
let g:formatdef_autopep8 = '"autopep8 - -aa --max-line-length=199 --ignore=E128"'
let g:formatters_python = ['autopep8']
"! sudo npm install -g prettier
" Formatter for frontend frameworks
let g:formatdef_prettier = '"prettier --stdin-filepath ''".expand("%:p")."''".(&textwidth ? " --print-width ".&textwidth : "")." --tab-width=".shiftwidth()'  " bug fix: unquoted file path
let g:formatters_astro = ['prettier']
let g:formatters_css = ['prettier']
let g:formatters_html = ['prettier']
let g:formatters_javascript = ['prettier']
let g:formatters_json = ['prettier']
let g:formatters_scss = ['prettier']
let g:formatters_svelte = ['prettier']
let g:formatters_typescript = ['prettier']
" Formatter for golang
let g:formatters_go = ['goimports', 'gofmt_2']
" Formatter for rust
let g:formatdef_rustfmt = '"rustfmt --edition 2021"'

" HTML
" vim-closetag and tagalong
let g:closetag_filetypes = 'html,htmldjango,astro,svelte'
let g:tagalong_additional_filetypes = ['astro', 'svelte']

" vim-go
let g:go_bin_path = $HOME . "/.vim/bundle/vim-go/bin"

" rust.vim
let g:rustfmt_autosave = 1

" vim-puppet
let g:puppet_align_hashes = 0

" vim-table-mode
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='


""" Shortcuts

" Use CTRL-S for saving.
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<Esc>:update<CR>gi

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" Map CTRL-C to ESC, so that it triggers |InsertLeave| autocommand event
inoremap <C-C> <Esc>

" Insert mode shortcuts
inoremap II		<Esc>I
inoremap AA		<Esc>A
inoremap OO		<Esc>O

" Move by virtual lines when used without a count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Quickly select the text that was just pasted. This allows you to, e.g.,
" indent it after pasting.
noremap gV `[v`]

" Stay in visual mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv

" Make Y yank everything from the cursor to the end of the line. This makes Y
" act more like C or D because by default, Y yanks the current line (i.e. the
" same as yy).
noremap Y y$

" Avoid pressing shift key to switch to previous tab
noremap gr gT

" Allows you to easily replace the current word and all its occurrences.
nnoremap <Leader>rc :%s/\<<C-r><C-w>\>/
vnoremap <Leader>rc y:%s/<C-r>"/

" Allows you to easily change the current word and all occurrences to something
" else. The difference between this and the previous mapping is that the mapping
" below pre-fills the current word for you to change.
nnoremap <Leader>cc :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cc y:%s/<C-r>"/<C-r>"

" Allow you to easily search the current word.
nnoremap <Leader>ff /\<<C-r><C-w>\><CR>
vnoremap <Leader>ff y/<C-r>"<CR>
nnoremap <Leader>fg :lgrep -rn "\<<C-r><C-w>\>" <C-r>=expand('%:p:h')<CR>/
vnoremap <Leader>fg y:lgrep -rn "<C-r>"" <C-r>=expand('%:p:h')<CR>/
nnoremap <Leader>fh :lgrep -rn "\<<C-r><C-w>\>" <C-r>=expand('%:p:h')<CR>/<CR>:bo lw<CR>
vnoremap <Leader>fh y:lgrep -rn "<C-r>"" <C-r>=expand('%:p:h')<CR>/<CR>:bo lw<CR>
nnoremap <Leader>gf :Ggrep! "\<<C-r><C-w>\>"<CR>:bo cw<CR>
vnoremap <Leader>gf y:Ggrep! "<C-r>""<CR>:bo cw<CR>

" Diff shortcuts
noremap <leader>df :call DiffToggle()<CR>
function! DiffToggle()
  if &diff
    diffoff!
    windo setlocal nocursorbind
  else
    windo diffthis
  endif
:endfunction

" Smooth Scroll shortcuts
noremap <silent> <c-y> :call smooth_scroll#up(3, 0, 3)<CR>
noremap <silent> <c-e> :call smooth_scroll#down(3, 0, 3)<CR>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>

" AutoFormat shortcuts
noremap <leader>af :Autoformat<CR>

" Remove trailing whitespaces
noremap <leader>as :%s/\s\+$//e<CR>

" Fugitive shortcuts
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

" vim-coverage shortcuts
nnoremap <Leader>cv :CoverageToggle<CR>

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
