" Name:         ultilocate
" Description:  利用locate(linux)/everything(windows)快速搜索电脑中所有文件
" Author:       加州旅客
" Email:        jiazhoulvke@gmail.com
" Blog:         http://www.jiazhoulvke.com
"--------------------------------------------------

"if !exists('g:ultilocate_loaded')
"    finish
"endif
"let g:ultilocate_loaded=1

if !exists('g:ultilocate_locate_path')
    let g:ultilocate_locate_path='mlocate'
endif
if !exists('g:ultilocate_everything_path')
    let g:ultilocate_everything_path='es.exe'
endif

function! <SID>UltiLocate(ss)
    let old_efm=&efm
    botright copen
    set efm=%f
    if has('win32') || has('win64')
        exec "silent! cgetexpr system('".g:ultilocate_everything_path." ".a:ss."')"
    else
        exec "silent! cgetexpr system('".g:ultilocate_locate_path." -i -b ".a:ss."')"
    endif
    let &efm=old_efm
endfunction

command! -nargs=1 UltiLocate call <SID>UltiLocate(<q-args>)

" vim: filetype=vim nowrap
