" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"
" This is Silao's (writecoffee) Vim initialization file.
"
"
"   Plugin list:
"       Vundle
"       YouCompleteMe
"       winManager
"           |- tagList
"               |- ctags
"           |- miniBuffer
"           |- nerdtree
"       tagHighlight
"       CommandT 
"       ConqueTerminal (ConqueShell)
"       vim-airline (unused)
"       Eclim
"
"   Command-T
"       Install:
"           -- Must install ruby-dev/rake package before invoke "rake make"
"           -- Need a vim version with Ruby support
"           -- "cd ~/.vim/ruby/command-t; ruby extconf/rb; make"
"       Shortcuts: 
"           ** Mappings thtat are active when the prompt has focus:
"           -- <BS>        delete the character to the left of the cursor
"           -- <Del>       delete the character at the cursor
"           -- <Left>      move the cursor one character to the left
"           -- <C-h>       move the cursor one character to the left
"           -- <Right>     move the cursor one character to the right
"           -- <C-l>       move the cursor one character to the right
"           -- <C-a>       move the cursor to the start (left)
"           -- <C-e>       move the cursor to the end (right)
"           -- <C-u>       clear the contents of the prompt
"           -- <Tab>       change focus to the file listing
"
"           ** Mappings that are active when the file listing has focus:
"           -- <Tab>       change focus to the prompt
"
"           ** Mappings are active when either the prompt or the file listing has focus:
"           -- <C-CR>      open the selected file in a new split window
"           -- <C-s>       open the selected file in a new split window
"           -- <C-v>       open the selected file in a new vertical split window
"           -- <C-t>       open the selected file in a new tab
"           -- <C-j>       select next file in the file listing
"           -- <C-n>       select next file in the file listing
"           -- <C-k>       select previous file in the file listing
"           -- <C-p>       select previous file in the file listing
"           -- <C-f>       flush the cache (see |:CommandTFlush| for details)
"
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

"--------------------------------------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"--------------------------------------------------------------------------------------------------------------
"set term=ansi
syntax enable
syntax on

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set nocompatible
set nocp      
filetype plugin on      



"--------------------------------------------------------------------------------------------------------------
" Vundle
"
" Brief help
"   :BundleList          - list configured bundles
"   :BundleInstall(!)    - install(update) bundles
"   :BundleSearch(!) foo - search(or refresh cache first) for foo
"   :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
"--------------------------------------------------------------------------------------------------------------

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'wincent/Command-T'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-scripts/grep.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'wlangstroth/vim-racket'
Bundle 'vim-scripts/Conque-Shell'
Bundle 'vim-scripts/winmanager'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/ctags.vim'
" Bundle 'bling/vim-airline'


"--------------------------------------------------------------------------------------------------------------
" Most Comfortable Color Scheme
"   
"   -- Adjustable according to language and shell
"   -- New color would be added due to plugins
"--------------------------------------------------------------------------------------------------------------

hi Normal                   guifg=gray guibg=#212904 
hi Statement                ctermfg=32 cterm=bold guifg=DarkYellow
hi Keyword                  guifg=DarkBlue ctermfg=DarkBlue
hi Comment                  guifg=yellow ctermfg=yellow
hi PreProc                  ctermfg=magenta cterm=bold guifg=#FF00FF
hi Identifier               ctermfg=08342 cterm=bold guifg=BLUE
hi Constant                 ctermfg=cyan cterm=none guifg=red
hi Special                  ctermfg=gray ctermbg=NONE
hi Visual                   ctermfg=none ctermbg=darkgrey
hi Label                    ctermfg=DarkBlue ctermbg=none
hi Normal                   ctermfg=222 ctermbg=NONE"999
hi Search                   ctermbg=yellow ctermfg=0a234e cterm=bold
hi CursorLine               cterm=NONE ctermbg=black ctermfg=none guibg=darkred guifg=white
hi CursorColumn             cterm=NONE ctermbg=black ctermfg=none guibg=darkred guifg=white

hi MBENormal                ctermfg=808080 guibg=fg
hi MBEChanged               ctermfg=66631A guibg=fg
hi MBEVisibleNormal         ctermfg=9234AB guibg=fg
hi MBEVisibleChanged        ctermfg=72933A guibg=fg
hi MBEVisibleActiveNormal   ctermfg=11334A guibg=fg
hi MBEVisibleActiveChanged  ctermfg=7343EA guibg=fg

"--------------------------------------------------------------------------------------------------------------
" allow backspacing over everything in insert mode
"--------------------------------------------------------------------------------------------------------------
set backspace=indent,eol,start

"--------------------------------------------------------------------------------------------------------------
" Have Vim jump to the last position when reopening a file
"--------------------------------------------------------------------------------------------------------------
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif


"--------------------------------------------------------------------------------------------------------------
" Java
" 
"   -- Syntax highlight settings
"   -- <F6>
"           +o Import undefined types, remove unused imports, sort and format imports.
"           +i View implementation/overridable methods from super classes and implemented interface
"           +h View the type hierarchy tree
"
"   -- Necessary change in eclipse key binding
"           Alt + 5     (debug) Step Into
"           Alt + 6     (debug) Step Over
"           Alt + 7     (debug) Step Return
"           Alt + R     (debug) Run to Line
"           Ctrl + F11  (window) Run
"           F11         (window) Debug
"--------------------------------------------------------------------------------------------------------------
let java_mark_braces_in_parens_as_errors=1
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_java_lang_ids=1
let java_highlight_functions="style"
let java_minlines = 150

au filetype java nnoremap <F6>o     :JavaImportOrganize<CR>
au filetype java nnoremap <F6>i     :JavaImpl<CR>
au filetype java nnoremap <F6>h     :JavaHierarchy<CR>
au filetype java nnoremap <F6>sd    :JavaDocSearch<CR>
au filetype java nnoremap <F6>i     :JavaImport<CR>
au filetype java nnoremap <F6>l     :JavaImpl<CR>
au filetype java nnoremap <F8>      :JavaSearch

 
"--------------------------------------------------------------------------------------------------------------
" <F3>
"
"   RGrep plugin reserved!
"       :cnext/cprev        -- jump to the next/prev output file
"       :colder/cnewer      -- go between multiple grep quickfix output window
"       :copen              -- open the quickfix window again
"--------------------------------------------------------------------------------------------------------------
au filetype java    let Grep_Default_Filelist='*.java'
au filetype c       let Grep_Default_Filelist='*.c *.h *.cpp'
au filetype python  let Grep_Default_Filelist='*.py'

nnoremap <silent> <F3> :Rgrep<CR>


"--------------------------------------------------------------------------------------------------------------
" ConqueTerminal shortcuts to open a new bash buffer
"--------------------------------------------------------------------------------------------------------------
nnoremap ,c :ConqueTermSplit bash<CR>
nnoremap ,vc :ConqueTermVSplit bash<CR>

"--------------------------------------------------------------------------------------------------------------
" ctags, tagList, winManager, nerdtree and vim buffer switching
"
"   "sudo apt-get install ctags"
"   Before installing winManager, should do "ctags -R" firstly building the ctags list.
"   <c-]> would navigate to the function definition.
"   <c-t> return back again to function call
"
"   Shortcuts:
"       -- navigate through a list of function names which start with 'get'
"               :ta /^get
"
"       -- shows the list
"               :ts
"
"--------------------------------------------------------------------------------------------------------------
map <c-w><c-t> :FirstExplorerWindow<cr>
map <c-w><c-f> <c-w><c-t><c-w><c-j>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-n> :bn<cr>
map <c-w><c-p> :bp<cr>

let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMoreThanOne=0

let g:NERDTree_title='NERD Tree'
let g:winManagerWindowLayout="NERDTree|TagList"

function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction

nmap WM :WMToggle<CR>


"--------------------------------------------------------------------------------------------------------------
"      * * *
"    *
"   *
"   *
"    *
"      * * *
"
"   -- Comment Shortcuts
"       <F7>        : compile and then show error in quickfix window
"       \lo         : to comment out current line with /* */ surrounded
"       \bco<CR>    : to comment out the block with '//' or '"' in the beginning of the line
"
"--------------------------------------------------------------------------------------------------------------
au filetype c noremap <F7> :w<CR> :make<CR> :cw<CR>

if match(expand("%:t"), ".py") != -1
    map \lo I#<Esc>
    noremap - :s/^\#//<CR>
else
    map \lo I/* <Esc>A */<Esc>
    noremap - :s/^\/\///<CR>
endif

function! BlockComment()
    " deal with filetypes that don't have block comments 
    let fileName = expand("%:t")
    echo fileName

    if fileName =~ "\.py" || fileName =~ "\.sh" || fileName =~ "\.pl"
        execute "normal I# "
        return
    elseif fileName =~ "\.vim"
        execute 'normal I" '
        return
    endif

    " for c-style block comments (should work for javascript)
    let topLine = line("'<")

    " the + 1 is because we're inserting a new line above the top line
    let bottomLine = line("'>") + 1

    " this gets called as a range, so if we've already done it once we need to
    " bail
    let checkLine = getline(topLine - 1)
    if (checkLine =~ '\/\*')
        return
    endif

    let topString = "normal " . topLine . "GO/*"
    let bottomString = "normal " . bottomLine . "Go*/"

    execute topString
    execute bottomString
endfunction

vmap <Leader>fco<CR> :call BlockComment()<CR>


"--------------------------------------------------------------------------------------------------------------
"      * * *
"    *
"   *
"   *
"    *
"      * * *
"
" cscope settings:
"
" ----------------- key mappings
"
" The following maps all invoke one of the following cscope search types:
"
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
"
"--------------------------------------------------------------------------------------------------------------
if has("cscope")

    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	

    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left
    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif


"--------------------------------------------------------------------------------------------------------------
" Miscallenous Settings
"--------------------------------------------------------------------------------------------------------------

set showcmd            " Show (partial) command in status line.
set showmatch          " Show matching brackets.
"set ignorecase         " Do case insensitive matching
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a            " Enable mouse usage (all modes) in terminals
set hlsearch
set number
set title
set showmode
set expandtab
"set shiftwidth=4
"set softtabstop=4
"set autoindent
"set smartindent

nnoremap <silent><F9>   :WMClose<CR> :tab split<CR>
nnoremap <Leader>c      :set cursorline! cursorcolumn!<CR>
nnoremap ,q             :q<CR>
nnoremap ,s             :w<CR>
noremap <F4>            :set hlsearch! hlsearch?<CR>
noremap ,w              :cclose<CR>

if has("autocmd")
  filetype indent on
endif

au filetype python setlocal expandtab shiftwidth=4 softtabstop=4

au BufReadPost *.arr set filetype=pyret
au BufReadPost *.arr set shiftwidth=2
au BufReadPost *.arr set tabstop=2
au BufReadPost *.arr set softtabstop=2

let tlist_pyret_settings = 'pyret;g:global;f:function;h:helper;d:data;t:test'

let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
let tlist_make_settings  = 'make;m:makros;t:targets'
