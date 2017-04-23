" makes vim load plugins automatically
execute pathogen#infect()

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
syntax on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

nnoremap <space> <nop>
let mapleader="\<space>"
" below setting is needed for LaTeX-box -> because it is a filetype plugin
let maplocalleader="\<space>"

set number

" search options
set ignorecase
set smartcase

" no gui widgets
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

"set winaltkeys=no

" expand %% to current directory
cabbr %% <C-R>=expand('%:p:h')<CR>

" set hidden

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" map visual mode backspace to black hole register
vnoremap <BS> "_d

" change tab and shift widths
set expandtab
set shiftwidth=4
set softtabstop=4 
"
"tabs for filetypes
autocmd FileType tex setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType matlab setlocal shiftwidth=4 tabstop=4 expandtab textwidth=79 formatoptions-=t
autocmd FileType verilog setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType text setlocal autoindent textwidth=79

" change to file's directory
autocmd BufEnter * silent! lcd %:p:h

" this function switches case circlularly.
" first UPPER, then lower and then Title case.
function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
        let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
        let result = toupper(a:str)
    endif
    return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" set the system clipboard to + register
set clipboard=unnamedplus

"----------------------------------------------------------------
" displaying text
"----------------------------------------------------------------
" number of screen lines to show around the cursor
set scrolloff=3 

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
set cmdheight=2

" airline plugin
set noshowmode

" matlab - matchit plugin settings
source $VIMRUNTIME/macros/matchit.vim
" matlab - mlint
autocmd BufEnter *.m    compiler mlint

" use solarized color scheme
if has('gui_running')
    syntax enable
    set background=light
    colorscheme solarized
endif

" syntastic -- ignore matlab warning
let g:syntastic_matlab_mlint_quiet_messages = {
            \ "regex": ['^There is a property named .\{-} Did you mean to reference it',
            \           '^There is a property named .\{-} Maybe this is a reference to it']}

"" Options for rainbow parentheses plugin
"let g:rbpt_colorpairs = [
"    \ ['brown',       'RoyalBlue3'],
"    \ ['Darkblue',    'SeaGreen3'],
"    \ ['darkgray',    'DarkOrchid3'],
"    \ ['darkgreen',   'firebrick3'],
"    \ ['darkcyan',    'RoyalBlue3'],
"    \ ['darkred',     'SeaGreen3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['brown',       'firebrick3'],
"    \ ['gray',        'RoyalBlue3'],
"    \ ['black',       'SeaGreen3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['Darkblue',    'firebrick3'],
"    \ ['darkgreen',   'RoyalBlue3'],
"    \ ['darkcyan',    'SeaGreen3'],
"    \ ['darkred',     'DarkOrchid3'],
"    \ ['red',         'firebrick3'],
"    \ ]
"
"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0

" tagbar plugin shortcut
nmap <leader>m :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_autoclose = 1
let g:tagbar_left=1
let g:tagbar_width = 30
"let g:tagbar_expand=1

" NerdTree plugin settings
nmap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeMapJumpNextSibling = '<nul>'
let g:NERDTreeMapJumpPrevSibling = '<nul>'

" maptools plugin
"imap <M-j>      <Plug>MarkersJumpF
"map <M-j>      <Plug>MarkersJumpF
"imap <M-k>      <Plug>MarkersJumpB
"map <M-k>      <Plug>MarkersJumpB
"imap <M-<>      <Plug>MarkersMark
"nmap <M-<>      <Plug>MarkersMark
"vmap <M-<>      <Plug>MarkersMark
"
"let g:marker_select_empty_marks=0 
"let g:marker_center=0

"DelimitMate plugin options
let delimitMate_autoclose=0
let delimitMate_excluded_regions = ""
"let delimitMate_excluded_ft = "tex"

imap <C-F> <Plug>delimitMateS-Tab
imap <C-G> <Plug>delimitMateJumpMany

" Ultisnips options
let g:UltiSnipsJumpForwardTrigger="<C-F>"
let g:UltiSnipsJumpBackwardTrigger="<C-G>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

" Control key mappings
imap <M-n> <C-N>
nmap <M-w> <C-W>

" folding
let g:LatexBox_Folding=1
"let g:LatexBox_fold_automatic=1

" options for vimtex
let g:vimtex_quickfix_latexlog = {
                                \ 'underfull' : 0,
                                \ 'overfull' : 0,
                                \ 'specifier changed to' : 0,
                                \ 'xparse' : 0,
                                \ 'LaTeX Font Warning' : 0,
                                \ 'IEEEtran.bst: No hyphenation pattern' : 0,
                                \ 'No \\author given' : 0,
                                \ 'Class scrreprt Warning:' : 0,
                                \ 'Marginpar on page \d\+ moved' : 0,
                                \}

let g:vimtex_view_method = 'zathura'

" supertab plugin settings
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<C-p><C-o>"

" prevent yankstack from hijacking S key.
" I need it for the surround plugin.
" Just load the yankstack bindings first and let
" surround overwrite it
call yankstack#setup()

" .tikz file extension - highlight as latex
au BufNewFile,BufRead *.tikz set filetype=tex

" .pst file extension - highlight as latex
au BufNewFile,BufRead *.pst set filetype=tex

" fix for garbled up screen with compiz
" set ttyscroll=0
 
nnoremap <C-J> :tabprevious<CR>
nnoremap <C-K>   :tabnext<CR>
nnoremap <Leader>j :tabprevious<CR>
nnoremap <Leader>k   :tabnext<CR>

" disable cursor blinking
set guicursor+=n-v-c:blinkon0

" easy align plugin
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" disable ex mode
:nnoremap Q <Nop>

" search related stuff
" * and # search for next/previous of selected text when used in visual mode
xno * :<c-u>cal<SID>VisualSearch()<cr>/<cr>
xno # :<c-u>cal<SID>VisualSearch()<cr>?<cr>
 
fun! s:VisualSearch()
  let old = @" | norm! gvy
  let @/ = '\V'.substitute(escape(@", '\'), '\n', '\\n', 'g')
  let @" = old
endf

nnoremap <Leader>e //e

" font setting for the new fujitsu
set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
"set guifont=Inconsolata 11

" use ranger as a file chooser -> <leader>r
function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        "exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
        exec 'silent !urxvt -bg rgba:fd00/f600/e300/ffff -title "vim-ranger file chooser" -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'tab drop ' . fnameescape(names[0])
    silent! lcd %:p:h
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>
nnoremap <leader>o :<C-U>RangerChooser<CR>

" shortcut for new tab
nnoremap <leader>t :tab drop 

" shortcut for jumping between splits
"nnoremap <leader>h <C-W>h
"nnoremap <leader>j <C-W>j
"nnoremap <leader>k <C-W>k
"nnoremap <leader>l <C-W>l

" clear highlight search witouth disabling it.
" let hlstate=0
" nnoremap <Leader>s :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<cr>
"nmap <silent> <leader>s :set hlsearch!<CR>

" display a colored column at the 80th column mark
augroup LongLines
    autocmd!
    autocmd FileType matlab,text  setlocal colorcolumn=80
augroup END

set nojoinspaces

" completion pop-up menu settings
" don't select the first item, insert the longest common text
set completeopt=longest,menuone
" make enter behave appropriately (select item) in the pop-up menu
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" map jumps
nnoremap ' `

" gF opens file under cursor in new tab
nnoremap gF <C-W>gf

cnoreabbrev t tab drop

" open the quickfix window directly with vimgrep
" command! -nargs=+ Grep execute 'silent vimgrep <args>' | copen 10
" use gw to search for  word under the cursor in the files located in the
" current directory
" nnoremap gw :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" switch to new tab  when opening new buffer.
" switch to existing tab with that buffer if any
set switchbuf+=usetab,newtab

" toggle-list plugin
let g:toggle_list_no_mappings=1
nmap <script> <silent> <leader>c :call ToggleQuickfixList()<CR>

" automatically update date stamp in file
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! UpdateLastModified()
  "if &modified
    let save_cursor = getpos(".")
    let n = min([200, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,20}Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  "endif
endfun
command! -bar UpdateLastModified call UpdateLastModified()
nnoremap <leader>u :<C-U>UpdateLastModified<CR>

" fold with syntax info
set foldmethod=syntax
" start with open folds
set foldlevel=99

" Loupe search plugin -- clear highlighting
" Instead of <leader>n, use <leader>x.
nmap <leader>s <Plug>(LoupeClearHighlight)
" don't center results
let g:LoupeCenterResults=0
let g:LoupeVeryMagic=0

" paste into newline with correct indent
nnoremap <leader>p o<c-r>*

" open new ctrlp files in new tab
let g:ctrlp_open_new_file = 't'

" always show the tabline
set showtabline=2

" python PEP8 indentation settings
au FileType python set
            \ tabstop=4
            \ softtabstop=4
            \ shiftwidth=4
            \ textwidth=79
            \ expandtab
            \ autoindent
            \ fileformat=unix
            \ colorcolumn=80
