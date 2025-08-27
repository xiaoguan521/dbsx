@echo off
chcp 65001 >nul
if "%1"=="" (
    echo 使用方法: %0 ^<markdown文件^>
    echo 示例: %0 harbor_https.md
    pause
    exit /b 1
)
echo 正在转换 %1 为 DOCX 格式...
pandoc "%1" -o "%~n1.docx" --from=markdown+smart --to=docx --reference-doc="模板.docx" --toc --toc-depth=3 --highlight-style=tango --wrap=preserve --filter "C:\Users\xiaochen\AppData\Roaming\npm\mermaid-filter.cmd" --lua-filter=emoji-filter.lua
if %errorlevel% equ 0 (
    echo 转换完成：%~n1.docx
) else (
    echo 转换失败，错误代码：%errorlevel%
    pause
)