" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"
" This is Silao's (writecoffee) Vim initialization file.
"
"
" --- Plugin list:
"       Vundle
"       YouCompleteMe
"       winManager
"           |- tagList 
"               |- ctags (copy .vim into $HOME/.vim/plugin or try sudo apt-get install)
"       easyColour
"       tagHighlight
"       cscope
"       eclim
"
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

"--------------------------------------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"--------------------------------------------------------------------------------------------------------------
"set term=ansi
syntax enable
syntax on

set nocompatible

"--------------------------------------------------------------------------------------------------------------
" Vundle
"
" Brief help
"   :BundleList          - list configured bundles
"   :BundleInstall(!)    - install(update) bundles
"   :BundleSearch(!) foo - search(or refresh cache first) for foo
"   :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"--------------------------------------------------------------------------------------------------------------
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-scripts/grep.vim'
Bundle 'vim-scripts/Conque-Shell'
Bundle 'vim-scripts/cscope.vim'
" ...
"
The following mappings are active when the prompt has focus:


"--------------------------------------------------------------------------------------------------------------
"  Command-T
"
"   <BS>        delete the character to the left of the cursor
"   <Del>       delete the character at the cursor
"   <Left>      move the cursor one character to the left
"   <C-h>       move the cursor one character to the left
"   <Right>     move the cursor one character to the right
"   <C-l>       move the cursor one character to the right
"   <C-a>       move the cursor to the start (left)
"   <C-e>       move the cursor to the end (right)
"   <C-u>       clear the contents of the prompt
"   <Tab>       change focus to the file listing
"
"   The following mappings are active when the file listing has focus:
"
"   <Tab>       change focus to the prompt
"
"   The following mappings are active when either the prompt or the file listing
"   has focus:
"
"   <CR>        open the selected file
"   <C-CR>      open the selected file in a new split window
"   <C-s>       open the selected file in a new split window
"   <C-v>       open the selected file in a new vertical split window
"   <C-t>       open the selected file in a new tab
"   <C-j>       select next file in the file listing
"   <C-n>       select next file in the file listing
"   <Down>      select next file in the file listing
"   <C-k>       select previous file in the file listing
"   <C-p>       select previous file in the file listing
"   <Up>        select previous file in the file listing
"   <C-f>       flush the cache (see |:CommandTFlush| for details)
"   <C-c>       cancel (dismisses file listing)
"--------------------------------------------------------------------------------------------------------------


filetype plugin indent on     " required!

"--------------------------------------------------------------------------------------------------------------
" EasyColour
"--------------------------------------------------------------------------------------------------------------
"let colors_name="bandit"
"hi Normal guibg=DarkBlue guifg=White ctermbg=4 
hi Statement ctermfg=3 gui=undercurl guifg=Yellow guibg=#f6e8d0 guisp=Red 
hi Keyword guifg=DarkBlue ctermfg=DarkBlue
hi Comment guifg=blue ctermfg=cyan gui=Bold cterm=bold 
hi PreProc ctermfg=magenta cterm=bold guifg=#FF00FF
hi Identifier ctermfg=DarkBlue cterm=bold guifg=BLUE
hi Constant ctermfg=cyan cterm=bold guifg=red

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
" Have Vim load indentation rules according to the detected filetype. Per
" default Debian Vim only load filetype specific plugins.
"--------------------------------------------------------------------------------------------------------------
if has("autocmd")
  filetype indent on
endif

set number
set title
set showmode
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

let java_mark_braces_in_parens_as_errors=1
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_java_lang_ids=1
let java_highlight_functions="style"
let java_minlines = 150
 

set showcmd            " Show (partial) command in status line.
set showmatch          " Show matching brackets.
"set ignorecase         " Do case insensitive matching
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a            " Enable mouse usage (all modes) in terminals
set hlsearch


nnoremap <silent><F9> :WMClose<CR> :tab split<CR>

"--------------------------------------------------------------------------------------------------------------
" Press F3 to Grep
"   :AS " split the window horizontally
"--------------------------------------------------------------------------------------------------------------
au filetype java let Grep_Default_Filelist='*.java'
au filetype c let Grep_Default_Filelist='*.c *.h *.cpp'
au filetype python let Grep_Default_Filelist='*.py'
nnoremap <silent> <F3> :Rgrep<CR>

"--------------------------------------------------------------------------------------------------------------
" Press F5 to switch between .c and .h file
"   :AS " split the window horizontally
"   :AV " split the window vertically
"   :AT " new tab 
"--------------------------------------------------------------------------------------------------------------

nnoremap <silent><F5> :A <CR>
nmap ,s :find %:t:r.c<CR>
nmap ,S :sf %:t:r.c<CR>
nmap ,h :find %:t:r.h<CR>
nmap ,H :sf %:t:r.h<CR>

"--------------------------------------------------------------------------------------------------------------
" Press F4 to toggle highlighting on/off, and show current value.
"--------------------------------------------------------------------------------------------------------------
noremap <F4> :set hlsearch! hlsearch?<CR>


"--------------------------------------------------------------------------------------------------------------
" Press F7 to compile/build and show errors 
"--------------------------------------------------------------------------------------------------------------
au filetype c noremap <F7> :w<CR> :make<CR> :cw<CR>


"--------------------------------------------------------------------------------------------------------------
" Conque-Shell (Conquer Terminal) 
"
"   :ConqueTerm bash
"   :ConqueTerm tab
"   :ConqueTerm mysql -h localhost -u joe -p sock_collection
"   :ConqueTerm Powershell.exe
"   :ConqueTerm C:\Python27\python.exe
"--------------------------------------------------------------------------------------------------------------
nnoremap ,c :ConqueTermSplit bash<CR>
nnoremap ,vc :ConqueTermVSplit bash<CR>
nnoremap ,q :q<CR>


"--------------------------------------------------------------------------------------------------------------
" ctags, tagList, winManager and vim buffer switching
"
"   Before installing winManager, should do "ctags -R" firstly building the ctags list.
"   <c-]> would navigate to the function definition.
"   <c-t> return back again to function call
"   :ta /^get   // navigate through a list of function names which start with 'get'
"   :ts         // shows the list
"--------------------------------------------------------------------------------------------------------------
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap WM :WMToggle<cr>
map <c-w><c-t> :FirstExplorerWindow<cr>
map <c-w><c-f> <c-w><c-t><c-w><c-j>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-n> :bn<cr>
map <c-w><c-p> :bp<cr>


"--------------------------------------------------------------------------------------------------------------
" type - to uncomment current line which has '//' in the beginning of the line
"--------------------------------------------------------------------------------------------------------------

"--------------------------------------------------------------------------------------------------------------
" type \lo to comment out current line with /* */ surrounded
"--------------------------------------------------------------------------------------------------------------
if match(expand("%:t"), ".py") != -1
    map \lo I#<Esc>
    noremap - :s/^\#//<CR>
else
    map \lo I/* <Esc>A */<Esc>
    noremap - :s/^\/\///<CR>
endif

"--------------------------------------------------------------------------------------------------------------
" type \bco<CR> to comment out the block with '//' or '"' in the beginning of the line
"--------------------------------------------------------------------------------------------------------------
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
" For local replace
nnoremap gr [{V%:s/

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

















" filetype plugin indent on
" set completeopt=longest,menu


" prerequisit tags
set nocp      
filetype plugin on      

" configure tags - add additional tags here or comment out not-used ones      
"set tags+=~/.vim/tags/include
set tags+=./tags
"set tags+=~/.vim/tags/gl      
"set tags+=~/.vim/tags/sdl      
"set tags+=~/.vim/tags/qt4      

"" build tags of your own project with CTRL+F12      
""map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>      
"noremap <F2> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>      
"inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>      
"
"" OmniCppComplete      
"let OmniCpp_NamespaceSearch = 1      
"let OmniCpp_GlobalScopeSearch = 1      
"let OmniCpp_ShowAccess = 1      
"let OmniCpp_MayCompleteDot = 1      
"let OmniCpp_MayCompleteArrow = 1      
"let OmniCpp_MayCompleteScope = 1      
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"
"
"" automatically open and close the popup menu / preview window      
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif      
"set completeopt=menuone,menu,longest,preview

"set include=^\\s*#\\s*include\ \\(<boost/\\)\\@!
"let g:clang_user_options='|| exit 0'
"let g:clang_user_auto=0
"let g:clang_use_library=1
"let g:clang_auto_user_options='path, .clang_complete'


set pastetoggle=<F2>

au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
au FileType xml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

"--------------------------------------------------------------------------------------------------------------
" eclim
"
" Suggested Mappings for java functionaities provided by eclim.
"
"-------------------------------------------------------------------------------------------------------------
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
