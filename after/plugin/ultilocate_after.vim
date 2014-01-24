if exists('g:ultilocate_after_loaded')
    finish
endif
let g:ultilocate_after_loaded=1

" 如果安装了fuzzyfinder，则可以通过调用fuzzyfinder的api来显示搜索结果
function! <SID>FufUltiLocate(...)
    if has('win32') || has('win64')
        let result = system(g:ultilocate_everything_path." ".a:1)
    else
        let result = system(g:ultilocate_locate_path." -i -b ".a:1)
    endif
    let resultlist = split(result,"\n")
    if a:0 == 2
        call filter(resultlist, 'v:val =~ "^'.a:2.'"')
    endif
    call fuf#givenfile#launch('',0,'>',resultlist)
endfunction

if exists('g:ultilocate_has_fuzzyfinder')
    command! -nargs=+ FufUltiLocate call <SID>FufUltiLocate(<f-args>)
endif
