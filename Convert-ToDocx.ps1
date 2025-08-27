param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile
)

# 设置控制台编码为UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if (-not (Test-Path $InputFile)) {
    Write-Host "错误：文件 '$InputFile' 不存在！" -ForegroundColor Red
    exit 1
}

$outputFile = [System.IO.Path]::ChangeExtension($InputFile, ".docx")
Write-Host "正在转换 $InputFile 为 DOCX 格式..." -ForegroundColor Yellow

try {
    & pandoc "$InputFile" -o "$outputFile" --from=markdown+smart --to=docx --reference-doc="模板.docx" --toc --toc-depth=3 --highlight-style=tango --wrap=preserve --filter "C:\Users\xiaochen\AppData\Roaming\npm\mermaid-filter.cmd" --lua-filter=emoji-filter.lua
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "转换完成：$outputFile" -ForegroundColor Green
    } else {
        Write-Host "转换失败！错误代码：$LASTEXITCODE" -ForegroundColor Red
        exit $LASTEXITCODE
    }
} catch {
    Write-Host "转换过程中发生错误：$($_.Exception.Message)" -ForegroundColor Red
    exit 1
}