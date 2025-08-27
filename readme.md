# 等保三项文档转换指南

## 概述

本指南提供了使用 Pandoc 将 Markdown 文档转换为 Word 格式的完整解决方案，特别针对等保三级合规文档的转换需求，支持代码高亮、图形处理、图标兼容等高级功能。

## 基础转换命令

### 标准转换

```bash
pandoc <输入文件.md> -o <输出文件.docx> --from=markdown+smart --to=docx --reference-doc="模板.docx" --toc --toc-depth=3 --highlight-style=tango --wrap=preserve
```

### 高级转换（包含所有可选功能）

```bash
pandoc <输入文件.md> -o <输出文件.docx> --from=markdown+smart --to=docx --reference-doc="模板.docx" --toc --toc-depth=3 --highlight-style=tango --wrap=preserve --filter mermaid-filter --lua-filter=emoji-filter.lua
```

## 参数说明

### 必需参数

| 参数 | 说明 | 示例值 |
|------|------|--------|
| `<输入文件.md>` | 要转换的 Markdown 文档 | `harbor_https.md` |
| `-o <输出文件.docx>` | 指定生成的 Word 文档名称 | `harbor_https.docx` |
| `--from=markdown+smart` | 启用智能标点符号转换 | 固定值 |
| `--to=docx` | 输出格式为 Word 文档 | 固定值 |

### 样式与格式参数

| 参数 | 说明 | 推荐值 |
|------|------|--------|
| `--reference-doc="模板.docx"` | 使用样式模板，保持格式统一 | `"模板.docx"` |
| `--toc` | 自动生成目录 | 启用 |
| `--toc-depth=3` | 目录层级深度 | `3`（支持三级标题） |
| `--highlight-style=tango` | 代码块高亮样式 | `tango` |
| `--wrap=preserve` | 保留原始换行格式 | `preserve` |

### 可选增强功能

| 功能 | 参数 | 用途 | 依赖要求 |
|------|------|------|----------|
| **Mermaid 图形支持** | `--filter mermaid-filter` | 将流程图转换为图片 | `npm install -g mermaid-filter` |
| **Emoji 图标处理** | `--lua-filter=emoji-filter.lua` | 替换 Emoji 为文字标记 | 需要 `emoji-filter.lua` 文件 |
| **代码块增强** | `--highlight-style=<样式>` | 自定义代码高亮 | 可选：`pygments`, `kate`, `monochrome` 等 |

## 具体文档转换命令

### Harbor HTTPS 配置文档（完整功能）

```bash
# 包含 Mermaid 图形和 Emoji 处理
pandoc harbor_https.md -o harbor_https.docx --from=markdown+smart --to=docx --reference-doc="模板.docx" --toc --toc-depth=3 --highlight-style=tango --wrap=preserve --filter "C:\Users\xiaochen\AppData\Roaming\npm\mermaid-filter.cmd" --lua-filter=emoji-filter.lua

# 标准转换（不处理图形和图标）
pandoc harbor_https.md -o harbor_https.docx --from=markdown+smart --to=docx --reference-doc="模板.docx" --toc --toc-depth=3 --highlight-style=tango --wrap=preserve
为了简单使用，同级目录下的bat 和ps1 方便使用
convert_to_docx.bat harbor_https.md
.\Convert-ToDocx.ps1 harbor_https.md 即可
```

### MySQL 相关文档（标准转换）

```bash
# MySQL 三权分立账户配置
pandoc "2. mysql 创建三权分立账户.md" -o "MySQL创建三权分立账户指南.docx" --from=markdown+smart --to=docx --reference-doc="模板.docx" --toc --toc-depth=3 --highlight-style=tango --wrap=preserve

# MySQL IP 访问限制配置
pandoc "3.mysql 限制访问的IP范围.md" -o "MySQL限制访问IP范围配置指南.docx" --from=markdown+smart --to=docx --reference-doc="模板.docx" --toc --toc-depth=3 --highlight-style=tango --wrap=preserve
```


## 环境配置

### 必需软件

1. **Pandoc** - 文档转换核心工具
   ```bash
   # Windows (使用 Chocolatey)
   choco install pandoc
   
   # 或下载安装包
   # https://pandoc.org/installing.html
   ```

2. **模板文件** - 确保当前目录包含 `模板.docx`

### 可选依赖

1. **Mermaid 图形支持**
   ```bash
   # 安装 Node.js 和 npm
   npm install -g mermaid-filter
   ```

2. **Emoji 处理支持**
   - 确保当前目录包含 `emoji-filter.lua` 文件
   - 或使用管道处理方案（无需额外文件）

## 使用流程

1. **环境检查**：确认 Pandoc 已安装，模板文件存在
2. **功能选择**：根据文档特点选择合适的转换参数
3. **执行转换**：运行相应的转换命令
4. **结果验证**：检查生成的 Word 文档格式和内容
5. **格式调整**：如需要，在 Word 中进行最后的格式微调

## 常见问题

### Q: Mermaid 图形没有显示为图片？
**A:** 确保已安装 `mermaid-filter`：`npm install -g mermaid-filter`

### Q: Emoji 图标在 Word 中显示异常？
**A:** 使用 `--lua-filter=emoji-filter.lua` 参数，或使用管道处理方案

### Q: 代码块没有语法高亮？
**A:** 确认使用了 `--highlight-style=tango` 参数

### Q: 目录没有自动生成？
**A:** 确认使用了 `--toc` 和 `--toc-depth=3` 参数

### Q: 文档样式与模板不一致？
**A:** 检查 `--reference-doc="模板.docx"` 路径是否正确

## 版本信息

**创建时间：** 2025-08-27  
**适用版本：** Pandoc 2.x+  
**适用系统：** Windows/Linux/macOS  
**文档版本：** v2.0

---

> **提示：** 建议先使用标准转换测试效果，然后根据需要逐步添加高级功能参数。