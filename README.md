# ultilocate #

本插件可以在vim中快速搜索电脑中的文件。linux下会调用locate，windows下会调用[everything](http://www.voidtools.com/download.php)的命令行版。

## 使用方法 ##

    UltiLocation 文件名 [目录]

如果不指定目录，则会列出系统中所有包含你给出的名称的文件；如果指定目录，则只会列出你指定的目录中的文件。

## 搜索结果窗口快捷键 ##

* 回车: 在当前窗口打开文件
* Ctrl+回车: 在新窗口中打开文件
* t: 在新tab中打开文件
* Ctrl+e: 用系统默认打开方式打开文件。
* ESC、q: 关闭搜索结果窗口

## 相关变量 ##

**g:ultilocate_locate_path** locate路径。默认值: 'locate'

**g:ultilocate_everything_path** everything命令行版路径。默认值: 'es.exe'

**g:ultilocate_new_window_mode** 新窗口模式。默认值: 's'，可设置为'v'。

**g:ultilocate_window_height** 搜索结果窗口高度。默认值: '10'

**g:UltiLocate_auto_close** 选择文件后是否自动关闭搜索结果窗口。默认值: 0

## 截图 ##

![screenshot1](https://github.com/jiazhoulvke/ultilocate/raw/master/screenshot1.png)

![screenshot2](https://github.com/jiazhoulvke/ultilocate/raw/master/screenshot2.png)
