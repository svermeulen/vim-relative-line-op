
nnoremap <silent> <plug>CopyLineAbove :<c-u>call <sid>CopyLineToCurrent(1, v:count)<cr>
nnoremap <silent> <plug>CopyLineBelow :<c-u>call <sid>CopyLineToCurrent(0, v:count)<cr>k

function! s:CopyLineToCurrent(dirUp, count)
    let curLineNo = line(".")

    let yankedLine=""

    if a:dirUp
        let yankedLine = getline(curLineNo - a:count)
    else
        let yankedLine = getline(curLineNo + a:count)
    endif

    exe "normal! o". yankedLine
    exe "normal! =="

    if a:dirUp
        call repeat#set("\<plug>CopyLineAbove", a:count)
    else
        call repeat#set("\<plug>CopyLineBelow", a:count)
    endif
endfunction

