"Only do this when not done yet for this buffer 
if exists("b:did_ftplugin_own")
  finish
endif

let b:did_ftplugin_own = 1 " Don't load twice in one buffer

nnoremap <leader>b :call BreakLongString() <cr>

function! BreakLongString()
    let searchpattern = '\v('')@<!''('')@!.+('')@<!''('')@!'
    let twidth = &textwidth
    if twidth == 0
        echo "textwidth is zero!"
        return 1
    endif

    " move to the beginning of line
    normal! ^

    let begpos = GetStringBegPos()

    if begpos >= twidth
        echo "The string is beyond the column width."
        return 1
    endif

    let endpos = GetStringEndPos()

    if endpos == 0
        echo "The current line does not contain any strings!"
        return 0
    elseif endpos < twidth
        " if the string is short
        echo "Noting to do! The string is already short enough."
        return 1
    endif

    " wrap string with []. look aheads
    execute 's/' . searchpattern . '/\[\0\]/'
    normal! f[
    let cpos = GetColumnNumber()

    let gluestr = ''',...'
    let maxwidth = twidth - len(gluestr)
    " get column number from cursor position
    let offsetwidth = cpos

    " main loop
    while AppendGlueStr(gluestr, maxwidth) == 0
        normal! a'
        call MoveLineToOffset(offsetwidth)

        " if the remaining string is short enough, return
        if GetStringEndPos() < twidth
            return 0
        end

    endwhile

endfunction

function! GetStringBegPos()
    let searchpattern = '\v('')@<!''('')@!.+('')@<!''('')@!'
    " go to end of search pattern
    " execute 'normal! /' . searchpattern . '/e'
    if search(searchpattern, 'c', line('.')) == 0
        return 0
    else
        " now we want to get the cursor postion and return it
        return GetColumnNumber()
    endif
endfunction

function! GetStringEndPos()
    let searchpattern = '\v('')@<!''('')@!.+('')@<!''('')@!'
    " go to end of search pattern
    " execute 'normal! /' . searchpattern . '/e'
    let curpos = getpos(".")
    if search(searchpattern, 'ce', line('.')) == 0
        let outputval = 0
    else
        let outputval = GetColumnNumber()
    endif
    call setpos(".", curpos)
    return outputval
endfunction

function! AppendGlueStr(gluestr, maxwidth)
    " get column number
    " go forward until we reach the maxwidth
    let cpos = GetColumnNumber()
    let lpos = GetLineNumber()

    while cpos <= a:maxwidth
        normal! E
        let cpos = GetColumnNumber()

        " check if we are still on the current line
        if GetLineNumber() != lpos
            " if not return
            return 1
        endif
    endwhile

    if cpos > a:maxwidth
        normal! gE
    endif

    execute "normal! a" . a:gluestr . "\<cr>"
endfunction

function! MoveLineToOffset(offsetwidth)
        let cpos = GetColumnNumber()

        " assume cpos is smaller than offsetwidth

        let nSpace = a:offsetwidth - cpos + 1
        if nSpace > 0
            execute "normal! " . nSpace . "i "
        endif
endfunction

function! GetColumnNumber()
    let cpos = getcurpos()
    return cpos[2]
endfunction

function! GetLineNumber()
    let cpos = getcurpos()
    return cpos[1]
endfunction
