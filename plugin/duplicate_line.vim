
nnoremap <silent> <plug>CopyLineAbove :<c-u>call <sid>CopyLineToCurrent(1, v:count)<cr>
nnoremap <silent> <plug>CopyLineBelow :<c-u>call <sid>CopyLineToCurrent(0, v:count)<cr>k

nnoremap <silent> <plug>SwapLineAbove :<c-u>call <sid>SwapLine(1, v:count)<cr>
nnoremap <silent> <plug>SwapLineBelow :<c-u>call <sid>SwapLine(0, v:count)<cr>

nnoremap <silent> <plug>MoveLineAbove :<c-u>call <sid>MoveLine(1, v:count)<cr>
nnoremap <silent> <plug>MoveLineBelow :<c-u>call <sid>MoveLine(0, v:count)<cr>

nnoremap <silent> <plug>PushLineAbove :<c-u>call <sid>PushLine(1, v:count)<cr>
nnoremap <silent> <plug>PushLineBelow :<c-u>call <sid>PushLine(0, v:count)<cr>

function! s:PushLine(dirUp, count)

    let cnt = (a:count > 1 ? a:count : 1)
    let curLineNo = line(".")

    if a:dirUp
        let otherLineNo = curLineNo - cnt - 1
    else
        let otherLineNo = curLineNo + cnt - 1
    endif

    let line1 = getline(curLineNo)

    exe "normal! \"_dd"

    exe "keepjumps normal! ". (a:dirUp ? otherLineNo : otherLineNo) . "G"

    exe "normal! o". line1
    exe "normal! =="

    exe "keepjumps normal! ". curLineNo . "G"

    if a:dirUp
        call repeat#set("\<plug>PushLineAbove", cnt)
    else
        call repeat#set("\<plug>PushLineBelow", cnt)
    endif
endfunction

function! s:MoveLine(dirUp, count)

    let cnt = (a:count > 1 ? a:count : 1)
    let curLineNo = line(".")

    if a:dirUp
        let otherLineNo = curLineNo - cnt
    else
        let otherLineNo = curLineNo + cnt
    endif

    let line1 = getline(otherLineNo)

    exe "keepjumps normal! ". otherLineNo . "G"
    exe "normal! \"_dd"

    exe "keepjumps normal! ". (a:dirUp ? curLineNo-1 : curLineNo) . "G"
    exe "normal! o". line1

    exe "normal! =="

    if a:dirUp
        call repeat#set("\<plug>MoveLineAbove", cnt)
    else
        call repeat#set("\<plug>MoveLineBelow", cnt)
    endif
endfunction

function! s:SwapLine(dirUp, count)

    let cnt = (a:count > 1 ? a:count : 1)
    let curLineNo = line(".")

    if a:dirUp
        let otherLineNo = curLineNo - cnt
    else
        let otherLineNo = curLineNo + cnt
    endif

    let line2 = getline(curLineNo)
    let line1 = getline(otherLineNo)

    exe "normal! \"_ddO". line1
    exe "keepjumps normal! ". otherLineNo . "G"
    exe "normal! \"_ddO". line2

    " Note: format only after swapping both
    exe "normal! =="
    exe "keepjumps normal! ". curLineNo . "G"
    exe "normal! =="
    exe "keepjumps normal! ". otherLineNo . "G"

    if a:dirUp
        call repeat#set("\<plug>SwapLineAbove", cnt)
    else
        call repeat#set("\<plug>SwapLineBelow", cnt)
    endif
endfunction

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

