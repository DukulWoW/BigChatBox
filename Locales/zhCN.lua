-- BigChatBox Localization - Simplified Chinese (zhCN)
-- Version: 5.6.1
-- Full translation for 5.6.1 locale system. Overrides all keys that differ from enUS.
-- Missing keys fall back to enUS automatically.

local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "zhCN" and (BigChatBox and BigChatBox._forcedLocale) ~= "zhCN" then return end

-- ── Addon identity ────────────────────────────────────────────────────────────
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "版本"
L["LOADED_MSG"]   = "BigChatBox v%s 已加载！输入 /bcb 打开选项。"

-- ── Config window tabs ────────────────────────────────────────────────────────
L["TAB_GENERAL"]   = "常规"
L["TAB_DESIGNER"]  = "设计"
L["TAB_PLACEMENT"] = "位置"
L["TAB_FEATURES"]  = "功能"
L["TAB_SNIPPETS"]  = "短语"
L["TAB_HISTORY"]   = "历史"
L["TAB_ADVANCED"]  = "高级"
L["TAB_RESET"]     = "重置"

-- ── Reset tab ─────────────────────────────────────────────────────────────────
L["RESET_TAB_HEADER"]       = "重置与恢复"
L["RESET_TAB_DESC"]         = "这些操作是永久性的，无法撤销。"
L["RESET_ALL_HELP"]         = "重置所有内容：位置、外观、历史记录和短语。"
L["RESET_APPEARANCE_HELP"]  = "仅重置背景、边框、字体和颜色。"
L["RESET_PLACEMENT_HELP"]   = "将位置和大小重置为默认值。"
L["RESET_HISTORY_HELP"]     = "清除所有已保存的聊天和密语历史记录。"
L["RESET_SNIPPETS_HELP"]    = "删除所有短语。"
L["RESET_STYLES_HELP"]      = "删除所有已保存的自定义样式。"
L["RESTART_SETUP_HELP"]     = "重置所有设置并重新运行首次安装向导。"

-- ── Shared UI ─────────────────────────────────────────────────────────────────
L["PREVIEW"]        = "预览"
L["TYPE_SOMETHING"] = "在这里输入..."
L["CLOSE"]          = "关闭"
L["ACTIONS"]        = "操作"
L["RESET"]          = "重置"
L["OK"]             = "确定"
L["CANCEL"]         = "取消"
L["YES"]            = "是"
L["NO"]             = "否"
L["SAVE"]           = "保存"
L["DELETE"]         = "删除"
L["EDIT"]           = "编辑"
L["IMPORT"]         = "导入"
L["EXPORT"]         = "导出"
L["DUPLICATE"]      = "复制"
L["SHARE"]          = "分享"
L["ENABLED"]        = "已启用"
L["DISABLED"]       = "已禁用"

-- ── General tab ───────────────────────────────────────────────────────────────
L["BTN_VIEW_PATCH_NOTES"]     = "查看更新日志"
L["BTN_HELP_AND_TIPS"]        = "帮助与技巧"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "战斗锁定信息"
L["BTN_SHIFT_CLICK_INFO"]     = "Shift 点击说明"

-- General tab feature grid
L["CELL_SNIPPETS_HDR"]       = "|cff5599ff短语|r"
L["CELL_SNIPPETS_DESC"]      = "发送时展开的文字快捷方式。\n在短语标签页中管理。"
L["CELL_ANCHOR_HDR"]         = "|cff5599ff锚点编辑器|r"
L["CELL_ANCHOR_DESC"]        = "点击并拖动以重新定位。\n方向键实现像素精度。"
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ff自动补全|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "智能 Tab 补全命令、密语\n以及短语触发词（!公会）。"
L["CELL_HISTORY_HDR"]        = "|cff5599ff聊天历史|r"
L["CELL_HISTORY_DESC"]       = "完整历史记录，含时间戳。\n滚动鼠标滚轮浏览。"
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ff自定义|r"
L["CELL_CUSTOMIZATION_DESC"] = "设计标签页可设置背景、边框、\n字体、颜色。保存并分享样式。"
L["CELL_SECURE_HDR"]         = "|cffff9900安全内容|r"
L["CELL_SECURE_DESC"]        = "在大秘境、竞技场和定级战场中\n自动暂停以保护您的聊天。"
L["CELL_SHARING_HDR"]        = "|cff5599ff分享|r"
L["CELL_SHARING_DESC"]       = "将样式和短语导出为短字符串\n与好友分享。"
L["CELL_LONGMSG_HDR"]        = "|cff5599ff长消息|r"
L["CELL_LONGMSG_DESC"]       = "超过 255 个字符的消息会自动\n分割。静默、提示或确认。"

-- ── Styles (Designer tab) ─────────────────────────────────────────────────────
L["STYLES"]              = "样式"
L["ACTIVE_STYLE"]        = "当前样式"
L["BTN_SAVE_STYLE"]      = "保存样式"
L["BTN_DELETE_STYLE"]    = "删除样式"
L["BTN_EXPORT_STYLE"]    = "导出样式"
L["BTN_IMPORT_STYLE"]    = "导入样式"

-- ── Designer tab sections ─────────────────────────────────────────────────────
L["SECTION_SIZE"]         = "大小"
L["SECTION_BACKGROUND"]   = "背景"
L["SECTION_BORDER"]       = "边框"
L["SECTION_FONTS"]        = "字体"
L["SECTION_TEXT_OPTIONS"] = "文字选项"

-- Designer tab slider / dropdown labels
L["LABEL_WIDTH"]              = "宽度"
L["LABEL_HEIGHT"]             = "高度"
L["LABEL_SCALE"]              = "缩放"
L["LABEL_BG_TEXTURE"]         = "背景纹理"
L["LABEL_BG_OPACITY"]         = "背景透明度"
L["LABEL_BG_BRIGHTNESS"]      = "背景亮度"
L["LABEL_BG_SCALE"]           = "背景缩放"
L["LABEL_TINT_INTENSITY"]     = "着色强度"
L["LABEL_BORDER_TEXTURE"]     = "边框纹理"
L["LABEL_BORDER_OPACITY"]     = "边框透明度"
L["LABEL_BORDER_BRIGHTNESS"]  = "边框亮度"
L["LABEL_BORDER_THICKNESS"]   = "边框粗细"
L["LABEL_CHANNEL_FONT"]       = "频道字体"
L["LABEL_INPUT_FONT"]         = "输入字体"
L["LABEL_CHANNEL_FONT_SIZE"]  = "频道字体大小"
L["LABEL_INPUT_FONT_SIZE"]    = "输入字体大小"
L["LABEL_TEXT_ALIGNMENT"]     = "文字对齐"
L["LABEL_FONT_OUTLINE"]       = "字体描边"

-- Designer tab checkboxes
L["CB_DYNAMIC_HEIGHT"]   = "动态高度"
L["CB_DYNAMIC_WIDTH"]    = "动态宽度"
L["CB_TINT_BG"]          = "用频道颜色着色背景"
L["CB_MATCH_TEXT_COLOR"] = "文字颜色匹配频道颜色"

-- ── Placement tab ─────────────────────────────────────────────────────────────
L["SECTION_LAYOUT_OPTIONS"]   = "布局选项"
L["SECTION_POSITION"]         = "位置"
L["LABEL_CHANNEL_NAME_POS"]   = "频道名称位置"
L["CB_SHOW_CHANNEL"]           = "显示频道名称"
L["LABEL_AUTOCOMPLETE_POS"]   = "自动补全位置"
L["LABEL_CHAR_COUNTER_POS"]   = "字符计数器位置"
L["CB_AUTO_HIDE_CHANNEL"]     = "自动隐藏频道名称（悬停时显示）"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "打开锚点编辑器"

-- ── Features tab ─────────────────────────────────────────────────────────────
L["SECTION_FEATURE_TOGGLES"]  = "功能开关"
L["FEATURE_TOGGLES_DESC"]     = "启用或禁用 BigChatBox 功能。"
L["SECTION_SNIPPET_SYSTEM"]   = "短语系统"
L["SECTION_AUTOCOMPLETE"]     = "自动补全"
L["SECTION_HISTORY"]          = "历史记录"
L["SECTION_LINK_HOVER"]       = "链接悬停"
L["SECTION_LONG_MESSAGES"]    = "长消息"
L["CB_ENABLE_SNIPPETS"]       = "启用短语系统"
L["CB_AC_COMMANDS"]           = "斜杠命令自动补全（/dance、/guild 等）"
L["CB_AC_WHISPER"]            = "密语名称自动补全（/w <名称>）"
L["CB_AC_SNIPPETS"]           = "短语触发词自动补全（!guild 等）"
L["CB_AC_BNET"]               = "在密语自动补全中显示 Battle.net 好友"
L["CB_ENABLE_HISTORY"]        = "启用聊天历史"
L["CB_MOUSEWHEEL_HISTORY"]    = "鼠标滚轮滚动历史记录"
L["CB_LINK_HOVER"]            = "悬停链接时显示提示"
L["LABEL_MSG_EXCEEDS_255"]    = "当消息超过 255 个字符时"

-- ── Snippets tab ──────────────────────────────────────────────────────────────
L["SNIPPETS_DISABLED_MSG"]    = "短语系统已禁用。\n请在功能标签页中启用。"
L["SNIPPETS_HEADER"]          = "短语"
L["SNIPPETS_DESC"]            = "在聊天中输入短语触发词（例如 !guild），按回车发送即可展开。"
L["SNIPPET_EDIT_HEADER"]      = "编辑"
L["SNIPPET_ACTIVE"]           = "短语已激活"
L["SNIPPET_TRIGGER_LBL"]      = "触发词："
L["SNIPPET_TEXT_LBL"]         = "内容："
L["SNIPPET_CHANNEL_LBL"]      = "发送到："
L["SNIPPET_GLOBAL"]           = "对所有角色可用"
L["SNIPPET_EMPTY_LIST"]       = "还没有短语。\n点击【新建短语】或\n【导入】以开始。"
L["BTN_NEW_SNIPPET"]          = "新建短语"
L["BTN_EXPORT_ALL"]           = "导出全部"
L["BTN_SHARE_SNIPPET"]        = "分享"
L["BTN_DUPLICATE_SNIPPET"]    = "复制"
L["BTN_DELETE_SNIPPET"]       = "删除"
L["BTN_IMPORT_SNIPPET"]       = "导入"

-- ── History tab ───────────────────────────────────────────────────────────────
L["HISTORY_HEADER"]           = "聊天历史"
L["HISTORY_HELP"]             = "点击文字以重复使用。悬停查看时间戳。点击 X 标记删除。"
L["HISTORY_EMPTY"]            = "暂无历史记录。"
L["HISTORY_MORE"]             = "... 还有 %d 条"
L["WHISPERS_HEADER"]          = "最近密语"
L["WHISPERS_CLICK_HINT"]      = "（点击以密语）"
L["WHISPERS_EMPTY"]           = "没有密语历史记录。"
L["BTN_WIPE_HISTORY"]         = "清除全部历史"
L["BTN_WIPE_COMMANDS"]        = "清除所有 /命令"
L["BTN_REMOVE_ENTRIES"]       = "删除所选条目"

-- ── Advanced tab ──────────────────────────────────────────────────────────────
L["SECTION_PROFILES"]         = "配置文件"
L["PROFILES_DESC"]            = "设置按角色单独保存。启用后将在所有角色间共享。"
L["CB_GLOBAL_PROFILE"]        = "对所有角色使用"
L["BEHAVIOR"]                 = "行为"
L["KEEP_OPEN"]                = "保持输入框开启直到按 Escape"
L["KEEP_OPEN_HELP"]           = "启用后，点击其他地方输入框仍保持可见。按 Escape 关闭。"
L["SHOW_LOCKDOWN_WARNING"]    = "显示安全内容警告"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "在大秘境、竞技场和定级战场中 BCB 暂停时在聊天中显示提示信息。"
L["IGNORE_COMMANDS_HISTORY"]  = "历史记录中忽略 /命令"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "/target、/cast 等斜杠命令不会保存在聊天历史中。"
L["SHOW_MINIMAP_BUTTON"]      = "显示小地图按钮"
L["SHOW_MINIMAP_BUTTON_HELP"] = "左键点击打开设置，右键点击打开快捷设置。插件栏按钮始终可用。"
L["HIDE_LOGIN_MSG"]           = "隐藏登录消息"
L["HIDE_LOGIN_MSG_HELP"]      = "隐藏登录时显示的「BigChatBox 已加载」消息。"
L["KEYBIND_OPEN_BLIZZARD"]    = "打开暴雪聊天："
L["KEYBIND_NOT_BOUND"]        = "未绑定"
L["KEYBIND_PRESS_KEY"]        = "按下一个键..."
L["KEYBIND_CONFLICT"]         = "%s 已绑定到 %s。是否覆盖？"
L["KEYBIND_TOOLTIP_BOUND"]    = "打开暴雪聊天（%s）"
L["KEYBIND_TOOLTIP_UNBIND"]   = "右键点击以解除绑定"
L["KEYBIND_TOOLTIP_SET"]      = "点击设置快捷键"
L["KEYBIND_HELP"]             = "打开暴雪原生聊天框，用于 Shift 点击坐骑、成就、玩具和天赋。默认：Ctrl+Enter。"
L["RESET_ALL"]                = "重置所有设置"
L["RESET_APPEARANCE"]         = "重置外观"
L["RESET_PLACEMENT"]          = "重置位置"
L["RESET_HISTORY_BTN"]        = "重置历史"
L["RESET_SNIPPETS_BTN"]       = "重置短语"
L["RESET_STYLES_BTN"]         = "重置样式"
L["RESTART_SETUP"]            = "重新运行向导"

-- ── Reset / action confirmations (StaticPopupDialogs) ────────────────────────
L["POPUP_RESET_ALL"]          = "将所有 BigChatBox 设置重置为默认值？\n包括位置、大小、外观和字体。"
L["POPUP_RESET_APPEARANCE"]   = "将外观重置为默认值？\n不影响位置或历史记录。"
L["POPUP_RESET_PLACEMENT"]    = "将位置重置为默认值？\n这将重新加载界面。"
L["POPUP_RESET_HISTORY"]      = "重置所有聊天历史和密语历史？\n历史记录长度将设置为 100。\n这将重新加载界面。"
L["POPUP_RESET_SNIPPETS"]     = "删除所有短语？这将重新加载界面。"
L["POPUP_RESET_STYLES"]       = "删除所有用户创建的样式？\n默认样式将保留并变为当前样式。\n这将重新加载界面。"
L["POPUP_WIPE_HISTORY"]       = "清除全部聊天历史？\n这也将重新加载界面。"
L["POPUP_WIPE_COMMANDS"]      = "从聊天历史中删除所有 /命令？\n普通消息将保留。\n这也将重新加载界面。"
L["POPUP_DELETE_STYLE"]       = "删除当前样式？"
L["POPUP_OVERWRITE_STYLE"]    = "名为 '%s' 的样式已存在。覆盖它？"
L["POPUP_SAVE_STYLE_TEXT"]    = "为此样式输入名称："
L["POPUP_EXPORT_STYLE_TEXT"]  = "复制下方样式字符串："
L["POPUP_IMPORT_STYLE_TEXT"]  = "粘贴样式字符串："
L["POPUP_NAME_IMPORT_STYLE"]  = "将导入的样式保存为："
L["POPUP_DELETE_SNIPPET"]     = "删除短语 '%s'？"
L["POPUP_SHARE_SNIPPET_TEXT"] = "复制短语字符串（Ctrl+C）："
L["POPUP_IMPORT_SNIPPET_TEXT"] = "粘贴短语字符串（Ctrl+V）："
L["POPUP_RESTART_SETUP"]      = "这将重置所有设置并重新启动欢迎向导。\n确定吗？"
L["POPUP_QUIT_SETUP"]         = "确定要退出设置吗？\n将使用默认设置。"
L["BTN_RESET_ALL_CONFIRM"]    = "全部重置"
L["BTN_WIPE_CONFIRM"]         = "是，清除"
L["BTN_DELETE_CONFIRM"]       = "删除"
L["BTN_OVERWRITE_CONFIRM"]    = "覆盖"
L["BTN_SKIP"]                 = "跳过"
L["BTN_RESTART_SETUP_CONFIRM"] = "重新运行向导"
L["BTN_QUIT_SETUP_CONFIRM"]   = "退出设置"
L["BTN_SAVE_CLOSE"]           = "关闭"

-- ── Slash commands / print messages ──────────────────────────────────────────
L["SLASH_POSITION_RESET"]     = "位置已重置为默认值"
L["SLASH_ANCHOR_UNAVAILABLE"] = "锚点编辑器不可用。"
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox：|r 聊天历史已清除。"
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox：|r 外观已重置为默认值"
L["RESET_DONE"]               = "所有设置已重置为默认值。"
L["COMBAT_CLOSE"]             = "进入战斗，设置已关闭。"
L["COMBAT_BLOCKED"]           = "战斗中无法打开设置。"

-- ── Position / size labels (legacy keys) ─────────────────────────────────────
L["POSITION"]        = "位置"
L["X_POSITION"]      = "X 坐标"
L["Y_POSITION"]      = "Y 坐标"
L["SIZE"]            = "大小"
L["WIDTH"]           = "宽度"
L["HEIGHT"]          = "高度"
L["SCALE"]           = "缩放"
L["FONT_SIZES"]      = "字体大小"
L["INPUT_FONT_SIZE"] = "输入字体大小"
L["CHANNEL_FONT_SIZE"] = "频道字体大小"
L["FONTS"]           = "字体"
L["INPUT_FONT"]      = "输入字体"
L["CHANNEL_FONT"]    = "频道字体"
L["BACKGROUND"]      = "背景"
L["BG_TEXTURE"]      = "背景纹理"
L["BG_TRANSPARENCY"] = "背景透明度"
L["BG_BRIGHTNESS"]   = "背景亮度"
L["BG_SCALE"]        = "背景缩放"
L["BORDER"]          = "边框"
L["BORDER_TEXTURE"]  = "边框纹理"
L["BORDER_TRANSPARENCY"] = "边框透明度"
L["BORDER_BRIGHTNESS"]   = "边框亮度"
L["BORDER_THICKNESS"]    = "边框粗细"
L["TEXT_OPTIONS"]    = "文字选项"
L["MATCH_TEXT_COLOR"] = "文字颜色匹配频道颜色"
L["SHOW_OUTLINE"]    = "显示文字描边"
L["SHOW_SHADOW"]     = "显示文字阴影"
L["DROP_SHADOW"]     = "输入框投影"
L["TEXT_ALIGN"]      = "文字对齐"
L["CHAT_HISTORY"]    = "聊天历史"
L["HISTORY_LENGTH"]  = "历史记录长度"
L["WIPE_HISTORY"]    = "清除全部历史"
L["RECENT_WHISPERS"] = "最近密语"
L["SNIPPETS"]        = "短语"
L["SNIPPET_TRIGGER"] = "触发词"
L["SNIPPET_TEXT"]    = "内容"
L["SNIPPET_SAVE"]    = "保存"
L["SNIPPET_DELETE"]  = "删除"
L["SNIPPET_NEW"]     = "新建短语"
L["SNIPPET_SHARE"]   = "分享短语"
L["SNIPPET_EXPORT"]  = "导出全部"
L["SNIPPET_IMPORT"]  = "导入"
L["SNIPPET_RESET"]   = "重置短语"
L["AUTOCOMPLETE"]    = "自动补全"
L["AUTOCOMPLETE_POS"] = "自动补全位置"
L["CHANNEL_POS"]     = "频道名称位置"
L["AUTO_HIDE_CHANNEL"] = "自动隐藏频道名称（悬停时显示）"
L["LAYOUT_OPTIONS"]  = "布局选项"
L["ANCHOR_EDITOR"]   = "锚点编辑器"
L["OPEN_ANCHOR_EDITOR"] = "打开锚点编辑器"
L["ABOUT"]           = "关于"
L["ABOUT_DESC"]      = "一个大型可定制的聊天输入框，带有频道显示、锚点编辑器和完整的外观控制。"
L["PROFILES"]        = "配置文件"
L["SAVE_STYLE"]      = "保存样式"
L["DELETE_STYLE"]    = "删除样式"
L["DYNAMIC_HEIGHT"]  = "动态高度"
L["DYNAMIC_WIDTH"]   = "动态宽度"
L["CHAR_COUNTER_POS"] = "字符计数器位置"
L["LONG_MESSAGES"]   = "长消息"
L["LONG_MSG_OFF"]    = "关闭"
L["LONG_MSG_SILENT"] = "静默"
L["LONG_MSG_NOTICE"] = "提示"
L["LONG_MSG_CONFIRM"] = "确认"
L["LONG_MSG_DESC_OFF"]     = "消息在 255 个字符处截断（默认魔兽行为）。"
L["LONG_MSG_DESC_SILENT"]  = "自动分割为多条消息。"
L["LONG_MSG_DESC_NOTICE"]  = "分割并打印发送了多少部分。"
L["LONG_MSG_DESC_CONFIRM"] = "分割前请求确认。"
L["IMPORT_STYLE_BTN"]  = "导入样式字符串"
L["FINISH_CONFIG_BTN"] = "完成 + 设置"
L["BG_COLOR"]          = "背景颜色"
L["MSG_SPLIT_NOTICE"]  = "消息已分割为 %d 部分（%d 个字符）。"

-- ── v5.3.3 Keybinding strings ─────────────────────────────────────────────────
L["HELP_KEYBINDINGS_TITLE"] = "-- 快捷键 --"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+Enter 切换到暴雪默认聊天（在任何地方都有效）。\n适用于不能直接插入 BCB 的 Shift 点击（坐骑、\n成就、玩具箱、天赋、法术书）。在暴雪输入框中输入，\n然后按 Enter 发送。BCB 在您下次按 Enter 时恢复。\n\n您可以在高级标签页或\n「Esc > 按键绑定 > 插件 > BigChatBox」中重新绑定或解除绑定。"

-- ── v5.5.0 Welcome Panel ─────────────────────────────────────────────────────
L["WELCOME_TITLE"]          = "欢迎使用 BigChatBox！"
L["WELCOME_SUBTITLE"]       = "首次安装设置"
L["WELCOME_TEXT"]           = "BigChatBox 将魔兽世界的小聊天输入框替换为大型、完全可定制的输入框。\n\n您可以更改大小、背景、边框、字体和颜色----或选择现成的样式。聊天历史、文字短语和智能自动补全等功能均已内置，可随时开关。\n\n此快速设置将在不到一分钟内帮您完成配置。"
L["WELCOME_SETUP_BTN"]      = "设置 BigChatBox"
L["WELCOME_LANG_LBL"]       = "显示语言："
L["WELCOME_STYLE_TITLE"]    = "选择您的样式！"
L["WELCOME_LAYOUT_TITLE"]   = "选择布局"
L["WELCOME_FEATURES_TITLE"] = "选择您的功能！"
L["WELCOME_ADVANCED_TITLE"] = "高级功能"
L["WELCOME_FINAL_TITLE"]    = "即将完成！"
L["WELCOME_FINISH_BTN"]     = "完成！"
L["WELCOME_QUIT_CONFIRM"]   = "确定要退出设置吗？将使用默认设置。"
L["WELCOME_KEYBIND_INFO"]   = "大多数 Shift 点击链接可直接插入 BigChatBox。对于少数不支持的（如坐骑、玩具和天赋），此快捷键可切换到暴雪的聊天输入框。"
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBox 在战斗、大秘境、竞技场和定级战场中自动暂停，以保护您的聊天。"
L["WELCOME_THANKS"]         = "感谢使用 BigChatBox！"
L["WELCOME_SECURE_TITLE"]   = "安全内容"
L["WELCOME_KEYBIND_TITLE"]  = "暴雪聊天快捷键"
L["WELCOME_CONFIG_HINT"]    = "随时输入 /bcb 打开完整设置窗口。"
L["FEATURE_HISTORY_DESC"]   = "保存您发送的消息及时间戳。"
L["FEATURE_SNIPPETS_DESC"]  = "按回车时展开的文字快捷方式。"
L["FEATURE_AC_SNIPPETS_DESC"]  = "自动补全以 ! 开头的短语触发词。"
L["FEATURE_AC_COMMANDS_DESC"]  = "自动补全斜杠命令，如 /dance、/guild。"
L["FEATURE_AC_WHISPERS_DESC"]  = "密语时自动补全玩家名称。"
L["FEATURE_MOUSEWHEEL_DESC"]   = "用鼠标滚轮滚动浏览之前的消息。"
L["FEATURE_GLOBAL_PROFILE_DESC"] = "在此账户下的所有角色间共享设置。"
L["FEATURE_KEEP_OPEN_DESC"]    = "点击其他地方时输入框保持可见。"
L["RESTART_SETUP_CONFIRM"]  = "这将重置所有设置并重新启动欢迎向导。确定吗？"

-- ── v5.6.0 Patch notes UI ────────────────────────────────────────────────────
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox -- 新功能"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox -- 更新日志"
L["PATCHNOTES_DONT_SHOW"]      = "不再显示"
L["PATCHNOTES_GOT_IT"]         = "知道了！"
L["PATCHNOTES_PREVIOUS"]       = "-- 历史更新 --"

-- ── Keys added during source wiring (v5.6.0 localization pass) ───────────────

-- Features tab
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffff关闭|r -- 消息在 255 个字符处截断（默认魔兽行为）。\n|cffffffff静默|r -- 自动分割为多条消息。\n|cffffffff提示|r -- 分割并打印发送了多少部分。\n|cffffffff确认|r -- 分割前请求确认。"

-- Snippets tab
L["SNIPPET_NOTHING_TO_EXPORT"] = "没有可导出的短语。"

-- History tab
L["HISTORY_LENGTH_LABEL"] = "历史记录长度"

-- ConfigMain print messages
L["PRINT_RESET_ALL"]         = "所有设置已重置为默认值。正在重新加载..."
L["PRINT_RESET_APPEARANCE"]  = "外观已重置。正在重新加载..."
L["PRINT_RESET_PLACEMENT"]   = "位置已重置。正在重新加载..."
L["PRINT_RESET_HISTORY"]     = "历史记录已重置。正在重新加载..."
L["PRINT_SNIPPETS_REMOVED"]  = "所有短语已删除。"
L["PRINT_STYLES_REMOVED"]    = "所有自定义样式已删除。"
L["PRINT_NO_STYLE_STRING"]   = "未提供样式字符串。"
L["PRINT_STYLE_DECODE_FAIL"] = "解码样式字符串失败，可能已损坏。"
L["PRINT_STYLE_INVALID"]     = "无效的样式字符串。期望 !BCB1: 或 BCB: 前缀。"
L["PRINT_STYLE_IMPORTED"]    = "样式已导入！"
L["PRINT_STYLE_SAVED"]       = "样式 '%s' 已保存。"
L["PRINT_STYLE_DELETED"]     = "样式 '%s' 已删除。"
L["PRINT_SNIPPET_INVALID"]   = "无效的短语字符串。"
L["PRINT_SNIPPET_REMOVED"]   = "短语 '%s' 已删除。"
L["PRINT_SNIPPETS_IMPORTED"] = "已导入 %d 条短语。"
L["PRINT_SNIPPETS_SKIPPED"]  = " %d 条已跳过（已存在）。"
L["PRINT_CANT_DELETE_DEFAULT"] = "无法删除默认样式。"
L["PRINT_SETUP_SKIPPED"]     = "设置已跳过。随时输入 |cff55ccff/bcb|r 进行配置。"
L["BTN_RESET_STYLES_CONFIRM"] = "重置样式"

-- SlashCommands popups
L["POPUP_WIPE_WHISPERS"]     = "清除密语历史记录？此操作无法撤销。"

-- WelcomePanel
L["WELCOME_CHOOSE_STYLE"]      = "选择样式："
L["WELCOME_STYLE_NOTE"]        = "标有插件名称的样式需要安装相应插件。\n您可以在设计标签页中完全自定义所有内容。"
L["WELCOME_LAYOUT_DESC"]       = "选择频道名称和自动补全相对于输入框的显示位置。"
L["WELCOME_CHANNEL_POS_LBL"]   = "频道名称位置："
L["WELCOME_AC_POS_LBL"]        = "自动补全位置："
L["WELCOME_AUTOHIDE_HELP"]     = "频道名称淡出，直到您将鼠标悬停在输入框上。"
L["WELCOME_CHARCOUNTER_LBL"]   = "字符计数器位置："
L["WELCOME_FEATURES_DESC"]     = "切换您想要的功能。所有功能默认启用。\n您可以随时在功能标签页中更改这些设置。"
L["WELCOME_LONGMSG_LBL"]       = "长消息（超过 255 个字符）："
L["LONGMSG_DESC_OFF"]          = "在 255 个字符处截断"
L["LONGMSG_DESC_SILENT"]       = "自动分割"
L["LONGMSG_DESC_NOTICE"]       = "分割并显示提示"
L["LONGMSG_DESC_CONFIRM"]      = "分割前询问"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "了解更多关于战斗锁定的信息"
L["WELCOME_WHY_KEYBIND"]       = "为什么需要这个？"
L["WELCOME_CURRENT_KEYBIND"]   = "当前快捷键："
L["WELCOME_KEYBIND_CLICK_HINT"] = "点击设置 · 右键点击解除绑定"
L["WELCOME_OPEN_HELP"]         = "打开帮助与技巧窗口"
L["WELCOME_HELP_DESC"]         = "所有命令、快捷键和功能详情均可在帮助窗口中找到。"
L["WELCOME_RELOAD_NOTE"]       = "两个按钮都将重新加载您的界面。"
L["WELCOME_COMBAT_PAUSE"]      = "设置已暂停----进入战斗。"
L["WELCOME_SHIFTCLICK_TITLE"]  = "Shift 点击链接插入"
L["WELCOME_FEAT_HISTORY"]      = "聊天历史"
L["WELCOME_FEAT_SNIPPETS"]     = "短语系统"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "自动补全：!短语"
L["WELCOME_FEAT_AC_COMMANDS"]  = "自动补全：/命令"
L["WELCOME_FEAT_AC_WHISPER"]   = "自动补全：密语名称"
L["WELCOME_FEAT_AC_BNET"]      = "自动补全：Battle.net 好友"
L["WELCOME_FEAT_KEEP_OPEN"]    = "保持输入框开启"

-- WelcomePanel navigation
L["BTN_PREVIOUS"]  = "上一步"
L["BTN_NEXT"]      = "下一步"

-- ── Language selector (Advanced tab) ─────────────────────────────────────────
L["SECTION_LANGUAGE"]        = "语言"
L["LANGUAGE_DESC"]           = "覆盖显示语言。需要重新加载界面。"
L["LANGUAGE_CLIENT"]         = "客户端语言"
L["LANGUAGE_RELOAD_MSG"]     = "语言已更改。正在重新加载界面..."
L["POPUP_CHANGE_LANGUAGE"]   = "更改语言并重新加载界面？"
L["BTN_RELOAD_CONFIRM"]      = "重新加载"
L["LANGUAGE_COMING_SOON"]    = "|cff888888（即将推出）|r"

-- ── Help popup body strings ───────────────────────────────────────────────────
L["HELP_WINDOW_TITLE"] = "BigChatBox 帮助"

L["HELP_BODY_MAIN"] = [[|cffffd100-- 命令 --|r
|cffffd100/bcb|r 或 |cffffd100/bcb config|r -- 打开设置窗口。
|cffffd100/bcb edit|r -- 打开锚点编辑器以重新定位。
|cffffd100/bcb reset|r -- 将位置重置为默认值。

|cffffd100-- 聊天基础 --|r
|cffffd100左键点击|r频道名称以切换频道（普通、队伍、公会等）。
|cffffd100右键点击|r频道名称以访问设置、历史记录和清除选项。
|cffffd100Enter|r 发送消息。|cffffd100Escape|r 清除并关闭。
在输入框上|cffffd100滚动鼠标滚轮|r可浏览聊天历史。

|cffffd100-- 自动补全 --|r
输入 |cffffd100/|r 查看匹配的斜杠命令（Tab 循环，Enter 确认）。
输入 |cffffd100!|r 自动补全短语触发词（如 !guild、!inv）。
密语名称可从好友、公会、队伍和最近密语中自动补全。
|cffffd100Tab|r / |cffffd100Shift+Tab|r 循环浏览建议。

|cffffd100-- 短语 --|r
定义按 Enter 时展开的文字快捷方式。
示例：!guild 可展开为「LFM 大秘境，密语邀请！」
每个短语可限制到特定频道。
在|cff5599ff短语|r标签页中管理、创建、导入和导出短语。

|cffffd100-- 链接插入 --|r
|cffffd100Shift+点击|r物品、法术、成就等以插入链接。
适用于背包、法术书、成就面板、专业技能和聊天输出。
|cffffd100悬停|r输入框中的链接以预览提示。
对于不支持直接插入的面板，请参阅|cff5599ffShift 点击说明|r按钮。

|cffffd100-- 自定义 --|r
|cff5599ff设计|r标签页可自定义背景、边框、字体和颜色。
|cff5599ff位置|r标签页有用于精确定位的锚点编辑器。
将您的外观保存为命名样式。导出和导入样式字符串以分享。
如果安装了 LibSharedMedia，则支持 LSM 纹理和字体。

|cffffd100-- 工具与开关 --|r
|cff5599ff功能|r标签页可启用或禁用各项功能：
自动补全、短语、链接悬停提示、聊天历史等。
|cffffd100保持开启|r模式可在输入框失去焦点时保持可见。

|cffffd100-- 配置文件与样式 --|r
设置默认按角色保存。
在高级设置中启用|cffffd100对所有角色使用|r以全局共享设置。
样式保存您的视觉外观（背景、边框、字体、颜色）。
使用导出/导入与好友或在角色间分享样式。

|cffffd100-- 位置与大小 --|r
锚点编辑器可让您拖动输入框到新位置。
方向键每次微调 1 像素以实现精度。
Shift+拖动可对称调整输入框大小。
|cffffd100Shift+Alt+点击|r输入框可将位置重置到屏幕中央。
您也可以在锚点编辑器的信息面板中设置精确的位置和大小值。

|cffffd100-- 长消息 --|r
超过 255 个字符的消息可自动分割为多条发送。
在|cff5599ff功能|r标签页中配置行为：关闭、静默、提示或确认。
字符计数器显示距离上限还有多远。

|cffffd100-- 动态大小 --|r
在设计标签页中启用|cffffd100动态高度|r和|cffffd100动态宽度|r。
高度随字体大小调整，宽度随消息长度增长。]]

L["HELP_BODY_SECURE"] = "|cffffd100-- 为什么 BigChatBox 在战斗/大秘境等场景中暂停 --|r\n\n" ..
    "随着暗夜传说资料片（12.0）的推出，暴雪对插件在战斗中与游戏的交互方式进行了重大更改。这项举措被称为|cff5599ff插件解除武装|r，限制了插件处理战斗信息的方式。\n\n" ..
    "|cffffd100发生了什么变化？|r\n" ..
    "与战斗相关的数据现在被视为|cffff9900「秘密值」|r。插件可以显示这些信息，但不能在代码中读取或处理。\n\n" ..
    "许多界面框架现在在战斗中受到|cffff9900保护|r。在副本内容（大秘境、竞技场、定级战场）中，限制更为严格。任何修改或挂钩这些受保护框架的插件都有传播|cffff6666污染|r的风险，这可能完全破坏游戏功能----不仅是插件，还包括选中目标、施放法术和使用技能等核心游戏功能。\n\n" ..
    "|cffffd100这对 BigChatBox 有何影响？|r\n" ..
    "魔兽世界的默认聊天输入框（ChatFrame1EditBox）是一个受保护的框架，因为它处理 /target、/cast 和 /focus 等安全斜杠命令。BigChatBox 挂钩此框架以拦截聊天输入。在战斗和副本竞技内容中，这些挂钩可能导致污染，从而阻断您的整个聊天系统。\n\n" ..
    "为了保护您，BigChatBox 在战斗期间以及大秘境、竞技场和定级战场期间|cff00ff00自动暂停|r。暴雪的默认聊天输入框会无缝接管。当战斗结束或内容完成后，BigChatBox 会自动恢复。\n\n" ..
    "|cffffd100为什么不直接修复它？|r\n" ..
    "这不是一个|cffff0000Bug！|r这是魔兽世界安全模型中的根本性限制。每个在战斗中修改受保护框架的插件都面临同样的限制。暴雪设计这些限制是为了防止插件自动化战斗决策，而聊天输入框恰好在受保护范围内。\n\n" ..
    "|cffffd100总结|r\n" ..
    "BigChatBox 在战斗期间以及计时竞技副本（大秘境、竞技场、定级战场）期间暂停。在这些活动中，您仍然可以使用暴雪内置的聊天输入框正常聊天。当战斗结束或活动完成后，BigChatBox 会自动恢复。"

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100-- 为什么不是所有 Shift 点击都有效？ --|r\n\n" ..
    "大多数 Shift 点击链接插入在 BigChatBox 中可以直接使用。但是，少数游戏面板使用内部暴雪函数，这些函数只能将链接插入暴雪自己的聊天输入框，绕过任何插件输入框。\n\n" ..
    "|cff00ff00在 BigChatBox 中有效：|r\n" ..
    "  · 个人背包中的物品\n" ..
    "  · 宠物日志中的宠物\n" ..
    "  · 传家宝面板中的传家宝\n" ..
    "  · 商人面板中的物品\n" ..
    "  · 邮箱中的物品\n" ..
    "  · 专业技能面板中的制作配方和材料\n" ..
    "  · 聊天窗口中的链接\n\n" ..
    "|cffff9900需要暴雪聊天：|r\n" ..
    "  · 成就面板中的成就\n" ..
    "  · 银行面板中的物品\n" ..
    "  · 公会银行面板中的物品\n" ..
    "  · 坐骑日志中的坐骑\n" ..
    "  · 天赋面板中的天赋\n" ..
    "  · 外观衣柜中的外观\n" ..
    "  · 某些资料片特定面板\n\n" ..
    "|cffffd100为什么？|r\n" ..
    "这些面板使用魔兽世界的内部|cff5599ffChatEdit_InsertLink|r函数，该函数专门检查暴雪的输入框。BigChatBox 拦截了大多数此类调用，但由于暴雪的实现方式，某些面板完全绕过了标准挂钩。这是魔兽世界 API 的限制，不是 Bug。\n\n" ..
    "|cffffd100解决方案|r\n" ..
    "|cff5599ff暴雪聊天快捷键|r（默认：Ctrl+Enter）可立即切换到暴雪的原生聊天输入框。在那里输入或 Shift 点击您需要的内容，按 Enter 发送，BigChatBox 将在您下一条消息时自动恢复。\n\n" ..
    "您可以在以下位置重新绑定或解除绑定此快捷键：\n" ..
    "  · |cffffd100/bcb|r > 高级标签页\n" ..
    "  · Esc > 按键绑定 > 插件 > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "切换到 %s 并重新启动设置？\nBigChatBox 将重新加载以应用新语言。"

-- ── v5.6.1 Emoji & Emoticon picker ───────────────────────────────────────────
L["SECTION_EMOJI"]          = "颜文字选择器"
L["CB_SHOW_EMOJI_PICKER"]   = "显示颜文字选择器按钮"
L["EMOJI_PICKER_TITLE"]     = "颜文字选择器"
L["EMOJI_PICKER_TOOLTIP"]   = "点击打开颜文字选择器"
L["EMOJI_TAB_LAST"]         = "最近使用"
L["EMOJI_TAB_ASCII"]        = "颜文字"
L["EMOJI_LAST_EMPTY"]       = "暂无最近选择记录。"

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "搜索历史记录..."

L["BTN_SAVE_SNIPPET"]           = "保存"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "使用默认样式"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "勾选后，多行输入框将使用默认样式，与当前活动样式无关。取消勾选以使用您当前的BCB外观。"

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "多行输入"
L["CB_ENABLE_MULTILINE"]        = "启用多行输入"
L["CB_ENABLE_MULTILINE_HELP"]   = "打开一个大型多行输入框以撰写多行消息。每行将单独发送。"
L["KEYBIND_OPEN_MULTILINE"]     = "打开多行输入："
L["MULTILINE_KEYBIND_HELP"]     = "默认：Shift+Enter。打开一个大型输入框，Enter添加新行，Shift+Enter发送所有行。"
L["BTN_OPEN_KEYBINDINGS"]       = "打开快捷键设置"
L["MULTILINE_SEND_BTN"]         = "发送"
L["MULTILINE_CHANNEL_LABEL"]    = "频道：%s"
L["MULTILINE_BLOCKED_SECURE"]   = "在M+/竞技场/评分战场期间无法使用多行输入。"
L["MULTILINE_HINT"]             = "Enter = 换行   |   Shift+Enter = 全部发送"
