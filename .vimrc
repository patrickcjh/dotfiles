""" Install vim plug
if empty(glob('~/.vim/autoload/plug.vim')) && executable('curl')
  echom 'Installing Vim-Plug...'
  echom ''
  silent execute '!curl -fLo '.glob('~').'/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
set rtp+=~/.vim  "  fix windows support for .vim file


""" Plugins
call plug#begin()

Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'djoshea/vim-autoread'
Plug 'erietz/vim-terminator'
Plug 'farhanmustar/cg.vim'
Plug 'farhanmustar/gv.vim'
Plug 'preservim/tagbar'
Plug 'terryma/vim-smooth-scroll'
Plug 'ton/vim-bufsurf'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-ctrlspace/vim-ctrlspace'

" LSP
if !empty($USE_COC)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" Linting
Plug 'vim-autoformat/vim-autoformat'
if !empty($USE_ALE)
  Plug 'dense-analysis/ale'
endif

" HTML
Plug 'alvan/vim-closetag'
Plug 'AndrewRadev/tagalong.vim'
" Typescript
Plug 'leafgarland/typescript-vim'
" Astro
Plug 'wuelnerdotexe/vim-astro'
" Svelte
Plug 'leafOfTree/vim-svelte-plugin'
" Golang
Plug 'fatih/vim-go'
" Rust
Plug 'rust-lang/rust.vim'
" Terraform
Plug 'hashivim/vim-terraform'
" Puppet
Plug 'rodjek/vim-puppet'
" Markdown
Plug 'dhruvasagar/vim-table-mode'
" RestructuredText
Plug 'erisian/rest_tools'
" TOML
Plug 'cespare/vim-toml'
" Coverage result visualization
Plug 'google/vim-maktaba'
Plug 'google/vim-coverage'

call plug#end()


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

" Status line
set statusline=%<%f\ %h%m%r\ %{tagbar#currenttag('[%s]','','f','scoped-stl')}%=%-14.(%l,%c%V%)\ %P
" set statusline=%<%f\ %h%m%r\ %{tagbar#currenttag('[%s]','','f','scoped-stl')}\ %{tagbar#currenttagtype('(%s)','')}%=%-14.(%l,%c%V%)\ %P

" Quickfix folding
function! g:IsContinuation(lnum)
  let line = getline(a:lnum)
  return line[0:2] == '|| '
endfunction

au BufReadPost quickfix setlocal foldmethod=expr
au BufReadPost quickfix setlocal foldexpr=g:IsContinuation(v:lnum+1)?1:'<1'
au BufReadPost quickfix setlocal winheight=20
au BufReadPost quickfix setlocal winheight=1


""" Plugins settings

" vim-terminator
let g:terminator_split_fraction = 0.05
let g:terminator_runfile_map = {
  \ "rust": "if [ '$fileName ' = 'playground.rs ' ]; then " .
  \   "cargo playground | sed '1i note: Output\\n --> Cargo.toml:1:1' >&2; else " .
  \   "cargo clippy && echo 'note: Success\n --> Cargo.toml:1:1' >&2; fi",
  \ "svelte": "[ -n '$fileName ' ] && npm run lint >&2 && echo 'Success' >&2",
  \ }

" cg
let g:cg_comp_model = 'gpt-3.5-turbo-instruct'
let g:cg_chat_model = 'gpt-3.5-turbo'
let g:cg_api_key = getenv('OPENAI_API_KEY')

" tagbar
let g:tagbar_sort = 0

" vim-ctrlspace
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceUseMouseAndArrowsInTerm = 1
let g:CtrlSpaceIgnoredFiles = '\v(tmp|temp|build|dist|env|node_modules|platforms|plugins|www\/lib)[\/]'

" coc.nvim
let g:coc_disable_startup_warning = 1
let g:coc_global_extensions = ['coc-rust-analyzer']

" ale
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_linters = {'rust': ['analyzer']}

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
let g:formatters_markdown = ['prettier']
let g:formatters_scss = ['prettier']
let g:formatters_svelte = ['prettier']
let g:formatters_typescript = ['prettier']
" Formatter for golang
let g:formatters_go = ['goimports', 'gofmt_2']
" Formatter for rust
let g:formatdef_rustfmt = '"rustfmt --edition 2021"'
" Formatter for yaml
let g:formatters_yaml = ['prettier']

" HTML
" vim-closetag and tagalong
let g:closetag_filetypes = 'html,htmldjango,astro,svelte'
let g:tagalong_additional_filetypes = ['astro', 'svelte']

" vim-svelte-plugin
let g:vim_svelte_plugin_use_typescript = 1

" vim-go
let g:go_bin_path = $HOME . "/.vim/plugged/vim-go/bin"

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
nnoremap <Leader>gF :Ggrep! "\<<C-r><C-w>\>"<CR>:cclose<CR>:tab cw<CR>:top split<CR>
vnoremap <Leader>gF y:Ggrep! "<C-r>""<CR>:cclose<CR>:tab cw<CR>:top split<CR>

" Quickfix shortcuts
au BufReadPost quickfix nnoremap <buffer><lt> zc
au BufReadPost quickfix nnoremap <buffer>> zo
au BufReadPost quickfix nnoremap <buffer>= za
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap <c-k> :cprev<CR>
nnoremap <c-j> :cnext<CR>

" Diff shortcuts
noremap <leader>df :call DiffToggle()<CR>
noremap <leader>dt :call DiffToggleOne()<CR>

function! DiffToggle()
  let currwin=winnr()
  if &diff
    diffoff!
    windo setlocal nocursorbind
  else
    windo call DiffThis()
  endif
  " restores current window
  execute currwin . 'wincmd w'
endfunction

function! DiffThis()
  if &filetype != 'fugitive' && &filetype != 'qf'
    diffthis
  endif
endfunction

function! DiffToggleOne()
  if &diff
    diffoff
  else
    diffthis
  endif
endfunction

" Remove trailing whitespaces
noremap <leader>as :%s/\s\+$//e<CR>

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


""" Plugin shortcuts

" vim-terminator shortcuts
nmap <F10> <leader>rf

" tagbar shortcuts
nmap <F12> :TagbarToggle<CR>

" vim-smooth-scroll shortcuts
noremap <silent> <c-y> :call smooth_scroll#up(3, 0, 3)<CR>
noremap <silent> <c-e> :call smooth_scroll#down(3, 0, 3)<CR>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>

" vim-bufsurf shortcuts
nmap <c-p> <Plug>(buf-surf-back)
nmap <c-n> <Plug>(buf-surf-forward)

" vim-fugitive shortcuts
" make Gvd (Gvdiffsplit) always open to the left
command! -bar -bang -nargs=* -complete=customlist,fugitive#EditComplete Gvd exe fugitive#Diffsplit(0, <bang>0, "vertical leftabove <mods>", <q-args>)

" coc.nvim shortcuts

" Navigate diagnostics
if !empty($USE_COC)
  nmap <silent> <c-k> <Plug>(coc-diagnostic-prev)
  nmap <silent> <c-j> <Plug>(coc-diagnostic-next)
endif
nnoremap <leader>gg :CocDiagnostics<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gh <Plug>(coc-references)

" Use H to show documentation in preview window.
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" vim-autoformat shortcuts
noremap <leader>af :Autoformat<CR>

" vim-coverage shortcuts
nnoremap <Leader>cv :CoverageToggle<CR>
