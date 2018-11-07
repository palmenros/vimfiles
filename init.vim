"Init plug
call plug#begin('~/.config/nvim/plugged')

"Airline package
Plug 'vim-airline/vim-airline'

"Airline themes
Plug 'vim-airline/vim-airline-themes'

"Main theme
Plug 'morhetz/gruvbox'

"Nerd commenter
Plug 'scrooloose/nerdcommenter'

"CSS Completion
Plug 'othree/csscomplete.vim'

"Ctrlp
Plug 'ctrlpvim/ctrlp.vim'

"JsHint
Plug 'wookiehangover/jshint.vim'

"Install Tern
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }

"You complete me
Plug 'Valloric/YouCompleteMe'

"AutoPairs
Plug 'jiangmiao/auto-pairs'

"Nerd tree
Plug 'scrooloose/nerdtree'

"Arduino
Plug 'stevearc/vim-arduino'

"Emmet
Plug 'mattn/emmet-vim'

"CSS 3 Completion
Plug 'hail2u/vim-css3-syntax'

"Cpp better syntax highlightning
Plug 'octol/vim-cpp-enhanced-highlight'

"Vimball
Plug 'vim-scripts/Vimball'

"Processing support
Plug 'sophacles/vim-processing'

Plug 'palmenros/vim-cmake'

call plug#end()

"Enhance YCM JS completion with tern's smarts
autocmd FileType javascript setlocal omnifunc=tern#Complete

"YCM Global File
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

"Don't ask to load ycm python file
let g:ycm_confirm_extra_conf = 0

"Configure emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

function! s:expand_html_tab()
  " try to determine if we're within quotes or tags.
  " if so, assume we're in an emmet fill area.
  let line = getline('.')
  if col('.') < len(line)
    let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')

    if len(line) >= 2
      return "\<Plug>(emmet-move-next)"
    endif
  endif

  " go to next item in a popup menu.
  " if pumvisible()
  "  return \"\<C-n>"
  "endif

  " expand anything emmet thinks is expandable.
  " I'm not sure control ever reaches below this block.
  if emmet#isExpandable()
    return "\<Plug>(emmet-expand-abbr)"
  endif

  " return a regular tab character
  return "\<tab>"
endfunction

autocmd FileType html imap <buffer><expr><tab> <sid>expand_html_tab()

"Tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

"Show relative line numbers
set relativenumber
set number

"Show visual line at cusor line
set cursorline

au BufNewFile,BufRead *.ino set ft=cpp

set background=dark
set termguicolors

"Auto close YCM preview window after finishing insert
let g:ycm_autoclose_preview_window_after_insertion = 1

"Enable CSS completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

"Enable autopopup CSS completion
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^\t+', 're!:\s+', 're!@' ],
    \ }

"Makes scrolling fast
set lazyredraw

"Set you complete me keybindings
map <F12> :YcmCompleter GoTo <CR>
map <M-Return> :YcmCompleter FixIt <CR> :on <CR>

"Set NERDTree bindings
map <M-l> :NERDTreeToggle <CR>

colorscheme Tomorrow-Night

"Set Airline ln symbol

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"Fix airline character bug
let g:airline_symbols.maxlinenr = ' '

"Fix c++ highlight bug
let c_no_curly_error=1

"C++ syntax highlightning settings
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

"Set arduino
let g:arduino_dir='/usr/share/arduino'

command W w !sudo tee % > /dev/null

"Set single compile shortcuts
nmap <F4> :SCCompile<cr>
nmap <F5> :SCCompileRun<cr>

"Always enter insert mode when entering neovim terminal
autocmd TermOpen * startinsert
"Remove line numbers on terminal
autocmd TermOpen * setlocal nonumber norelativenumber

"Open split windows on bottom
set splitbelow

"Create SplitTerminal command
command! -nargs=* SplitTerminal split | terminal <args>

"Detect C++ standard file headers and set their filtype accordingly
au BufRead * if search('\M-*- C++ -*-', 'n', 1) | setlocal ft=cpp | endif

"If we are on processing, remap exec buttons to make
au BufNewFile,BufRead *.pde nmap <F4> :make<cr> 
au BufNewFile,BufRead *.pde nmap <F5> :make<cr> 

"Compatibility between Cmake and YCM
let g:cmake_export_compile_commands = 1
let g:cmake_ycm_symlinks = 1

augroup plugin_initialize
	autocmd!
	autocmd VimEnter * exec 'CMakeInit'
augroup END
