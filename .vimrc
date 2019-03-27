"
" vimrc
"
" ================ plugin manager   {{{
set nocompatible
filetype off
execute pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

"}}}
" ================ General Config   {{{

set backspace=indent,eol,start  "Allow backspace in insert mode
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set hidden
set cursorline
set modeline
set mouse=n
set encoding=utf-8
set isfname+=32
set showmatch           	    "highlight matching [{{{()}}}]
set lazyredraw
set tw=80


set t_Co=256
"color wombat256mod

set title titlestring=
set completeopt-=preview

set splitbelow splitright


"command history undo backup
set history=1000
set undofile     " hello world
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set viminfo='100000

" Scrolling
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=0
set sidescroll=0


" Folds
set foldenable          " enable folding
set foldlevelstart=0    " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=marker   " fold based on marker
" toggle folding
nnoremap <space> za
" unfold all
nnoremap <F7> zR
" fold all
nnoremap <F8> :foldc!<CR>

" Search
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" relative numbers
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


"}}}
" ================ leader   {{{

let mapleader=";"
noremap <leader><leader> <C-^>
noremap <leader>cc :<ESC>gg"+yG<ESC>
noremap <leader>y yiW

" }}}
" ================ arabic/english   {{{

" Switch to English - mapping
nnoremap <Leader>z :<C-U>call EngType()<CR>
" Switch to Arabic - mapping
nnoremap <Leader>a :<C-U>call AraType()<CR>

" Switch to English - function
function! EngType()
  " To switch back from Arabic
  set norightleft
endfunction

" Switch to Arabic - function
function! AraType()
  set rightleft
  set arabicshape
  set arabic
endfunction

" }}}
" ================ Indentation   {{{

set cindent
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set shiftround

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines

" }}}
" ================ Completion   {{{

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" }}}
" ================ highlighting and cursor   {{{


:hi CursorLine 		ctermbg=7          ctermfg=black     term=bold cterm=bold
:hi CursorColumn    ctermbg=darkred    ctermfg=white    term=bold cterm=bold
:hi Normal  	  	ctermbg=black      ctermfg=none     term=bold cterm=bold
:hi Visual  	  	ctermbg=lightred   ctermfg=black    term=bold cterm=bold
:hi Folded 	    	ctermbg=black      ctermfg=red      term=bold cterm=bold
:hi FoldColumn 		ctermbg=green      ctermfg=yellow   term=bold cterm=bold
:hi Search          ctermbg=yellow     ctermfg=black    term=bold cterm=bold

":hi MyGroup cterm=bold
":match MyGroup /./

"make block cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" }}}
" ================ differnt settings   {{{

" open file externally
nnoremap <leader>o :silent !xdg-open <cfile>&<CR>

"leader n highlight current word and search it
:nnoremap <leader>n :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" set current directory to the directory of the current file
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Quick write session with F2
map <F2> :mksession! ~/.vim/vim_session <cr>

" And load session with F3
map <F3> :source ~/.vim/vim_session <cr>

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e
" remember last position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" }}}
" ================ mouvements and buffers    {{{

"f5 to show buffers
:nnoremap <F5> :buffers<CR>:buffer<Space>
nmap <F6> :TagbarToggle<CR>

"window mouvements
nnoremap <down> 	<C-W><C-J>
nnoremap <up> 		<C-W><C-K>
nnoremap <right> 	<C-W><C-L>
nnoremap <left> 	<C-W><C-H>

" ================ moving around
nmap <silent> <A-Up> 	:wincmd k<CR>
nmap <silent> <A-Down> 	:wincmd j<CR>
nmap <silent> <A-Left> 	:wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" ================ moving blocks of code
vnoremap < <gv
vnoremap > >gv

" cycle through buffers
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" this function is a great way to open old files
function! Output()
    enew | 0put =v:oldfiles| nnoremap <buffer> <CR> :e <C-r>=getline('.')<CR><CR>|normal gg<CR>
    setlocal buftype=nofile bufhidden=wipe noswapfile nowrap
    "setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
endfunction

:command! Browse call Output()
:command! Mm     call Output()
:command! MM     call Output()

" ????
"command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

" ????
"if has("autocmd")
"    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" }}}

" ================ Ranger   {{{

"let g:ranger_map_keys = 0

" add this line if you use NERDTree
let g:NERDTreeHijackNetrw = 0

" open ranger when vim open a directory
let g:ranger_replace_netrw = 1


" }}}
" ================ nerd tree   {{{

let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.o$', '\.so$',
\ '\.a$', '\.swp',  '*\.swp', '\.swo', '\.swn', '\.swh',
\ '\.swm', '\.swl', '\.swk', '\.sw*$',  '[a-zA-Z]*egg[a-zA-Z]*',
\ '.DS_Store']

let NERDTreeShowHidden=1
let g:NERDTreeWinPos="left"
let g:NERDTreeDirArrows=1
map <C-t> :NERDTreeToggle %<CR>

" }}}
" ================ YouCompleteMe   {{{

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
"set tags+=~/.vim/tags/testtags

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_key_list_accept_completion = ['<C-y>']

" Additional YouCompleteMe config.
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_server_python_interpreter='python3'
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Disable unhelpful semantic completions.
"let g:ycm_filetype_specific_completion_to_disable = {
"            \   'c': 1,
"            \   'gitcommit': 1,
"            \   'haskell': 1,
"            \   'javascript': 1,
"            \   'ruby': 1
"            \ }
"
let g:ycm_semantic_triggers = {
            \   'haskell': [
            \     '.',
            \     '(',
            \     ',',
            \     ', '
            \   ]
            \ }

" Same as default, but with "markdown" and "text" removed.
let g:ycm_filetype_blacklist = {
            \   'notes': 1,
            \   'unite': 1,
            \   'tagbar': 1,
            \   'pandoc': 1,
            \   'qf': 1,
            \   'vimwiki': 1,
            \   'infolog': 1,
            \   'mail': 1
            \ }


" }}}
" ================ dragvisuals   {{{

runtime plugin/dragvisuals.vim

vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" }}}
" ================ HardMode   {{{

"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call EasyMode()<CR>
nnoremap <leader>H <Esc>:call HardMode()<CR>

" }}}
" ================ CommandT   {{{

let g:CommandTMaxFiles=2000000

" }}}
" ================ fzf   {{{

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" local commands

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Search and switch buffers
nmap <leader>b :Buffers<cr>
" Find files by name under the current directory
nmap <leader>f :Files<cr>
" Find files by name under the home directory
nmap <leader>h :Files ~/<cr>
" Search content in the current file
nmap <leader>l :BLines<cr>

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({{{'left': '15%'}}})

"Custom statusline

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" }}}
" ================ ultisnips   {{{

    " YouCompleteMe and UltiSnips compatibility.
    let g:UltiSnipsExpandTrigger = '<Tab>'
    let g:UltiSnipsJumpForwardTrigger = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

    " Prevent UltiSnips from removing our carefully-crafted mappings.
    let g:UltiSnipsMappingsToIgnore = ['autocomplete']

    "" Additional UltiSnips config.
    "let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips'
    "let g:UltiSnipsSnippetDirectories = ['ultisnips']
" }}}
" ================ vim-latex-preview   {{{
    let g:livepreview_previewer = 'okular'
    let g:livepreview_engine = 'xelatex'
    let g:livepreview_cursorhold_recompile = 0
" }}}
"  ================ vim prettier {{{
" max line length that prettier will wrap on
" Prettier default: 80
let g:prettier#config#print_width = 120

" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 4

" use tabs over spaces
" Prettier default: false
let g:prettier#config#use_tabs = 'true'

" print semicolons
" Prettier default: true
let g:prettier#config#semi = 'true'

" single quotes over double quotes
" Prettier default: false
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'false'

" put > on the last line instead of new line
" Prettier default: false
let g:prettier#config#jsx_bracket_same_line = 'true'

" avoid|always
" Prettier default: avoid
let g:prettier#config#arrow_parens = 'always'

" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'all'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown
" Prettier default: babylon
let g:prettier#config#parser = 'flow'

" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'

" always|never|preserve
let g:prettier#config#prose_wrap = 'preserve'

" css|strict|ignore
let g:prettier#config#html_whitespace_sensitivity = 'css'

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

"  }}}

" ================ my snippets   {{{
     "inoremap <leader><leader> <esc>/<++><Enter>"_c4l
     "vnoremap <leader><leader> <esc>/<++><Enter>"_c4l

    " ===== php   {{{
        autocmd FileType php setlocal foldmethod=syntax
        autocmd FileType php inoremap ;bb <ESC>:0r ~/.vim/mysnippets/php/b1<CR>
    " }}}
    " ===== HTML   {{{
    "autocmd FileType html setlocal foldmethod=syntax
    autocmd FileType html inoremap ;bb <ESC>:0r ~/.vim/mysnippets/php/b1<CR>
    autocmd FileType html inoremap ;b <b></b><Space><++><Esc>FbT>i
    autocmd FileType html inoremap ;it <em></em><Space><++><Esc>FeT>i
    autocmd FileType html inoremap ;1 <h1></h1><Enter><Enter><++><Esc>2kf<i
    autocmd FileType html inoremap ;2 <h2></h2><Enter><Enter><++><Esc>2kf<i
    autocmd FileType html inoremap ;3 <h3></h3><Enter><Enter><++><Esc>2kf<i
    autocmd FileType html inoremap ;p <p></p><Enter><Enter><++><Esc>02kf>a
    autocmd FileType html inoremap ;a <a<Space>href=""><++></a><Space><++><Esc>14hi
    autocmd FileType html inoremap ;e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
    autocmd FileType html inoremap ;ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
    autocmd FileType html inoremap ;li <Esc>o<li></li><Esc>F>a
    autocmd FileType html inoremap ;ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
    autocmd FileType html inoremap ;im <img src="" alt="<++>"><++><esc>Fcf"a
    autocmd FileType html inoremap ;td <td></td><++><Esc>Fdcit
    autocmd FileType html inoremap ;tr <tr></tr><Enter><++><Esc>kf<i
    autocmd FileType html inoremap ;th <th></th><++><Esc>Fhcit
    autocmd FileType html inoremap ;tab <table><Enter></table><Esc>O
    autocmd FileType html inoremap ;gr <font color="green"></font><Esc>F>a
    autocmd FileType html inoremap ;rd <font color="red"></font><Esc>F>a
    autocmd FileType html inoremap ;yl <font color="yellow"></font><Esc>F>a
    autocmd FileType html inoremap ;dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
    autocmd FileType html inoremap ;dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
    autocmd FileType html inoremap &<space> &amp;<space>
    autocmd FileType html inoremap á &aacute;
    autocmd FileType html inoremap é &eacute;
    autocmd FileType html inoremap í &iacute;
    autocmd FileType html inoremap ó &oacute;
    autocmd FileType html inoremap ú &uacute;
    autocmd FileType html inoremap ä &auml;
    autocmd FileType html inoremap ë &euml;
    autocmd FileType html inoremap ï &iuml;
    autocmd FileType html inoremap ö &ouml;
    autocmd FileType html inoremap ü &uuml;
    autocmd FileType html inoremap ã &atilde;
    autocmd FileType html inoremap ẽ &etilde;
    autocmd FileType html inoremap ĩ &itilde;
    autocmd FileType html inoremap õ &otilde;
    autocmd FileType html inoremap ũ &utilde;
    autocmd FileType html inoremap ñ &ntilde;
    autocmd FileType html inoremap à &agrave;
    autocmd FileType html inoremap è &egrave;
    autocmd FileType html inoremap ì &igrave;
    autocmd FileType html inoremap ò &ograve;
    autocmd FileType html inoremap ù &ugrave;

    " }}}
    "  ===== python   {{{

    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python setlocal foldnestmax=1
    autocmd FileType python setlocal colorcolumn=0
    "autocmd FileType python setlocal completeopt-=preview
    autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
    autocmd FileType python inoremap ;ma <ESC>:r ~/.vim/mysnippets/python/main<CR>
    autocmd FileType python inoremap ;sh <ESC>:0r ~/.vim/mysnippets/python/shabang<CR>

    " ================ python-mode
    " cancel it
    " let g:pymode_rope_completion = 0
    let g:pymode_lint = 0
    " ================ jedi

    let g:jedi#goto_command = "<leader>d"
    let g:jedi#goto_assignments_command = "<leader>g"
    let g:jedi#goto_definitions_command = "enew"
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#completions_command = "<C-Space>"
    let g:jedi#rename_command = "<leader>r"


    "  }}}
    "  ===== latex   {{{

    set grepprg=grep\ -nH\ $*
    let g:tex_flavor = "latex"
    set runtimepath+=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
    let g:Tex_DefaultTargetFormat = 'pdf'
    let g:Tex_CompileRule_pdf = 'latexmk -pdf -pv -g'
    let g:Tex_UseMakefile=1
    let g:Tex_ViewRule_pdf='zathura'
    let g:Tex_Menus=0
    let g:Tex_FoldedCommands='ctable'

    autocmd FileType tex map <leader>c  :LLPStartPreview<CR>

    "function CompileLatexPDF()
    "    !xelatex %
    "endfunction
    "
    "function OpenLatexPDF()
    "    !okular '%:r'.'pdf' &
    "endfunction
    "
    "" Open corresponding .pdf
    "  map <leader>p  :call OpenLatexPDF()<CR><CR>
    "  :command! OpenLatexPDF call OpenLatexPDF()<CR><CR><CR>
    "
    "" Compile document
    "	"map <leader>c  :call Tex_RunLaTeX()<CR>
    "  ":command! CompileTex call Tex_RunLaTeX()
    "  map <leader>c  :call CompileLatexPDF()<CR>
    "  :command! CompileTex call CompileLatexPDF()
    "

    " Word count:
    autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
    autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
    " Compile document using xelatex:
    autocmd FileType tex inoremap <F5> <Esc>:!xelatex<space><c-r>%<Enter>a
    autocmd FileType tex nnoremap <F5> :!xelatex<space><c-r>%<Enter>
    " Code snippets
    autocmd FileType tex inoremap ;na <ESC>:r ~/.vim/mysnippets/latex/new<CR>
    autocmd FileType tex inoremap ;nf <ESC>:r ~/.vim/mysnippets/latex/newf<CR>
    autocmd FileType tex inoremap ;if <ESC>:r ~/.vim/mysnippets/latex/newif<CR>
    " Code snippets
    autocmd FileType tex inoremap ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
    autocmd FileType tex inoremap ;fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
    autocmd FileType tex inoremap ;exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
    autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
    autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
    autocmd FileType tex vnoremap ; <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
    autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
    autocmd FileType tex inoremap ;ct \textcite{}<++><Esc>T{i
    autocmd FileType tex inoremap ;cp \parencite{}<++><Esc>T{i
    autocmd FileType tex inoremap ;glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
    autocmd FileType tex inoremap ;x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
    autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap ;li <Enter>\item<Space>
    autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ;tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
    autocmd FileType tex inoremap ;ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
    autocmd FileType tex inoremap ;can \cand{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ;con \const{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ;v \vio{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ;a \href{}{<++>}<Space><++><Esc>2T{i
    autocmd FileType tex inoremap ;sc \textsc{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ;chap \chapter{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ;sec \section{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ;st <Esc>F{i*<Esc>f}i
    autocmd FileType tex inoremap ;beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
    autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
    autocmd FileType tex nnoremap ;up /usepackage<Enter>o\usepackage{}<Esc>i
    autocmd FileType tex inoremap ;tt \texttt{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ;bt {\blindtext}
    autocmd FileType tex inoremap ;nu $\varnothing$
    autocmd FileType tex inoremap ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
    autocmd FileType tex inoremap ;rn (\ref{})<++><Esc>F}i

    "  }}}


" }}}
