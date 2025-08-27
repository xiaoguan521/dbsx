-- emoji-filter.lua
-- Pandoc Lua 过滤器：将 Emoji 图标替换为文字描述

function Str(elem)
  local text = elem.text
  
  -- 替换各种 Emoji 图标
  text = text:gsub("⚠️", "")
  text = text:gsub("🏥", "")
  text = text:gsub("🔐", "")
  text = text:gsub("🛠️", "")
  text = text:gsub("❗", "")
  
  -- 返回修改后的文本
  if text ~= elem.text then
    return pandoc.Str(text)
  end
end