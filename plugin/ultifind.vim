" Name:         ultifind
" Description:  利用mlocate(linux下)/everything(windows下)快速搜索电脑中所有文件
" Author:       加州旅客
" Email:        jiazhoulvke@gmail.com
" Blog:         http://www.jiazhoulvke.com
"--------------------------------------------------

"if !exists('g:ultifind_loaded')
"    finish
"endif
"let g:ultifind_loaded=1

let g:ultifind_mlocate_path='mlocate'
let g:ultifind_everything_path='es.exe'
let g:ultifind_mlocate_flags='-i -b'
let g:ultifind_errorformat='%f'

let old_efm=&efm
let old_verbose=&verbose
set verbose&vim
set efm=%f
let result=system('mlocate -i -b ' . 'hello')
let tmpfile=tempname()
let ra=split(result,'\n')
call writefile(ra,tmpfile)
execute 'silent! cgetfile ' . tmpfile
botright copen
call delete(tmpfile)
let &verbose=old_verbose
let &efm=old_efm

" vim: filetype=vim nowrap
