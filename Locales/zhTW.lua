-- BigChatBox Localization - Traditional Chinese (zhTW)
-- Version: 5.6.1
-- Full translation for 5.6.1 locale system. Overrides all keys that differ from enUS.
-- Missing keys fall back to enUS automatically.

local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "zhTW" and (BigChatBox and BigChatBox._forcedLocale) ~= "zhTW" then return end

-- ── Addon identity ────────────────────────────────────────────────────────────
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "版本"
L["LOADED_MSG"]   = "BigChatBox v%s 已載入！輸入 /bcb 開啟選項。"

-- ── Config window tabs ────────────────────────────────────────────────────────
L["TAB_GENERAL"]   = "一般"
L["TAB_DESIGNER"]  = "設計"
L["TAB_PLACEMENT"] = "位置"
L["TAB_FEATURES"]  = "功能"
L["TAB_SNIPPETS"]  = "片段"
L["TAB_HISTORY"]   = "歷史"
L["TAB_ADVANCED"]  = "進階"
L["TAB_RESET"]     = "重置"

-- ── Reset tab ─────────────────────────────────────────────────────────────────
L["RESET_TAB_HEADER"]       = "重置與還原"
L["RESET_TAB_DESC"]         = "這些操作是永久性的，無法復原。"
L["RESET_ALL_HELP"]         = "重置所有內容：位置、外觀、歷史記錄和片段。"
L["RESET_APPEARANCE_HELP"]  = "僅重置背景、邊框、字型和顏色。"
L["RESET_PLACEMENT_HELP"]   = "將位置和大小重置為預設值。"
L["RESET_HISTORY_HELP"]     = "清除所有已儲存的聊天和密語歷史記錄。"
L["RESET_SNIPPETS_HELP"]    = "刪除所有片段。"
L["RESET_STYLES_HELP"]      = "刪除所有已儲存的自訂樣式。"
L["RESTART_SETUP_HELP"]     = "重置所有設定並重新執行初次設定精靈。"

-- ── Shared UI ─────────────────────────────────────────────────────────────────
L["PREVIEW"]        = "預覽"
L["TYPE_SOMETHING"] = "在此輸入..."
L["CLOSE"]          = "關閉"
L["ACTIONS"]        = "操作"
L["RESET"]          = "重置"
L["OK"]             = "確定"
L["CANCEL"]         = "取消"
L["YES"]            = "是"
L["NO"]             = "否"
L["SAVE"]           = "儲存"
L["DELETE"]         = "刪除"
L["EDIT"]           = "編輯"
L["IMPORT"]         = "匯入"
L["EXPORT"]         = "匯出"
L["DUPLICATE"]      = "複製"
L["SHARE"]          = "分享"
L["ENABLED"]        = "已啟用"
L["DISABLED"]       = "已停用"

-- ── General tab ───────────────────────────────────────────────────────────────
L["BTN_VIEW_PATCH_NOTES"]     = "查看更新說明"
L["BTN_HELP_AND_TIPS"]        = "說明與技巧"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "戰鬥鎖定資訊"
L["BTN_SHIFT_CLICK_INFO"]     = "Shift 點擊說明"

-- General tab feature grid
L["CELL_SNIPPETS_HDR"]       = "|cff5599ff片段|r"
L["CELL_SNIPPETS_DESC"]      = "發送時展開的文字捷徑。\n在片段標籤頁中管理。"
L["CELL_ANCHOR_HDR"]         = "|cff5599ff錨點編輯器|r"
L["CELL_ANCHOR_DESC"]        = "點擊並拖曳以重新定位。\n方向鍵可進行像素精度調整。"
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ff自動完成|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "智慧 Tab 補全指令、密語\n和片段觸發詞（!公會）。"
L["CELL_HISTORY_HDR"]        = "|cff5599ff聊天歷史|r"
L["CELL_HISTORY_DESC"]       = "完整歷史記錄含時間戳記。\n滾動滑鼠滾輪瀏覽。"
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ff自訂|r"
L["CELL_CUSTOMIZATION_DESC"] = "設計標籤頁可設定背景、邊框、\n字型、顏色。儲存並分享樣式。"
L["CELL_SECURE_HDR"]         = "|cffff9900安全內容|r"
L["CELL_SECURE_DESC"]        = "在大秘境、競技場和定級戰場中\n自動暫停以保護您的聊天。"
L["CELL_SHARING_HDR"]        = "|cff5599ff分享|r"
L["CELL_SHARING_DESC"]       = "將樣式和片段匯出為短字串\n與好友分享。"
L["CELL_LONGMSG_HDR"]        = "|cff5599ff長訊息|r"
L["CELL_LONGMSG_DESC"]       = "超過 255 個字元的訊息會\n自動分割。靜音、通知或確認。"

-- ── Styles (Designer tab) ─────────────────────────────────────────────────────
L["STYLES"]              = "樣式"
L["ACTIVE_STYLE"]        = "目前樣式"
L["BTN_SAVE_STYLE"]      = "儲存樣式"
L["BTN_DELETE_STYLE"]    = "刪除樣式"
L["BTN_EXPORT_STYLE"]    = "匯出樣式"
L["BTN_IMPORT_STYLE"]    = "匯入樣式"

-- ── Designer tab sections ─────────────────────────────────────────────────────
L["SECTION_SIZE"]         = "大小"
L["SECTION_BACKGROUND"]   = "背景"
L["SECTION_BORDER"]       = "邊框"
L["SECTION_FONTS"]        = "字型"
L["SECTION_TEXT_OPTIONS"] = "文字選項"

-- Designer tab slider / dropdown labels
L["LABEL_WIDTH"]              = "寬度"
L["LABEL_HEIGHT"]             = "高度"
L["LABEL_SCALE"]              = "縮放"
L["LABEL_BG_TEXTURE"]         = "背景材質"
L["LABEL_BG_OPACITY"]         = "背景不透明度"
L["LABEL_BG_BRIGHTNESS"]      = "背景亮度"
L["LABEL_BG_SCALE"]           = "背景縮放"
L["LABEL_TINT_INTENSITY"]     = "色調強度"
L["LABEL_BORDER_TEXTURE"]     = "邊框材質"
L["LABEL_BORDER_OPACITY"]     = "邊框不透明度"
L["LABEL_BORDER_BRIGHTNESS"]  = "邊框亮度"
L["LABEL_BORDER_THICKNESS"]   = "邊框粗細"
L["LABEL_CHANNEL_FONT"]       = "頻道字型"
L["LABEL_INPUT_FONT"]         = "輸入字型"
L["LABEL_CHANNEL_FONT_SIZE"]  = "頻道字型大小"
L["LABEL_INPUT_FONT_SIZE"]    = "輸入字型大小"
L["LABEL_TEXT_ALIGNMENT"]     = "文字對齊"
L["LABEL_FONT_OUTLINE"]       = "字型外框"

-- Designer tab checkboxes
L["CB_DYNAMIC_HEIGHT"]   = "動態高度"
L["CB_DYNAMIC_WIDTH"]    = "動態寬度"
L["CB_TINT_BG"]          = "以頻道顏色為背景著色"
L["CB_MATCH_TEXT_COLOR"] = "文字顏色符合頻道顏色"

-- ── Placement tab ─────────────────────────────────────────────────────────────
L["SECTION_LAYOUT_OPTIONS"]   = "版面配置選項"
L["SECTION_POSITION"]         = "位置"
L["LABEL_CHANNEL_NAME_POS"]   = "頻道名稱位置"
L["CB_SHOW_CHANNEL"]           = "顯示頻道名稱"
L["LABEL_AUTOCOMPLETE_POS"]   = "自動完成位置"
L["LABEL_CHAR_COUNTER_POS"]   = "字元計數器位置"
L["CB_AUTO_HIDE_CHANNEL"]     = "自動隱藏頻道名稱（滑鼠移入時顯示）"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "開啟錨點編輯器"

-- ── Features tab ─────────────────────────────────────────────────────────────
L["SECTION_FEATURE_TOGGLES"]  = "功能開關"
L["FEATURE_TOGGLES_DESC"]     = "啟用或停用 BigChatBox 功能。"
L["SECTION_SNIPPET_SYSTEM"]   = "片段系統"
L["SECTION_AUTOCOMPLETE"]     = "自動完成"
L["SECTION_HISTORY"]          = "歷史記錄"
L["SECTION_LINK_HOVER"]       = "連結滑入"
L["SECTION_LONG_MESSAGES"]    = "長訊息"
L["CB_ENABLE_SNIPPETS"]       = "啟用片段系統"
L["CB_AC_COMMANDS"]           = "斜線指令自動完成（/dance、/guild 等）"
L["CB_AC_WHISPER"]            = "密語名稱自動完成（/w <名稱>）"
L["CB_AC_SNIPPETS"]           = "片段觸發詞自動完成（!guild 等）"
L["CB_AC_BNET"]               = "在密語自動完成中顯示 Battle.net 好友"
L["CB_ENABLE_HISTORY"]        = "啟用聊天歷史"
L["CB_MOUSEWHEEL_HISTORY"]    = "以滑鼠滾輪捲動歷史記錄"
L["CB_LINK_HOVER"]            = "滑入連結時顯示提示"
L["LABEL_MSG_EXCEEDS_255"]    = "當訊息超過 255 個字元時"

-- ── Snippets tab ──────────────────────────────────────────────────────────────
L["SNIPPETS_DISABLED_MSG"]    = "片段系統已停用。\n請在功能標籤頁中啟用。"
L["SNIPPETS_HEADER"]          = "片段"
L["SNIPPETS_DESC"]            = "在聊天中輸入片段觸發詞（例如 !guild），按 Enter 發送即可展開。"
L["SNIPPET_EDIT_HEADER"]      = "編輯"
L["SNIPPET_ACTIVE"]           = "片段已啟用"
L["SNIPPET_TRIGGER_LBL"]      = "觸發詞："
L["SNIPPET_TEXT_LBL"]         = "內容："
L["SNIPPET_CHANNEL_LBL"]      = "發送至："
L["SNIPPET_GLOBAL"]           = "對所有角色可用"
L["SNIPPET_EMPTY_LIST"]       = "尚無片段。\n點擊「新增片段」或\n「匯入」以開始。"
L["BTN_NEW_SNIPPET"]          = "新增片段"
L["BTN_EXPORT_ALL"]           = "全部匯出"
L["BTN_SHARE_SNIPPET"]        = "分享"
L["BTN_DUPLICATE_SNIPPET"]    = "複製"
L["BTN_DELETE_SNIPPET"]       = "刪除"
L["BTN_IMPORT_SNIPPET"]       = "匯入"

-- ── History tab ───────────────────────────────────────────────────────────────
L["HISTORY_HEADER"]           = "聊天歷史"
L["HISTORY_HELP"]             = "點擊文字以重複使用。滑入可查看時間戳記。點擊 X 標記刪除。"
L["HISTORY_EMPTY"]            = "尚無歷史記錄。"
L["HISTORY_MORE"]             = "... 還有 %d 筆"
L["WHISPERS_HEADER"]          = "最近密語"
L["WHISPERS_CLICK_HINT"]      = "（點擊以密語）"
L["WHISPERS_EMPTY"]           = "沒有密語歷史記錄。"
L["BTN_WIPE_HISTORY"]         = "清除全部歷史"
L["BTN_WIPE_COMMANDS"]        = "清除所有 /指令"
L["BTN_REMOVE_ENTRIES"]       = "刪除所選項目"

-- ── Advanced tab ──────────────────────────────────────────────────────────────
L["SECTION_PROFILES"]         = "設定檔"
L["PROFILES_DESC"]            = "設定依角色個別儲存。啟用後將在所有角色間共享。"
L["CB_GLOBAL_PROFILE"]        = "對所有角色使用"
L["BEHAVIOR"]                 = "行為"
L["KEEP_OPEN"]                = "保持輸入框開啟直到按 Escape"
L["KEEP_OPEN_HELP"]           = "啟用後，點擊其他地方輸入框仍保持可見。按 Escape 關閉。"
L["SHOW_LOCKDOWN_WARNING"]    = "顯示安全內容警告"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "在大秘境、競技場和定級戰場中 BCB 暫停時在聊天中顯示提示訊息。"
L["IGNORE_COMMANDS_HISTORY"]  = "歷史記錄中忽略 /指令"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "/target、/cast 等斜線指令不會儲存在聊天歷史中。"
L["SHOW_MINIMAP_BUTTON"]      = "顯示小地圖按鈕"
L["SHOW_MINIMAP_BUTTON_HELP"] = "左鍵點擊開啟設定，右鍵點擊開啟快速設定。插件列按鈕始終可用。"
L["HIDE_LOGIN_MSG"]           = "隱藏登入訊息"
L["HIDE_LOGIN_MSG_HELP"]      = "隱藏登入時顯示的「BigChatBox 已載入」訊息。"
L["KEYBIND_OPEN_BLIZZARD"]    = "開啟暴雪聊天："
L["KEYBIND_NOT_BOUND"]        = "未綁定"
L["KEYBIND_PRESS_KEY"]        = "按下一個鍵..."
L["KEYBIND_CONFLICT"]         = "%s 已綁定到 %s。是否覆蓋？"
L["KEYBIND_TOOLTIP_BOUND"]    = "開啟暴雪聊天（%s）"
L["KEYBIND_TOOLTIP_UNBIND"]   = "右鍵點擊以解除綁定"
L["KEYBIND_TOOLTIP_SET"]      = "點擊設定快速鍵"
L["KEYBIND_HELP"]             = "開啟暴雪原生聊天框，用於 Shift 點擊坐騎、成就、玩具和天賦。預設：Ctrl+Enter。"
L["RESET_ALL"]                = "重置所有設定"
L["RESET_APPEARANCE"]         = "重置外觀"
L["RESET_PLACEMENT"]          = "重置位置"
L["RESET_HISTORY_BTN"]        = "重置歷史"
L["RESET_SNIPPETS_BTN"]       = "重置片段"
L["RESET_STYLES_BTN"]         = "重置樣式"
L["RESTART_SETUP"]            = "重新執行精靈"

-- ── Reset / action confirmations (StaticPopupDialogs) ────────────────────────
L["POPUP_RESET_ALL"]          = "將所有 BigChatBox 設定重置為預設值？\n包括位置、大小、外觀和字型。"
L["POPUP_RESET_APPEARANCE"]   = "將外觀重置為預設值？\n不影響位置或歷史記錄。"
L["POPUP_RESET_PLACEMENT"]    = "將位置重置為預設值？\n這將重新載入介面。"
L["POPUP_RESET_HISTORY"]      = "重置所有聊天歷史和密語歷史？\n歷史記錄長度將設定為 100。\n這將重新載入介面。"
L["POPUP_RESET_SNIPPETS"]     = "刪除所有片段？這將重新載入介面。"
L["POPUP_RESET_STYLES"]       = "刪除所有使用者建立的樣式？\n預設樣式將保留並成為目前樣式。\n這將重新載入介面。"
L["POPUP_WIPE_HISTORY"]       = "清除全部聊天歷史？\n這也將重新載入介面。"
L["POPUP_WIPE_COMMANDS"]      = "從聊天歷史中刪除所有 /指令？\n一般訊息將保留。\n這也將重新載入介面。"
L["POPUP_DELETE_STYLE"]       = "刪除目前樣式？"
L["POPUP_OVERWRITE_STYLE"]    = "名為「%s」的樣式已存在。覆蓋它？"
L["POPUP_SAVE_STYLE_TEXT"]    = "為此樣式輸入名稱："
L["POPUP_EXPORT_STYLE_TEXT"]  = "複製下方樣式字串："
L["POPUP_IMPORT_STYLE_TEXT"]  = "貼上樣式字串："
L["POPUP_NAME_IMPORT_STYLE"]  = "將匯入的樣式儲存為："
L["POPUP_DELETE_SNIPPET"]     = "刪除片段「%s」？"
L["POPUP_SHARE_SNIPPET_TEXT"] = "複製片段字串（Ctrl+C）："
L["POPUP_IMPORT_SNIPPET_TEXT"] = "貼上片段字串（Ctrl+V）："
L["POPUP_RESTART_SETUP"]      = "這將重置所有設定並重新啟動歡迎精靈。\n確定嗎？"
L["POPUP_QUIT_SETUP"]         = "確定要退出設定嗎？\n將使用預設設定。"
L["BTN_RESET_ALL_CONFIRM"]    = "全部重置"
L["BTN_WIPE_CONFIRM"]         = "是，清除"
L["BTN_DELETE_CONFIRM"]       = "刪除"
L["BTN_OVERWRITE_CONFIRM"]    = "覆蓋"
L["BTN_SKIP"]                 = "略過"
L["BTN_RESTART_SETUP_CONFIRM"] = "重新執行精靈"
L["BTN_QUIT_SETUP_CONFIRM"]   = "退出設定"
L["BTN_SAVE_CLOSE"]           = "關閉"

-- ── Slash commands / print messages ──────────────────────────────────────────
L["SLASH_POSITION_RESET"]     = "位置已重置為預設值"
L["SLASH_ANCHOR_UNAVAILABLE"] = "錨點編輯器不可用。"
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox：|r 聊天歷史已清除。"
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox：|r 外觀已重置為預設值"
L["RESET_DONE"]               = "所有設定已重置為預設值。"
L["COMBAT_CLOSE"]             = "進入戰鬥，設定已關閉。"
L["COMBAT_BLOCKED"]           = "戰鬥中無法開啟設定。"

-- ── Position / size labels (legacy keys) ─────────────────────────────────────
L["POSITION"]        = "位置"
L["X_POSITION"]      = "X 座標"
L["Y_POSITION"]      = "Y 座標"
L["SIZE"]            = "大小"
L["WIDTH"]           = "寬度"
L["HEIGHT"]          = "高度"
L["SCALE"]           = "縮放"
L["FONT_SIZES"]      = "字型大小"
L["INPUT_FONT_SIZE"] = "輸入字型大小"
L["CHANNEL_FONT_SIZE"] = "頻道字型大小"
L["FONTS"]           = "字型"
L["INPUT_FONT"]      = "輸入字型"
L["CHANNEL_FONT"]    = "頻道字型"
L["BACKGROUND"]      = "背景"
L["BG_TEXTURE"]      = "背景材質"
L["BG_TRANSPARENCY"] = "背景不透明度"
L["BG_BRIGHTNESS"]   = "背景亮度"
L["BG_SCALE"]        = "背景縮放"
L["BORDER"]          = "邊框"
L["BORDER_TEXTURE"]  = "邊框材質"
L["BORDER_TRANSPARENCY"] = "邊框不透明度"
L["BORDER_BRIGHTNESS"]   = "邊框亮度"
L["BORDER_THICKNESS"]    = "邊框粗細"
L["TEXT_OPTIONS"]    = "文字選項"
L["MATCH_TEXT_COLOR"] = "文字顏色符合頻道顏色"
L["SHOW_OUTLINE"]    = "顯示文字外框"
L["SHOW_SHADOW"]     = "顯示文字陰影"
L["DROP_SHADOW"]     = "輸入框投影"
L["TEXT_ALIGN"]      = "文字對齊"
L["CHAT_HISTORY"]    = "聊天歷史"
L["HISTORY_LENGTH"]  = "歷史記錄長度"
L["WIPE_HISTORY"]    = "清除全部歷史"
L["RECENT_WHISPERS"] = "最近密語"
L["SNIPPETS"]        = "片段"
L["SNIPPET_TRIGGER"] = "觸發詞"
L["SNIPPET_TEXT"]    = "內容"
L["SNIPPET_SAVE"]    = "儲存"
L["SNIPPET_DELETE"]  = "刪除"
L["SNIPPET_NEW"]     = "新增片段"
L["SNIPPET_SHARE"]   = "分享片段"
L["SNIPPET_EXPORT"]  = "全部匯出"
L["SNIPPET_IMPORT"]  = "匯入"
L["SNIPPET_RESET"]   = "重置片段"
L["AUTOCOMPLETE"]    = "自動完成"
L["AUTOCOMPLETE_POS"] = "自動完成位置"
L["CHANNEL_POS"]     = "頻道名稱位置"
L["AUTO_HIDE_CHANNEL"] = "自動隱藏頻道名稱（滑鼠移入時顯示）"
L["LAYOUT_OPTIONS"]  = "版面配置選項"
L["ANCHOR_EDITOR"]   = "錨點編輯器"
L["OPEN_ANCHOR_EDITOR"] = "開啟錨點編輯器"
L["ABOUT"]           = "關於"
L["ABOUT_DESC"]      = "一個大型可自訂的聊天輸入框，具有頻道顯示、錨點編輯器和完整的外觀控制。"
L["PROFILES"]        = "設定檔"
L["SAVE_STYLE"]      = "儲存樣式"
L["DELETE_STYLE"]    = "刪除樣式"
L["DYNAMIC_HEIGHT"]  = "動態高度"
L["DYNAMIC_WIDTH"]   = "動態寬度"
L["CHAR_COUNTER_POS"] = "字元計數器位置"
L["LONG_MESSAGES"]   = "長訊息"
L["LONG_MSG_OFF"]    = "關閉"
L["LONG_MSG_SILENT"] = "靜音"
L["LONG_MSG_NOTICE"] = "通知"
L["LONG_MSG_CONFIRM"] = "確認"
L["LONG_MSG_DESC_OFF"]     = "訊息在 255 個字元處截斷（預設魔獸行為）。"
L["LONG_MSG_DESC_SILENT"]  = "自動分割為多則訊息。"
L["LONG_MSG_DESC_NOTICE"]  = "分割並顯示已發送幾個部分。"
L["LONG_MSG_DESC_CONFIRM"] = "分割前請求確認。"
L["IMPORT_STYLE_BTN"]  = "匯入樣式字串"
L["FINISH_CONFIG_BTN"] = "完成 + 設定"
L["BG_COLOR"]          = "背景顏色"
L["MSG_SPLIT_NOTICE"]  = "訊息已分割為 %d 個部分（%d 個字元）。"

-- ── v5.3.3 Keybinding strings ─────────────────────────────────────────────────
L["HELP_KEYBINDINGS_TITLE"] = "-- 快速鍵 --"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+Enter 切換到暴雪預設聊天（在任何地方都有效）。\n適用於不能直接插入 BCB 的 Shift 點擊（坐騎、\n成就、玩具箱、天賦、法術書）。在暴雪輸入框中輸入，\n然後按 Enter 發送。BCB 在您下次按 Enter 時恢復。\n\n您可以在進階標籤頁或\n「Esc > 按鍵綁定 > 插件 > BigChatBox」中重新綁定或解除綁定。"

-- ── v5.5.0 Welcome Panel ─────────────────────────────────────────────────────
L["WELCOME_TITLE"]          = "歡迎使用 BigChatBox！"
L["WELCOME_SUBTITLE"]       = "初次設定"
L["WELCOME_TEXT"]           = "BigChatBox 將魔獸世界的小聊天輸入框替換為大型、完全可自訂的輸入框。\n\n您可以更改大小、背景、邊框、字型和顏色----或選擇現成的樣式。聊天歷史、文字片段和智慧自動完成等功能均已內建，可隨時開關。\n\n此快速設定將在不到一分鐘內幫您完成設定。"
L["WELCOME_SETUP_BTN"]      = "設定 BigChatBox"
L["WELCOME_LANG_LBL"]       = "顯示語言："
L["WELCOME_STYLE_TITLE"]    = "選擇您的樣式！"
L["WELCOME_LAYOUT_TITLE"]   = "選擇版面配置"
L["WELCOME_FEATURES_TITLE"] = "選擇您的功能！"
L["WELCOME_ADVANCED_TITLE"] = "進階功能"
L["WELCOME_FINAL_TITLE"]    = "即將完成！"
L["WELCOME_FINISH_BTN"]     = "完成！"
L["WELCOME_QUIT_CONFIRM"]   = "確定要退出設定嗎？將使用預設設定。"
L["WELCOME_KEYBIND_INFO"]   = "大多數 Shift 點擊連結可直接插入 BigChatBox。對於少數不支援的（如坐騎、玩具和天賦），此快速鍵可切換到暴雪的聊天輸入框。"
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBox 在戰鬥、大秘境、競技場和定級戰場中自動暫停，以保護您的聊天。"
L["WELCOME_THANKS"]         = "感謝使用 BigChatBox！"
L["WELCOME_SECURE_TITLE"]   = "安全內容"
L["WELCOME_KEYBIND_TITLE"]  = "暴雪聊天快速鍵"
L["WELCOME_CONFIG_HINT"]    = "隨時輸入 /bcb 開啟完整設定視窗。"
L["FEATURE_HISTORY_DESC"]   = "儲存您發送的訊息及時間戳記。"
L["FEATURE_SNIPPETS_DESC"]  = "按 Enter 時展開的文字捷徑。"
L["FEATURE_AC_SNIPPETS_DESC"]  = "自動完成以 ! 開頭的片段觸發詞。"
L["FEATURE_AC_COMMANDS_DESC"]  = "自動完成斜線指令，如 /dance、/guild。"
L["FEATURE_AC_WHISPERS_DESC"]  = "密語時自動完成玩家名稱。"
L["FEATURE_MOUSEWHEEL_DESC"]   = "以滑鼠滾輪捲動瀏覽之前的訊息。"
L["FEATURE_GLOBAL_PROFILE_DESC"] = "在此帳號下的所有角色間共享設定。"
L["FEATURE_KEEP_OPEN_DESC"]    = "點擊其他地方時輸入框保持可見。"
L["RESTART_SETUP_CONFIRM"]  = "這將重置所有設定並重新啟動歡迎精靈。確定嗎？"

-- ── v5.6.0 Patch notes UI ────────────────────────────────────────────────────
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox -- 新功能"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox -- 更新說明"
L["PATCHNOTES_DONT_SHOW"]      = "不再顯示"
L["PATCHNOTES_GOT_IT"]         = "知道了！"
L["PATCHNOTES_PREVIOUS"]       = "-- 歷史更新 --"

-- ── Keys added during source wiring (v5.6.0 localization pass) ───────────────

-- Features tab
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffff關閉|r -- 訊息在 255 個字元處截斷（預設魔獸行為）。\n|cffffffff靜音|r -- 自動分割為多則訊息。\n|cffffffff通知|r -- 分割並顯示已發送幾個部分。\n|cffffffff確認|r -- 分割前請求確認。"

-- Snippets tab
L["SNIPPET_NOTHING_TO_EXPORT"] = "沒有可匯出的片段。"

-- History tab
L["HISTORY_LENGTH_LABEL"] = "歷史記錄長度"

-- ConfigMain print messages
L["PRINT_RESET_ALL"]         = "所有設定已重置為預設值。正在重新載入..."
L["PRINT_RESET_APPEARANCE"]  = "外觀已重置。正在重新載入..."
L["PRINT_RESET_PLACEMENT"]   = "位置已重置。正在重新載入..."
L["PRINT_RESET_HISTORY"]     = "歷史記錄已重置。正在重新載入..."
L["PRINT_SNIPPETS_REMOVED"]  = "所有片段已刪除。"
L["PRINT_STYLES_REMOVED"]    = "所有自訂樣式已刪除。"
L["PRINT_NO_STYLE_STRING"]   = "未提供樣式字串。"
L["PRINT_STYLE_DECODE_FAIL"] = "解碼樣式字串失敗，可能已損毀。"
L["PRINT_STYLE_INVALID"]     = "無效的樣式字串。需要 !BCB1: 或 BCB: 前綴。"
L["PRINT_STYLE_IMPORTED"]    = "樣式已匯入！"
L["PRINT_STYLE_SAVED"]       = "樣式「%s」已儲存。"
L["PRINT_STYLE_DELETED"]     = "樣式「%s」已刪除。"
L["PRINT_SNIPPET_INVALID"]   = "無效的片段字串。"
L["PRINT_SNIPPET_REMOVED"]   = "片段「%s」已刪除。"
L["PRINT_SNIPPETS_IMPORTED"] = "已匯入 %d 個片段。"
L["PRINT_SNIPPETS_SKIPPED"]  = " %d 個已略過（已存在）。"
L["PRINT_CANT_DELETE_DEFAULT"] = "無法刪除預設樣式。"
L["PRINT_SETUP_SKIPPED"]     = "設定已略過。隨時輸入 |cff55ccff/bcb|r 進行設定。"
L["BTN_RESET_STYLES_CONFIRM"] = "重置樣式"

-- SlashCommands popups
L["POPUP_WIPE_WHISPERS"]     = "清除密語歷史記錄？此操作無法復原。"

-- WelcomePanel
L["WELCOME_CHOOSE_STYLE"]      = "選擇樣式："
L["WELCOME_STYLE_NOTE"]        = "標有插件名稱的樣式需要安裝相應插件。\n您可以在設計標籤頁中完全自訂所有內容。"
L["WELCOME_LAYOUT_DESC"]       = "選擇頻道名稱和自動完成相對於輸入框的顯示位置。"
L["WELCOME_CHANNEL_POS_LBL"]   = "頻道名稱位置："
L["WELCOME_AC_POS_LBL"]        = "自動完成位置："
L["WELCOME_AUTOHIDE_HELP"]     = "頻道名稱淡出，直到您將滑鼠移入輸入框。"
L["WELCOME_CHARCOUNTER_LBL"]   = "字元計數器位置："
L["WELCOME_FEATURES_DESC"]     = "切換您想要的功能。所有功能預設啟用。\n您可以隨時在功能標籤頁中更改這些設定。"
L["WELCOME_LONGMSG_LBL"]       = "長訊息（超過 255 個字元）："
L["LONGMSG_DESC_OFF"]          = "在 255 個字元處截斷"
L["LONGMSG_DESC_SILENT"]       = "自動分割"
L["LONGMSG_DESC_NOTICE"]       = "分割並顯示通知"
L["LONGMSG_DESC_CONFIRM"]      = "分割前詢問"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "了解更多關於戰鬥鎖定的資訊"
L["WELCOME_WHY_KEYBIND"]       = "為什麼需要這個？"
L["WELCOME_CURRENT_KEYBIND"]   = "目前快速鍵："
L["WELCOME_KEYBIND_CLICK_HINT"] = "點擊設定 · 右鍵點擊解除綁定"
L["WELCOME_OPEN_HELP"]         = "開啟說明與技巧視窗"
L["WELCOME_HELP_DESC"]         = "所有指令、快速鍵和功能詳情均可在說明視窗中找到。"
L["WELCOME_RELOAD_NOTE"]       = "兩個按鈕都將重新載入您的介面。"
L["WELCOME_COMBAT_PAUSE"]      = "設定已暫停----進入戰鬥。"
L["WELCOME_SHIFTCLICK_TITLE"]  = "Shift 點擊連結插入"
L["WELCOME_FEAT_HISTORY"]      = "聊天歷史"
L["WELCOME_FEAT_SNIPPETS"]     = "片段系統"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "自動完成：!片段"
L["WELCOME_FEAT_AC_COMMANDS"]  = "自動完成：/指令"
L["WELCOME_FEAT_AC_WHISPER"]   = "自動完成：密語名稱"
L["WELCOME_FEAT_AC_BNET"]      = "自動完成：Battle.net 好友"
L["WELCOME_FEAT_KEEP_OPEN"]    = "保持輸入框開啟"

-- WelcomePanel navigation
L["BTN_PREVIOUS"]  = "上一步"
L["BTN_NEXT"]      = "下一步"

-- ── Language selector (Advanced tab) ─────────────────────────────────────────
L["SECTION_LANGUAGE"]        = "語言"
L["LANGUAGE_DESC"]           = "覆蓋顯示語言。需要重新載入介面。"
L["LANGUAGE_CLIENT"]         = "用戶端語言"
L["LANGUAGE_RELOAD_MSG"]     = "語言已更改。正在重新載入介面..."
L["POPUP_CHANGE_LANGUAGE"]   = "更改語言並重新載入介面？"
L["BTN_RELOAD_CONFIRM"]      = "重新載入"
L["LANGUAGE_COMING_SOON"]    = "|cff888888（即將推出）|r"

-- ── Help popup body strings ───────────────────────────────────────────────────
L["HELP_WINDOW_TITLE"] = "BigChatBox 說明"

L["HELP_BODY_MAIN"] = [[|cffffd100-- 指令 --|r
|cffffd100/bcb|r 或 |cffffd100/bcb config|r -- 開啟設定視窗。
|cffffd100/bcb edit|r -- 開啟錨點編輯器以重新定位。
|cffffd100/bcb reset|r -- 將位置重置為預設值。

|cffffd100-- 聊天基礎 --|r
|cffffd100左鍵點擊|r頻道名稱以切換頻道（一般、隊伍、公會等）。
|cffffd100右鍵點擊|r頻道名稱以存取設定、歷史記錄和清除選項。
|cffffd100Enter|r 發送訊息。|cffffd100Escape|r 清除並關閉。
在輸入框上|cffffd100滾動滑鼠滾輪|r可瀏覽聊天歷史。

|cffffd100-- 自動完成 --|r
輸入 |cffffd100/|r 查看符合的斜線指令（Tab 循環，Enter 確認）。
輸入 |cffffd100!|r 自動完成片段觸發詞（如 !guild、!inv）。
密語名稱可從好友、公會、隊伍和最近密語中自動完成。
|cffffd100Tab|r / |cffffd100Shift+Tab|r 循環瀏覽建議。

|cffffd100-- 片段 --|r
定義按 Enter 時展開的文字捷徑。
範例：!guild 可展開為「LFM 大秘境+，密語邀請！」
每個片段可限制到特定頻道。
在|cff5599ff片段|r標籤頁中管理、建立、匯入和匯出片段。

|cffffd100-- 連結插入 --|r
|cffffd100Shift+點擊|r物品、法術、成就等以插入連結。
適用於背包、法術書、成就面板、專業技能和聊天輸出。
|cffffd100滑入|r輸入框中的連結以預覽提示。
對於不支援直接插入的面板，請參閱|cff5599ffShift 點擊說明|r按鈕。

|cffffd100-- 自訂 --|r
|cff5599ff設計|r標籤頁可自訂背景、邊框、字型和顏色。
|cff5599ff位置|r標籤頁有用於精確定位的錨點編輯器。
將您的外觀儲存為命名樣式。匯出和匯入樣式字串以分享。
如果安裝了 LibSharedMedia，則支援 LSM 材質和字型。

|cffffd100-- 工具與開關 --|r
|cff5599ff功能|r標籤頁可啟用或停用各項功能：
自動完成、片段、連結滑入提示、聊天歷史等。
|cffffd100保持開啟|r模式可在輸入框失去焦點時保持可見。

|cffffd100-- 設定檔與樣式 --|r
設定預設依角色儲存。
在進階設定中啟用|cffffd100對所有角色使用|r以全域共享設定。
樣式儲存您的視覺外觀（背景、邊框、字型、顏色）。
使用匯出/匯入與好友或在角色間分享樣式。

|cffffd100-- 位置與大小 --|r
錨點編輯器可讓您拖曳輸入框到新位置。
方向鍵每次微調 1 像素以實現精度。
Shift+拖曳可對稱調整輸入框大小。
|cffffd100Shift+Alt+點擊|r輸入框可將位置重置到螢幕中央。
您也可以在錨點編輯器的資訊面板中設定精確的位置和大小值。

|cffffd100-- 長訊息 --|r
超過 255 個字元的訊息可自動分割為多則發送。
在|cff5599ff功能|r標籤頁中設定行為：關閉、靜音、通知或確認。
字元計數器顯示距離上限還有多少。

|cffffd100-- 動態大小 --|r
在設計標籤頁中啟用|cffffd100動態高度|r和|cffffd100動態寬度|r。
高度隨字型大小調整，寬度隨訊息長度增長。]]

L["HELP_BODY_SECURE"] = "|cffffd100-- 為什麼 BigChatBox 在戰鬥/大秘境等情境中暫停 --|r\n\n" ..
    "隨著午夜傳說資料片（12.0）的推出，暴雪對插件在戰鬥中與遊戲的互動方式進行了重大更改。這項舉措被稱為|cff5599ff插件解除武裝|r，限制了插件處理戰鬥資訊的方式。\n\n" ..
    "|cffffd100發生了什麼變化？|r\n" ..
    "與戰鬥相關的資料現在被視為|cffff9900「秘密值」|r。插件可以顯示這些資訊，但不能在程式碼中讀取或處理。\n\n" ..
    "許多介面框架現在在戰鬥中受到|cffff9900保護|r。在副本內容（大秘境、競技場、定級戰場）中，限制更為嚴格。任何修改或掛鉤這些受保護框架的插件都有傳播|cffff6666污染|r的風險，這可能完全破壞遊戲功能----不僅是插件，還包括選取目標、施法和使用技能等核心遊戲功能。\n\n" ..
    "|cffffd100這對 BigChatBox 有何影響？|r\n" ..
    "魔獸世界的預設聊天輸入框（ChatFrame1EditBox）是一個受保護的框架，因為它處理 /target、/cast 和 /focus 等安全斜線指令。BigChatBox 掛鉤此框架以攔截聊天輸入。在戰鬥和副本競技內容中，這些掛鉤可能導致污染，從而阻斷您的整個聊天系統。\n\n" ..
    "為了保護您，BigChatBox 在戰鬥期間以及大秘境、競技場和定級戰場期間|cff00ff00自動暫停|r。暴雪的預設聊天輸入框會無縫接管。當戰鬥結束或內容完成後，BigChatBox 會自動恢復。\n\n" ..
    "|cffffd100為什麼不直接修復它？|r\n" ..
    "這不是一個|cffff0000錯誤！|r這是魔獸世界安全模型中的根本性限制。每個在戰鬥中修改受保護框架的插件都面臨同樣的限制。暴雪設計這些限制是為了防止插件自動化戰鬥決策，而聊天輸入框恰好在受保護範圍內。\n\n" ..
    "|cffffd100總結|r\n" ..
    "BigChatBox 在戰鬥期間以及計時競技副本（大秘境、競技場、定級戰場）期間暫停。在這些活動中，您仍然可以使用暴雪內建的聊天輸入框正常聊天。當戰鬥結束或活動完成後，BigChatBox 會自動恢復。"

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100-- 為什麼不是所有 Shift 點擊都有效？ --|r\n\n" ..
    "大多數 Shift 點擊連結插入在 BigChatBox 中可以直接使用。但是，少數遊戲面板使用內部暴雪函數，這些函數只能將連結插入暴雪自己的聊天輸入框，繞過任何插件輸入框。\n\n" ..
    "|cff00ff00在 BigChatBox 中有效：|r\n" ..
    "  · 個人背包中的物品\n" ..
    "  · 寵物日誌中的寵物\n" ..
    "  · 傳家寶面板中的傳家寶\n" ..
    "  · 商人面板中的物品\n" ..
    "  · 郵箱中的物品\n" ..
    "  · 專業技能面板中的製作配方和材料\n" ..
    "  · 聊天視窗中的連結\n\n" ..
    "|cffff9900需要暴雪聊天：|r\n" ..
    "  · 成就面板中的成就\n" ..
    "  · 銀行面板中的物品\n" ..
    "  · 公會銀行面板中的物品\n" ..
    "  · 坐騎日誌中的坐騎\n" ..
    "  · 天賦面板中的天賦\n" ..
    "  · 外觀衣櫃中的外觀\n" ..
    "  · 某些資料片特定面板\n\n" ..
    "|cffffd100為什麼？|r\n" ..
    "這些面板使用魔獸世界的內部|cff5599ffChatEdit_InsertLink|r函數，該函數專門檢查暴雪的輸入框。BigChatBox 攔截了大多數此類呼叫，但由於暴雪的實作方式，某些面板完全繞過了標準掛鉤。這是魔獸世界 API 的限制，不是錯誤。\n\n" ..
    "|cffffd100解決方案|r\n" ..
    "|cff5599ff暴雪聊天快速鍵|r（預設：Ctrl+Enter）可立即切換到暴雪的原生聊天輸入框。在那裡輸入或 Shift 點擊您需要的內容，按 Enter 發送，BigChatBox 將在您下一則訊息時自動恢復。\n\n" ..
    "您可以在以下位置重新綁定或解除綁定此快速鍵：\n" ..
    "  · |cffffd100/bcb|r > 進階標籤頁\n" ..
    "  · Esc > 按鍵綁定 > 插件 > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "切換到 %s 並重新啟動設定？\nBigChatBox 將重新載入以套用新語言。"

-- ── v5.6.1 Emoji & Emoticon picker ───────────────────────────────────────────
L["SECTION_EMOJI"]          = "顏文字選擇器"
L["CB_SHOW_EMOJI_PICKER"]   = "顯示顏文字選擇器按鈕"
L["EMOJI_PICKER_TITLE"]     = "顏文字選擇器"
L["EMOJI_PICKER_TOOLTIP"]   = "點擊開啟顏文字選擇器"
L["EMOJI_TAB_LAST"]         = "最近使用"
L["EMOJI_TAB_ASCII"]        = "顏文字"
L["EMOJI_LAST_EMPTY"]       = "尚無最近選擇記錄。"

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "搜尋歷史記錄..."

L["BTN_SAVE_SNIPPET"]           = "儲存"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "使用預設樣式"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "勾選後，多行輸入框將使用預設樣式，與目前活動樣式無關。取消勾選以使用您目前的BCB外觀。"

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "多行輸入"
L["CB_ENABLE_MULTILINE"]        = "啟用多行輸入"
L["CB_ENABLE_MULTILINE_HELP"]   = "開啟大型多行輸入框以撰寫多行訊息。每行將分別傳送。"
L["KEYBIND_OPEN_MULTILINE"]     = "開啟多行輸入："
L["MULTILINE_KEYBIND_HELP"]     = "預設：Shift+Enter。開啟大型輸入框，Enter新增一行，Shift+Enter傳送所有行。"
L["BTN_OPEN_KEYBINDINGS"]       = "開啟快捷鍵設定"
L["MULTILINE_SEND_BTN"]         = "傳送"
L["MULTILINE_CHANNEL_LABEL"]    = "頻道：%s"
L["MULTILINE_BLOCKED_SECURE"]   = "在M+/競技場/評分戰場期間無法使用多行輸入。"
L["MULTILINE_HINT"]             = "Enter = 換行   |   Shift+Enter = 全部傳送"
