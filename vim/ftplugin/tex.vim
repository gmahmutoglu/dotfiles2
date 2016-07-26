" this mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set shiftwidth=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
" set iskeyword+=:

let g:Tex_CompileRule_dvi='latex -src-specials -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
"let g:Tex_CompileRule_pdf = 'ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true $*.ps'
"let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'latexmk -pdf  -halt-on-error $*'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_UseEditorSettingInDVIViewer=1
let g:Tex_FormatDependency_ps = 'dvi,ps'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_ViewRule_dvi = 'xdvi'
"let g:Tex_MultipleCompileFormats = 'dvi,pdf'
set winaltkeys=no

let g:Tex_GotoError=0

set spell

" open new buffer (e.g. from quick fix window) in new tab
set switchbuf+=usetab,newtab

" augroup texCompileGroup
" 	autocmd!
" 	au BufWritePost *.tex silent call Tex_CompileLatex()
" 	au BufWritePost *.tex silent !pkill -USR1 xdvi.bin
" augroup END
"let g:Tex_GotoError=0

" save and compile combination
 nnoremap <Leader>lw :up!<cr>:call Tex_RunLaTeX()<cr>

" set C-h to do nothing
imap <C-h> <nop>

" Set the warning messages to ignore.
let g:Tex_IgnoredWarnings =
\"Underfull\n".
\"Overfull\n".
\"specifier changed to\n".
\"You have requested\n".
\"Missing number, treated as zero.\n".
\"There were undefined references\n".
\"Citation %.%# undefined\n".
\"LaTeX Font Warning:\n".
\"No \\\\author given.\n".
\"Marginpar on page %. moved.\n"
" This number N says that latex-suite should ignore the first N of the above.
let g:Tex_IgnoreLevel = 10

"imap ü \"{u}
"imap Ü \"{U}
"imap ö \"{o}
"imap Ö \"{O}
"imap ç \c{c}
"imap Ç \c{C}
"imap ş \c{s}
"imap Ş \c{S}
"imap ğ \u{g}
"imap Ğ \u{G}
"imap ı {\i}
"imap İ \.{I}

" Inspired by ervandew's answer for supertab omnicompletions for perl
" https://github.com/ervandew/supertab/issues/3
if exists('g:SuperTabCompletionContexts')
    let b:SuperTabCompletionContexts = ['TexContext'] + g:SuperTabCompletionContexts
    function! TexContext()
        let curline = getline('.')
        let cnum = col('.')
        let synname = synIDattr(synID(line('.'), cnum-1, 1), 'name')
        if curline =~ '[{\\]\w*\%' . cnum .'c' && synname !~ '\(String\|Comment\)'
            return "\<c-x>\<c-o>"
        elseif curline =~ '\\\includegraphics\S*{$' || curline =~ '\\\input\S*{$' 
            return "\<c-x>\<c-f>"
        endif
    endfunction
endif

" delimitMate options for tex
let delimitMate_quotes = "\" ' ` * $"
