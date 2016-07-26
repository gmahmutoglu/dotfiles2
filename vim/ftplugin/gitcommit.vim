if exists("b:did_ftplugin_own")
  finish
endif

let b:did_ftplugin_own = 1 " Don't load twice in one buffer

setlocal spell

" autocmd VimEnter * %s/.\{-}\(Changes to be committed\(.\|\n\)\{-}^#\n\)/\1/g

"-----------------start edit commit message-------------------"
" we put the branch name at the start of the commit message
" afterwards we list the committed files
" this assumes the file opens with git's default commit message
"
" first check if the first line is empty. This is not the case, for example
" if we are performing a merge commit.
if getline(1) == ""
    let startpos = searchpos('Changes to be committed')
    let endpos = searchpairpos('Changes to be committed', '', '#$')
    let pretext = getline(startpos[0], endpos[0])
    normal! ggo
    let pretextbegpos = line(".")+1
    put =pretext
    let pretextendpos = endpos[0]-startpos[0]+pretextbegpos
    call cursor(pretextbegpos, 0)
    silent execute "s/to be //"
    silent execute pretextbegpos . "," . pretextendpos . "s/^# *//g"

    execute "normal! /On branch\<cr>"."y$"."gg"."p"."0"."d2w"."A:"
endif
"-----------------end edit commit message-------------------"
