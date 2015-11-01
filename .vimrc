set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Doxygen documentação
Plugin 'vim-scripts/DoxygenToolkit.vim'

"autocomplete
Plugin 'Valloric/YouCompleteMe'

"tagbar maneiro
Plugin 'majutsushi/tagbar'

"nerdtree
Plugin 'scrooloose/nerdtree'

"c++ highlight
Plugin 'octol/vim-cpp-enhanced-highlight'

"plugins to NODE.JS
Plugin 'moll/vim-node'

"tabular plugin
Plugin 'godlygeek/tabular'

"JavaScript syntax
Plugin 'jelera/vim-javascript-syntax'

"html5/css3 
Plugin 'wavded/vim-stylus'

"check syntax
Plugin 'scrooloose/syntastic'

"jade highlight
Plugin 'digitaltoad/vim-jade'

"snippet 
Plugin 'SirVer/ultisnips'

"theme landscape
Plugin 'itchyny/landscape.vim'

"custom bar
Plugin 'itchyny/lightline.vim'

"git 
Plugin 'tpope/vim-fugitive'

"Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"
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
"
"
"==========================line Number===================================="
set number

"==========================indent========================================="
set tabstop=4
set softtabstop=4
set shiftwidth=4

syntax enable
"=========================Color==========================================="
colorscheme landscape 

"=========================Tagbar=========================================="
autocmd VimEnter * nested :TagbarOpen

"=========================vim-cpp-enhanced-highlight======================"
let g:cpp_experimental_template_highlight = 1
let g:cpp_class_scope_highlight = 1

"=========================ClangFormat====================================="
map <C-K> :pyf /home/fsantana/opt_local/clang+llvm/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /home/fsantana/opt_local/clang+llvm/share/clang/clang-format.py<cr>

"=========================ultisnips======================================="

let g:UltiSnipsExpandTrigger="<c-f>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/bundle/ultisnips/snipdir']

"=========================LightLine======================================="
set encoding=utf-8
scriptencoding utf-8

let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
	  \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
	  \   'modified': 'LightLineModified',
	  \   'readonly': 'LightLineReadonly',
	  \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineFugitive()
  if  expand('%:t') !~? 'Tagbar\|NERD' && &ft !~? 'vimfiler' && exists("*fugitive#head")
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightLineFilename()
	  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
	         \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
	         \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
let g:ctrlp_status_func = {
	  \ 'main': 'CtrlPStatusFunc_1',
	  \ 'prog': 'CtrlPStatusFunc_2',
	  \ }
function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
	  return lightline#statusline(0)
endfunction
function! CtrlPStatusFunc_2(str)
	  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
	let g:lightline.fname = a:fname
	  return lightline#statusline(0)
endfunction
