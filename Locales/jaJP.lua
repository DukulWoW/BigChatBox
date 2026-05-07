-- BigChatBox Localization - Japanese (jaJP)
-- Version: 5.6.1
-- Full translation for 5.6.1 locale system. Overrides all keys that differ from enUS.
-- Missing keys fall back to enUS automatically.

local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "jaJP" and (BigChatBox and BigChatBox._forcedLocale) ~= "jaJP" then return end

-- !! Addon identity !!---------------------------------------------------------
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "バージョン"
L["LOADED_MSG"]   = "BigChatBox v%s を読み込みました！/bcb でオプションを開きます。"

-- !! Config window tabs !!------------------------------------------------------
L["TAB_GENERAL"]   = "一般"
L["TAB_DESIGNER"]  = "デザイナー"
L["TAB_PLACEMENT"] = "配置"
L["TAB_FEATURES"]  = "機能"
L["TAB_SNIPPETS"]  = "スニペット"
L["TAB_HISTORY"]   = "履歴"
L["TAB_ADVANCED"]  = "詳細"
L["TAB_RESET"]     = "リセット"

-- !! Reset tab !!---------------------------------------------------------------
L["RESET_TAB_HEADER"]       = "リセットと復元"
L["RESET_TAB_DESC"]         = "これらの操作は永続的で、元に戻せません。"
L["RESET_ALL_HELP"]         = "すべてをリセットします：位置、外観、履歴、スニペット。"
L["RESET_APPEARANCE_HELP"]  = "背景、枠線、フォント、色のみをリセットします。"
L["RESET_PLACEMENT_HELP"]   = "位置とサイズをデフォルト値にリセットします。"
L["RESET_HISTORY_HELP"]     = "保存されたチャットとささやき履歴をすべて消去します。"
L["RESET_SNIPPETS_HELP"]    = "スニペットをすべて削除します。"
L["RESET_STYLES_HELP"]      = "保存されたカスタムスタイルをすべて削除します。"
L["RESTART_SETUP_HELP"]     = "すべての設定をリセットし、初回セットアップウィザードを再実行します。"

-- !! Shared UI !!---------------------------------------------------------------
L["PREVIEW"]        = "プレビュー"
L["TYPE_SOMETHING"] = "ここに入力..."
L["CLOSE"]          = "閉じる"
L["ACTIONS"]        = "操作"
L["RESET"]          = "リセット"
L["OK"]             = "OK"
L["CANCEL"]         = "キャンセル"
L["YES"]            = "はい"
L["NO"]             = "いいえ"
L["SAVE"]           = "保存"
L["DELETE"]         = "削除"
L["EDIT"]           = "編集"
L["IMPORT"]         = "インポート"
L["EXPORT"]         = "エクスポート"
L["DUPLICATE"]      = "複製"
L["SHARE"]          = "共有"
L["ENABLED"]        = "有効"
L["DISABLED"]       = "無効"

-- !! General tab !!-------------------------------------------------------------
L["BTN_VIEW_PATCH_NOTES"]     = "パッチノートを見る"
L["BTN_HELP_AND_TIPS"]        = "ヘルプとヒント"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "戦闘ロック情報"
L["BTN_SHIFT_CLICK_INFO"]     = "Shiftクリック情報"

-- General tab feature grid
L["CELL_SNIPPETS_HDR"]       = "|cff5599ffスニペット|r"
L["CELL_SNIPPETS_DESC"]      = "送信時に展開されるテキストショートカット。\nスニペットタブで管理します。"
L["CELL_ANCHOR_HDR"]         = "|cff5599ffアンカーエディター|r"
L["CELL_ANCHOR_DESC"]        = "クリックしてドラッグで位置変更。\n方向キーでピクセル精度の調整。"
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ffオートコンプリート|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "コマンド、ささやき相手、スニペット\nトリガー(!guild)のスマートTab補完。"
L["CELL_HISTORY_HDR"]        = "|cff5599ffチャット履歴|r"
L["CELL_HISTORY_DESC"]       = "タイムスタンプ付き完全履歴。\nマウスホイールでスクロール。"
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ffカスタマイズ|r"
L["CELL_CUSTOMIZATION_DESC"] = "デザイナータブで背景、枠線、\nフォント、色を設定。スタイルの保存と共有。"
L["CELL_SECURE_HDR"]         = "|cffff9900セキュアコンテンツ|r"
L["CELL_SECURE_DESC"]        = "M+、アリーナ、レーティングBGで\nチャット保護のため自動一時停止。"
L["CELL_SHARING_HDR"]        = "|cff5599ff共有|r"
L["CELL_SHARING_DESC"]       = "スタイルとスニペットを短い文字列で\nエクスポートして友達と共有。"
L["CELL_LONGMSG_HDR"]        = "|cff5599ff長いメッセージ|r"
L["CELL_LONGMSG_DESC"]       = "255文字を超えるメッセージを\n自動分割。自動、通知、または確認。"

-- !! Styles (Designer tab) !!---------------------------------------------------
L["STYLES"]              = "スタイル"
L["ACTIVE_STYLE"]        = "現在のスタイル"
L["BTN_SAVE_STYLE"]      = "スタイルを保存"
L["BTN_DELETE_STYLE"]    = "スタイルを削除"
L["BTN_EXPORT_STYLE"]    = "スタイルをエクスポート"
L["BTN_IMPORT_STYLE"]    = "スタイルをインポート"

-- !! Designer tab sections !!---------------------------------------------------
L["SECTION_SIZE"]         = "サイズ"
L["SECTION_BACKGROUND"]   = "背景"
L["SECTION_BORDER"]       = "枠線"
L["SECTION_FONTS"]        = "フォント"
L["SECTION_TEXT_OPTIONS"] = "テキストオプション"

-- Designer tab slider / dropdown labels
L["LABEL_WIDTH"]              = "幅"
L["LABEL_HEIGHT"]             = "高さ"
L["LABEL_SCALE"]              = "スケール"
L["LABEL_BG_TEXTURE"]         = "背景テクスチャ"
L["LABEL_BG_OPACITY"]         = "背景の不透明度"
L["LABEL_BG_BRIGHTNESS"]      = "背景の明るさ"
L["LABEL_BG_SCALE"]           = "背景スケール"
L["LABEL_TINT_INTENSITY"]     = "色調強度"
L["LABEL_BORDER_TEXTURE"]     = "枠線テクスチャ"
L["LABEL_BORDER_OPACITY"]     = "枠線の不透明度"
L["LABEL_BORDER_BRIGHTNESS"]  = "枠線の明るさ"
L["LABEL_BORDER_THICKNESS"]   = "枠線の太さ"
L["LABEL_CHANNEL_FONT"]       = "チャンネルフォント"
L["LABEL_INPUT_FONT"]         = "入力フォント"
L["LABEL_CHANNEL_FONT_SIZE"]  = "チャンネルフォントサイズ"
L["LABEL_INPUT_FONT_SIZE"]    = "入力フォントサイズ"
L["LABEL_TEXT_ALIGNMENT"]     = "テキスト揃え"
L["LABEL_FONT_OUTLINE"]       = "フォントアウトライン"

-- Designer tab checkboxes
L["CB_DYNAMIC_HEIGHT"]   = "動的な高さ"
L["CB_DYNAMIC_WIDTH"]    = "動的な幅"
L["CB_TINT_BG"]          = "チャンネル色で背景を色付け"
L["CB_MATCH_TEXT_COLOR"] = "テキスト色をチャンネル色に合わせる"

-- !! Placement tab !!-----------------------------------------------------------
L["SECTION_LAYOUT_OPTIONS"]   = "レイアウトオプション"
L["SECTION_POSITION"]         = "位置"
L["LABEL_CHANNEL_NAME_POS"]   = "チャンネル名の位置"
L["CB_SHOW_CHANNEL"]           = "チャンネル名を表示"
L["LABEL_AUTOCOMPLETE_POS"]   = "オートコンプリートの位置"
L["LABEL_CHAR_COUNTER_POS"]   = "文字数カウンターの位置"
L["CB_AUTO_HIDE_CHANNEL"]     = "チャンネル名を自動非表示（ホバーで表示）"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "アンカーエディターを開く"

-- !! Features tab !!------------------------------------------------------------
L["SECTION_FEATURE_TOGGLES"]  = "機能のオン/オフ"
L["FEATURE_TOGGLES_DESC"]     = "BigChatBoxの機能を有効または無効にします。"
L["SECTION_SNIPPET_SYSTEM"]   = "スニペットシステム"
L["SECTION_AUTOCOMPLETE"]     = "オートコンプリート"
L["SECTION_HISTORY"]          = "履歴"
L["SECTION_LINK_HOVER"]       = "リンクホバー"
L["SECTION_LONG_MESSAGES"]    = "長いメッセージ"
L["CB_ENABLE_SNIPPETS"]       = "スニペットシステムを有効にする"
L["CB_AC_COMMANDS"]           = "スラッシュコマンドの補完（/dance、/guild など）"
L["CB_AC_WHISPER"]            = "ささやき相手の補完（/w <名前>）"
L["CB_AC_SNIPPETS"]           = "スニペットトリガーの補完（!guild など）"
L["CB_AC_BNET"]               = "ささやき補完にBattle.netフレンドを表示"
L["CB_ENABLE_HISTORY"]        = "チャット履歴を有効にする"
L["CB_MOUSEWHEEL_HISTORY"]    = "マウスホイールで履歴をスクロール"
L["CB_LINK_HOVER"]            = "リンクにホバーするとツールチップを表示"
L["LABEL_MSG_EXCEEDS_255"]    = "メッセージが255文字を超えるとき"

-- !! Snippets tab !!------------------------------------------------------------
L["SNIPPETS_DISABLED_MSG"]    = "スニペットシステムは無効です。\n機能タブで有効にしてください。"
L["SNIPPETS_HEADER"]          = "スニペット"
L["SNIPPETS_DESC"]            = "チャットにスニペットトリガー（例：!guild）を入力してEnterで送信すると展開されます。"
L["SNIPPET_EDIT_HEADER"]      = "編集"
L["SNIPPET_ACTIVE"]           = "スニペット有効"
L["SNIPPET_TRIGGER_LBL"]      = "トリガー："
L["SNIPPET_TEXT_LBL"]         = "テキスト："
L["SNIPPET_CHANNEL_LBL"]      = "チャンネル："
L["SNIPPET_GLOBAL"]           = "全キャラクターで使用可能"
L["SNIPPET_EMPTY_LIST"]       = "スニペットがありません。\n「新しいスニペット」か\n「インポート」で始めましょう。"
L["BTN_NEW_SNIPPET"]          = "新しいスニペット"
L["BTN_EXPORT_ALL"]           = "すべてエクスポート"
L["BTN_SHARE_SNIPPET"]        = "共有"
L["BTN_DUPLICATE_SNIPPET"]    = "複製"
L["BTN_DELETE_SNIPPET"]       = "削除"
L["BTN_IMPORT_SNIPPET"]       = "インポート"

-- !! History tab !!-------------------------------------------------------------
L["HISTORY_HEADER"]           = "チャット履歴"
L["HISTORY_HELP"]             = "テキストをクリックして再利用。ホバーでタイムスタンプ表示。Xをクリックで削除。"
L["HISTORY_EMPTY"]            = "履歴がありません。"
L["HISTORY_MORE"]             = "... 他%d件"
L["WHISPERS_HEADER"]          = "最近のささやき"
L["WHISPERS_CLICK_HINT"]      = "（クリックでささやき）"
L["WHISPERS_EMPTY"]           = "ささやき履歴がありません。"
L["BTN_WIPE_HISTORY"]         = "履歴をすべて消去"
L["BTN_WIPE_COMMANDS"]        = "すべての/コマンドを消去"
L["BTN_REMOVE_ENTRIES"]       = "項目を削除"

-- !! Advanced tab !!------------------------------------------------------------
L["SECTION_PROFILES"]         = "プロフィール"
L["PROFILES_DESC"]            = "設定はキャラクターごとに保存されます。有効にするとすべてのキャラクターで共有されます。"
L["CB_GLOBAL_PROFILE"]        = "すべてのキャラクターで使用"
L["BEHAVIOR"]                 = "動作"
L["KEEP_OPEN"]                = "Escapeを押すまで入力ボックスを開いたままにする"
L["KEEP_OPEN_HELP"]           = "有効にすると、他の場所をクリックしても入力ボックスが表示されたままになります。Escapeで閉じます。"
L["SHOW_LOCKDOWN_WARNING"]    = "セキュアコンテンツ警告を表示"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "M+、アリーナ、レーティングBGでBCBが一時停止するときにチャットにメッセージを表示します。"
L["IGNORE_COMMANDS_HISTORY"]  = "履歴で/コマンドを無視"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "/target、/castなどのスラッシュコマンドはチャット履歴に保存されません。"
L["SHOW_MINIMAP_BUTTON"]      = "ミニマップボタンを表示"
L["SHOW_MINIMAP_BUTTON_HELP"] = "左クリックで設定を開き、右クリックでクイック設定を開きます。アドオンバーボタンは常に使用可能です。"
L["HIDE_LOGIN_MSG"]           = "ログインメッセージを非表示"
L["HIDE_LOGIN_MSG_HELP"]      = "ログイン時の「BigChatBox 読み込み完了」メッセージを非表示にします。"
L["KEYBIND_OPEN_BLIZZARD"]    = "Blizzardチャットを開く："
L["KEYBIND_NOT_BOUND"]        = "未割り当て"
L["KEYBIND_PRESS_KEY"]        = "キーを押してください..."
L["KEYBIND_CONFLICT"]         = "%sはすでに%sに割り当てられています。上書きしますか？"
L["KEYBIND_TOOLTIP_BOUND"]    = "Blizzardチャットを開く（%s）"
L["KEYBIND_TOOLTIP_UNBIND"]   = "右クリックで割り当て解除"
L["KEYBIND_TOOLTIP_SET"]      = "クリックしてキーを設定"
L["KEYBIND_HELP"]             = "乗り物、実績、おもちゃ、タレントのShiftクリックにBlizzardチャット入力を使います。デフォルト：Ctrl+Enter。"
L["RESET_ALL"]                = "全設定をリセット"
L["RESET_APPEARANCE"]         = "外観をリセット"
L["RESET_PLACEMENT"]          = "配置をリセット"
L["RESET_HISTORY_BTN"]        = "履歴をリセット"
L["RESET_SNIPPETS_BTN"]       = "スニペットをリセット"
L["RESET_STYLES_BTN"]         = "スタイルをリセット"
L["RESTART_SETUP"]            = "セットアップを再実行"

-- !! Reset / action confirmations !!-------------------------------------------
L["POPUP_RESET_ALL"]          = "BigChatBoxのすべての設定をデフォルトにリセットしますか？\n位置、サイズ、外観、フォントが含まれます。"
L["POPUP_RESET_APPEARANCE"]   = "外観をデフォルトにリセットしますか？\n位置や履歴には影響しません。"
L["POPUP_RESET_PLACEMENT"]    = "配置をデフォルトにリセットしますか？\nインターフェースが再読み込みされます。"
L["POPUP_RESET_HISTORY"]      = "すべてのチャット履歴とささやき履歴をリセットしますか？\n履歴の長さは100に設定されます。\nインターフェースが再読み込みされます。"
L["POPUP_RESET_SNIPPETS"]     = "すべてのスニペットを削除しますか？インターフェースが再読み込みされます。"
L["POPUP_RESET_STYLES"]       = "ユーザーが作成したスタイルをすべて削除しますか？\nデフォルトスタイルは残り、現在のスタイルになります。\nインターフェースが再読み込みされます。"
L["POPUP_WIPE_HISTORY"]       = "チャット履歴をすべて消去しますか？\nインターフェースも再読み込みされます。"
L["POPUP_WIPE_COMMANDS"]      = "チャット履歴からすべての/コマンドを削除しますか？\n通常のメッセージは残ります。\nインターフェースも再読み込みされます。"
L["POPUP_DELETE_STYLE"]       = "現在のスタイルを削除しますか？"
L["POPUP_OVERWRITE_STYLE"]    = "'%s'というスタイルはすでに存在します。上書きしますか？"
L["POPUP_SAVE_STYLE_TEXT"]    = "このスタイルの名前を入力してください："
L["POPUP_EXPORT_STYLE_TEXT"]  = "下のスタイル文字列をコピーしてください："
L["POPUP_IMPORT_STYLE_TEXT"]  = "スタイル文字列を貼り付けてください："
L["POPUP_NAME_IMPORT_STYLE"]  = "インポートしたスタイルを保存する名前："
L["POPUP_DELETE_SNIPPET"]     = "スニペット「%s」を削除しますか？"
L["POPUP_SHARE_SNIPPET_TEXT"] = "スニペット文字列をコピー（Ctrl+C）："
L["POPUP_IMPORT_SNIPPET_TEXT"] = "スニペット文字列を貼り付け（Ctrl+V）："
L["POPUP_RESTART_SETUP"]      = "すべての設定がリセットされ、ウェルカムウィザードが再起動します。\n続けますか？"
L["POPUP_QUIT_SETUP"]         = "セットアップを終了しますか？\nデフォルト設定が使用されます。"
L["BTN_RESET_ALL_CONFIRM"]    = "すべてリセット"
L["BTN_WIPE_CONFIRM"]         = "はい、消去"
L["BTN_DELETE_CONFIRM"]       = "削除"
L["BTN_OVERWRITE_CONFIRM"]    = "上書き"
L["BTN_SKIP"]                 = "スキップ"
L["BTN_RESTART_SETUP_CONFIRM"] = "ウィザードを再起動"
L["BTN_QUIT_SETUP_CONFIRM"]   = "セットアップを終了"
L["BTN_SAVE_CLOSE"]           = "閉じる"

-- !! Slash commands / print messages !!-----------------------------------------
L["SLASH_POSITION_RESET"]     = "位置をデフォルトにリセットしました"
L["SLASH_ANCHOR_UNAVAILABLE"] = "アンカーエディターは使用できません。"
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox：|r チャット履歴を消去しました。"
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox：|r 外観をデフォルトにリセットしました"
L["RESET_DONE"]               = "すべての設定がデフォルトにリセットされました。"
L["COMBAT_CLOSE"]             = "戦闘開始 -- 設定を閉じました。"
L["COMBAT_BLOCKED"]           = "戦闘中は設定を開けません。"

-- !! Position / size labels (legacy keys) !!------------------------------------
L["POSITION"]        = "位置"
L["X_POSITION"]      = "X座標"
L["Y_POSITION"]      = "Y座標"
L["SIZE"]            = "サイズ"
L["WIDTH"]           = "幅"
L["HEIGHT"]          = "高さ"
L["SCALE"]           = "スケール"
L["FONT_SIZES"]      = "フォントサイズ"
L["INPUT_FONT_SIZE"] = "入力フォントサイズ"
L["CHANNEL_FONT_SIZE"] = "チャンネルフォントサイズ"
L["FONTS"]           = "フォント"
L["INPUT_FONT"]      = "入力フォント"
L["CHANNEL_FONT"]    = "チャンネルフォント"
L["BACKGROUND"]      = "背景"
L["BG_TEXTURE"]      = "背景テクスチャ"
L["BG_TRANSPARENCY"] = "背景の不透明度"
L["BG_BRIGHTNESS"]   = "背景の明るさ"
L["BG_SCALE"]        = "背景スケール"
L["BORDER"]          = "枠線"
L["BORDER_TEXTURE"]  = "枠線テクスチャ"
L["BORDER_TRANSPARENCY"] = "枠線の不透明度"
L["BORDER_BRIGHTNESS"]   = "枠線の明るさ"
L["BORDER_THICKNESS"]    = "枠線の太さ"
L["TEXT_OPTIONS"]    = "テキストオプション"
L["MATCH_TEXT_COLOR"] = "テキスト色をチャンネル色に合わせる"
L["SHOW_OUTLINE"]    = "テキストアウトラインを表示"
L["SHOW_SHADOW"]     = "テキストシャドウを表示"
L["DROP_SHADOW"]     = "入力ボックスのドロップシャドウ"
L["TEXT_ALIGN"]      = "テキスト揃え"
L["CHAT_HISTORY"]    = "チャット履歴"
L["HISTORY_LENGTH"]  = "履歴の長さ"
L["WIPE_HISTORY"]    = "履歴をすべて消去"
L["RECENT_WHISPERS"] = "最近のささやき"
L["SNIPPETS"]        = "スニペット"
L["SNIPPET_TRIGGER"] = "トリガー"
L["SNIPPET_TEXT"]    = "テキスト"
L["SNIPPET_SAVE"]    = "保存"
L["SNIPPET_DELETE"]  = "削除"
L["SNIPPET_NEW"]     = "新しいスニペット"
L["SNIPPET_SHARE"]   = "スニペットを共有"
L["SNIPPET_EXPORT"]  = "すべてエクスポート"
L["SNIPPET_IMPORT"]  = "インポート"
L["SNIPPET_RESET"]   = "スニペットをリセット"
L["AUTOCOMPLETE"]    = "オートコンプリート"
L["AUTOCOMPLETE_POS"] = "オートコンプリートの位置"
L["CHANNEL_POS"]     = "チャンネル名の位置"
L["AUTO_HIDE_CHANNEL"] = "チャンネル名を自動非表示（ホバーで表示）"
L["LAYOUT_OPTIONS"]  = "レイアウトオプション"
L["ANCHOR_EDITOR"]   = "アンカーエディター"
L["OPEN_ANCHOR_EDITOR"] = "アンカーエディターを開く"
L["ABOUT"]           = "について"
L["ABOUT_DESC"]      = "チャンネル表示、アンカーエディター、完全な外観コントロールを持つ大型カスタマイズ可能なチャット入力ボックス。"
L["PROFILES"]        = "プロフィール"
L["SAVE_STYLE"]      = "スタイルを保存"
L["DELETE_STYLE"]    = "スタイルを削除"
L["DYNAMIC_HEIGHT"]  = "動的な高さ"
L["DYNAMIC_WIDTH"]   = "動的な幅"
L["CHAR_COUNTER_POS"] = "文字数カウンターの位置"
L["LONG_MESSAGES"]   = "長いメッセージ"
L["LONG_MSG_OFF"]    = "オフ"
L["LONG_MSG_SILENT"] = "自動"
L["LONG_MSG_NOTICE"] = "通知"
L["LONG_MSG_CONFIRM"] = "確認"
L["LONG_MSG_DESC_OFF"]     = "255文字で切り捨て（デフォルトのWoW動作）。"
L["LONG_MSG_DESC_SILENT"]  = "自動的に複数のメッセージに分割します。"
L["LONG_MSG_DESC_NOTICE"]  = "分割後、何件送信したか表示します。"
L["LONG_MSG_DESC_CONFIRM"] = "分割前に確認を求めます。"
L["IMPORT_STYLE_BTN"]  = "スタイル文字列をインポート"
L["FINISH_CONFIG_BTN"] = "完了 + 設定"
L["BG_COLOR"]          = "背景色"
L["MSG_SPLIT_NOTICE"]  = "メッセージを%d件（%d文字）に分割しました。"

-- !! v5.3.3 Keybinding strings !!-----------------------------------------------
L["HELP_KEYBINDINGS_TITLE"] = "-- キーバインド --"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+EnterはBlizzardデフォルトチャットに切り替えます（どこでも動作します）。\n乗り物、実績、おもちゃ箱、タレント、スペルブックなど、BCBに\n直接挿入できないShiftクリック用に便利です。Blizzard入力ボックスに\n入力してEnterで送信すると、次のEnterでBCBが再開されます。\n\n詳細タブまたは\n「Esc > キーバインド > アドオン > BigChatBox」で変更または解除できます。"

-- !! v5.5.0 Welcome Panel !!----------------------------------------------------
L["WELCOME_TITLE"]          = "BigChatBoxへようこそ！"
L["WELCOME_SUBTITLE"]       = "初回セットアップ"
L["WELCOME_TEXT"]           = "BigChatBoxはWoWの小さなチャット入力ボックスを、大型で完全にカスタマイズ可能な入力ボックスに置き換えます。\n\nサイズ、背景、枠線、フォント、色を変更したり、既成のスタイルを選択したりできます。チャット履歴、テキストスニペット、スマートオートコンプリートなどの機能が内蔵されており、いつでもオン/オフできます。\n\nこのクイックセットアップで1分以内に始められます。"
L["WELCOME_SETUP_BTN"]      = "設定開始"
L["WELCOME_LANG_LBL"]       = "表示言語："
L["WELCOME_STYLE_TITLE"]    = "スタイルを選んでください！"
L["WELCOME_LAYOUT_TITLE"]   = "レイアウトを選択"
L["WELCOME_FEATURES_TITLE"] = "機能を選んでください！"
L["WELCOME_ADVANCED_TITLE"] = "高度な機能"
L["WELCOME_FINAL_TITLE"]    = "もう少しで完了！"
L["WELCOME_FINISH_BTN"]     = "完了！"
L["WELCOME_QUIT_CONFIRM"]   = "セットアップを終了しますか？デフォルト設定が使用されます。"
L["WELCOME_KEYBIND_INFO"]   = "ほとんどのShiftクリックリンクはBigChatBoxに直接挿入できます。一部の例外（乗り物、おもちゃ、タレント）では、このキーでBlizzardのチャット入力に切り替えます。"
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBoxは戦闘中、M+、アリーナ、レーティングBGでチャットを保護するため自動的に一時停止します。"
L["WELCOME_THANKS"]         = "BigChatBoxをご利用いただきありがとうございます！"
L["WELCOME_SECURE_TITLE"]   = "セキュアコンテンツ"
L["WELCOME_KEYBIND_TITLE"]  = "Blizzardチャットキーバインド"
L["WELCOME_CONFIG_HINT"]    = "/bcb でいつでも完全な設定ウィンドウを開けます。"
L["FEATURE_HISTORY_DESC"]   = "タイムスタンプ付きで送信メッセージを保存します。"
L["FEATURE_SNIPPETS_DESC"]  = "Enterを押すと展開されるテキストショートカット。"
L["FEATURE_AC_SNIPPETS_DESC"]  = "!で始まるスニペットトリガーを補完します。"
L["FEATURE_AC_COMMANDS_DESC"]  = "/dance、/guildなどのスラッシュコマンドを補完します。"
L["FEATURE_AC_WHISPERS_DESC"]  = "ささやき時にプレイヤー名を補完します。"
L["FEATURE_MOUSEWHEEL_DESC"]   = "マウスホイールで以前のメッセージをスクロールします。"
L["FEATURE_GLOBAL_PROFILE_DESC"] = "このアカウントのすべてのキャラクターで設定を共有します。"
L["FEATURE_KEEP_OPEN_DESC"]    = "他の場所をクリックしても入力ボックスが表示されたままになります。"
L["RESTART_SETUP_CONFIRM"]  = "すべての設定がリセットされ、ウェルカムウィザードが再起動します。続けますか？"

-- !! v5.6.0 Patch notes UI !!---------------------------------------------------
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox -- 新機能"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox -- パッチノート"
L["PATCHNOTES_DONT_SHOW"]      = "次回から表示しない"
L["PATCHNOTES_GOT_IT"]         = "わかりました！"
L["PATCHNOTES_PREVIOUS"]       = "-- 過去のアップデート --"

-- !! Keys added during source wiring (v5.6.0 localization pass) !!--------------

-- Features tab
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffffオフ|r -- 255文字で切り捨て（デフォルトのWoW動作）。\n|cffffffff自動|r -- 自動的に複数のメッセージに分割します。\n|cffffffff通知|r -- 分割後、何件送信したか表示します。\n|cffffffff確認|r -- 分割前に確認を求めます。"

-- Snippets tab
L["SNIPPET_NOTHING_TO_EXPORT"] = "エクスポートするスニペットがありません。"

-- History tab
L["HISTORY_LENGTH_LABEL"] = "履歴の長さ"

-- ConfigMain print messages
L["PRINT_RESET_ALL"]         = "すべての設定がデフォルトにリセットされました。再読み込み中..."
L["PRINT_RESET_APPEARANCE"]  = "外観がリセットされました。再読み込み中..."
L["PRINT_RESET_PLACEMENT"]   = "配置がリセットされました。再読み込み中..."
L["PRINT_RESET_HISTORY"]     = "履歴がリセットされました。再読み込み中..."
L["PRINT_SNIPPETS_REMOVED"]  = "すべてのスニペットが削除されました。"
L["PRINT_STYLES_REMOVED"]    = "すべてのカスタムスタイルが削除されました。"
L["PRINT_NO_STYLE_STRING"]   = "スタイル文字列が指定されていません。"
L["PRINT_STYLE_DECODE_FAIL"] = "スタイル文字列のデコードに失敗しました。破損している可能性があります。"
L["PRINT_STYLE_INVALID"]     = "無効なスタイル文字列です。!BCB1: または BCB: プレフィックスが必要です。"
L["PRINT_STYLE_IMPORTED"]    = "スタイルをインポートしました！"
L["PRINT_STYLE_SAVED"]       = "スタイル「%s」を保存しました。"
L["PRINT_STYLE_DELETED"]     = "スタイル「%s」を削除しました。"
L["PRINT_SNIPPET_INVALID"]   = "無効なスニペット文字列です。"
L["PRINT_SNIPPET_REMOVED"]   = "スニペット「%s」を削除しました。"
L["PRINT_SNIPPETS_IMPORTED"] = "%d件のスニペットをインポートしました。"
L["PRINT_SNIPPETS_SKIPPED"]  = " %d件をスキップ（既に存在します）。"
L["PRINT_CANT_DELETE_DEFAULT"] = "デフォルトスタイルは削除できません。"
L["PRINT_SETUP_SKIPPED"]     = "セットアップをスキップしました。|cff55ccff/bcb|r でいつでも設定できます。"
L["BTN_RESET_STYLES_CONFIRM"] = "スタイルをリセット"

-- SlashCommands popups
L["POPUP_WIPE_WHISPERS"]     = "ささやき履歴を消去しますか？この操作は元に戻せません。"

-- WelcomePanel
L["WELCOME_CHOOSE_STYLE"]      = "スタイルを選択："
L["WELCOME_STYLE_NOTE"]        = "アドオン名が付いたスタイルはそのアドオンが必要です。\nデザイナータブですべてを完全にカスタマイズできます。"
L["WELCOME_LAYOUT_DESC"]       = "チャンネル名とオートコンプリートの入力ボックスに対する表示位置を選択します。"
L["WELCOME_CHANNEL_POS_LBL"]   = "チャンネル名の位置："
L["WELCOME_AC_POS_LBL"]        = "オートコンプリートの位置："
L["WELCOME_AUTOHIDE_HELP"]     = "入力ボックスにホバーするまでチャンネル名が非表示になります。"
L["WELCOME_CHARCOUNTER_LBL"]   = "文字数カウンターの位置："
L["WELCOME_FEATURES_DESC"]     = "使いたい機能をオンにしてください。すべての機能はデフォルトで有効です。\n機能タブでいつでも変更できます。"
L["WELCOME_LONGMSG_LBL"]       = "長いメッセージ（255文字超）："
L["LONGMSG_DESC_OFF"]          = "255文字で切り捨て"
L["LONGMSG_DESC_SILENT"]       = "自動分割"
L["LONGMSG_DESC_NOTICE"]       = "通知付きで分割"
L["LONGMSG_DESC_CONFIRM"]      = "分割前に確認"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "戦闘ロックの詳細を見る"
L["WELCOME_WHY_KEYBIND"]       = "なぜこれが必要ですか？"
L["WELCOME_CURRENT_KEYBIND"]   = "現在のキー："
L["WELCOME_KEYBIND_CLICK_HINT"] = "クリックして設定 · 右クリックで解除"
L["WELCOME_OPEN_HELP"]         = "ヘルプとヒントウィンドウを開く"
L["WELCOME_HELP_DESC"]         = "すべてのコマンド、キーバインド、機能の詳細はヘルプウィンドウで確認できます。"
L["WELCOME_RELOAD_NOTE"]       = "どちらのボタンもインターフェースを再読み込みします。"
L["WELCOME_COMBAT_PAUSE"]      = "設定を一時停止 -- 戦闘開始。"
L["WELCOME_SHIFTCLICK_TITLE"]  = "Shiftクリックリンク挿入"
L["WELCOME_FEAT_HISTORY"]      = "チャット履歴"
L["WELCOME_FEAT_SNIPPETS"]     = "スニペットシステム"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "補完：!スニペット"
L["WELCOME_FEAT_AC_COMMANDS"]  = "補完：/コマンド"
L["WELCOME_FEAT_AC_WHISPER"]   = "補完：ささやき相手"
L["WELCOME_FEAT_AC_BNET"]      = "補完：Battle.netフレンド"
L["WELCOME_FEAT_KEEP_OPEN"]    = "入力ボックスを開いたままにする"

-- WelcomePanel navigation
L["BTN_PREVIOUS"]  = "前へ"
L["BTN_NEXT"]      = "次へ"

-- !! Language selector (Advanced tab) !!---------------------------------------
L["SECTION_LANGUAGE"]        = "言語"
L["LANGUAGE_DESC"]           = "表示言語を変更します。インターフェースの再読み込みが必要です。"
L["LANGUAGE_CLIENT"]         = "クライアント言語"
L["LANGUAGE_RELOAD_MSG"]     = "言語を変更しました。インターフェースを再読み込みします..."
L["POPUP_CHANGE_LANGUAGE"]   = "言語を変更してインターフェースを再読み込みしますか？"
L["BTN_RELOAD_CONFIRM"]      = "再読み込み"
L["LANGUAGE_COMING_SOON"]    = "|cff888888（近日公開）|r"

-- !! Help popup body strings !!-------------------------------------------------
L["HELP_WINDOW_TITLE"] = "BigChatBoxヘルプ"

L["HELP_BODY_MAIN"] = [[|cffffd100-- コマンド --|r
|cffffd100/bcb|r または |cffffd100/bcb config|r -- 設定ウィンドウを開く。
|cffffd100/bcb edit|r -- アンカーエディターを開いて位置を変更。
|cffffd100/bcb reset|r -- 位置をデフォルトにリセット。

|cffffd100-- チャットの基本 --|r
チャンネル名を|cffffd100左クリック|rしてチャンネルを切り替え（一般、パーティー、ギルドなど）。
チャンネル名を|cffffd100右クリック|rして設定、履歴、クリアオプションにアクセス。
|cffffd100Enter|rでメッセージを送信。|cffffd100Escape|rでクリアして閉じる。
入力ボックスで|cffffd100マウスホイール|rをスクロールしてチャット履歴を見る。

|cffffd100-- オートコンプリート --|r
|cffffd100/|rを入力すると一致するスラッシュコマンドを表示（Tabで循環、Enterで確定）。
|cffffd100!|rを入力するとスニペットトリガーを補完（例：!guild、!inv）。
ささやき相手はフレンド、ギルド、グループ、最近のささやきから補完されます。
|cffffd100Tab|r / |cffffd100Shift+Tab|rで候補を循環。

|cffffd100-- スニペット --|r
Enterを押すと展開されるテキストショートカットを定義します。
例：!guildが「M+メンバー募集！ささやきで招待します！」に展開されます。
各スニペットは特定のチャンネルに制限できます。
|cff5599ffスニペット|rタブでスニペットを管理、作成、インポート、エクスポートします。

|cffffd100-- リンク挿入 --|r
アイテム、スペル、実績などを|cffffd100Shift+クリック|rしてリンクを挿入します。
バッグ、スペルブック、実績パネル、プロフェッション、チャット出力で動作します。
入力ボックス内のリンクに|cffffd100ホバー|rするとツールチップをプレビューします。
直接挿入をサポートしないパネルは|cff5599ffShiftクリック情報|rボタンを参照してください。

|cffffd100-- カスタマイズ --|r
|cff5599ffデザイナー|rタブで背景、枠線、フォント、色をカスタマイズします。
|cff5599ff配置|rタブには精密な位置合わせのためのアンカーエディターがあります。
外観を名前付きスタイルとして保存します。スタイル文字列をエクスポート/インポートして共有します。
LibSharedMediaがインストールされている場合、LSMテクスチャとフォントをサポートします。

|cffffd100-- ツールとトグル --|r
|cff5599ff機能|rタブで各機能を有効または無効にします：
オートコンプリート、スニペット、リンクホバーツールチップ、チャット履歴など。
|cffffd100開いたままにする|rモードは入力ボックスがフォーカスを失っても表示されたままにします。

|cffffd100-- プロフィールとスタイル --|r
設定はデフォルトでキャラクターごとに保存されます。
詳細設定で|cffffd100すべてのキャラクターで使用|rを有効にすると全体的に設定を共有します。
スタイルは視覚的な外観（背景、枠線、フォント、色）を保存します。
エクスポート/インポートを使用してフレンドとスタイルを共有したり、キャラクター間で移動したりします。

|cffffd100-- 位置とサイズ --|r
アンカーエディターで入力ボックスをクリック＆ドラッグして新しい位置に移動します。
方向キーで1ピクセルずつ精密に調整します。
Shift+ドラッグで入力ボックスを対称的にリサイズします。
入力ボックスで|cffffd100Shift+Alt+クリック|rすると位置を画面中央にリセットします。
アンカーエディターの情報パネルで正確な位置とサイズ値を設定することもできます。

|cffffd100-- 長いメッセージ --|r
255文字を超えるメッセージは自動的に複数回の送信に分割できます。
|cff5599ff機能|rタブで動作を設定します：オフ、自動、通知、または確認。
文字数カウンターが上限まであとどれくらいかを表示します。

|cffffd100-- 動的なサイズ調整 --|r
デザイナータブで|cffffd100動的な高さ|rと|cffffd100動的な幅|rを有効にします。
高さはフォントサイズに合わせて調整され、幅はメッセージの長さで増えます。]]

L["HELP_BODY_SECURE"] = "|cffffd100-- BigChatBoxが戦闘/M+などで一時停止する理由 --|r\n\n" ..
    "ミッドナイト拡張（12.0）に伴い、Blizzardは戦闘中のアドオンとゲームの連携方法に大きな変更を加えました。この取り組みは|cff5599ffアドオン武装解除|rと呼ばれ、アドオンが戦闘情報を扱う方法を制限します。\n\n" ..
    "|cffffd100何が変わりましたか？|r\n" ..
    "戦闘関連データは|cffff9900「秘密の値」|rとして扱われるようになりました。アドオンはこの情報を表示できますが、コード内で読み取ったり処理したりすることはできません。\n\n" ..
    "多くのUIフレームは戦闘中に|cffff9900保護|rされています。インスタンスコンテンツ（M+、アリーナ、レーティングBG）では制限がさらに厳しくなります。これらの保護されたフレームを変更またはフックするアドオンは|cffff6666汚染|rを広げるリスクがあり、ゲーム機能を完全に壊す可能性があります -- アドオンだけでなく、ターゲット指定、スペル詠唱、アビリティ使用などのコアゲーム機能も含まれます。\n\n" ..
    "|cffffd100BigChatBoxへの影響は？|r\n" ..
    "WoWのデフォルトチャット入力ボックス（ChatFrame1EditBox）は/target、/cast、/focusなどのセキュアスラッシュコマンドを処理するため保護されたフレームです。BigChatBoxはチャット入力を傍受するためにこのフレームにフックします。戦闘中およびインスタンスの競技コンテンツ中、これらのフックが汚染を引き起こし、チャットシステム全体をブロックする可能性があります。\n\n" ..
    "ユーザーを守るため、BigChatBoxは戦闘中およびM+、アリーナ、レーティングBG中に|cff00ff00自動的に一時停止|rします。Blizzardのデフォルトチャット入力がシームレスに代わりを務めます。戦闘が終了するかコンテンツが完了すると、BigChatBoxは自動的に再開します。\n\n" ..
    "|cffffd100なぜ修正しないのですか？|r\n" ..
    "これは|cffff0000バグではありません！|rWoWのセキュリティモデルの根本的な制限です。戦闘中に保護されたフレームを変更するすべてのアドオンは同じ制限に直面します。Blizzardはアドオンが戦闘の判断を自動化できないようにこれらの制限を設計しており、チャット入力ボックスがその保護範囲に含まれます。\n\n" ..
    "|cffffd100まとめ|r\n" ..
    "BigChatBoxは戦闘中およびタイムドコンテンツ（M+、アリーナ、レーティングBG）中に一時停止します。その間もBlizzardのデフォルトチャット入力を使って普通にチャットできます。戦闘が終わるかアクティビティが完了すると、BigChatBoxは自動的に再開します。"

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100-- なぜすべてのShiftクリックが機能しないのですか？ --|r\n\n" ..
    "ほとんどのShiftクリックリンク挿入はBigChatBoxで直接機能します。ただし、一部のゲームパネルはBlizzard独自のチャット入力ボックスにのみリンクを挿入する内部Blizzard関数を使用しており、アドオンの入力ボックスをバイパスします。\n\n" ..
    "|cff00ff00BigChatBoxで機能：|r\n" ..
    "  · 個人バッグのアイテム\n" ..
    "  · ペットジャーナルのペット\n" ..
    "  · エアルームパネルのエアルーム\n" ..
    "  · 商人パネルのアイテム\n" ..
    "  · メールボックスのアイテム\n" ..
    "  · プロフェッションパネルのクラフトレシピと素材\n" ..
    "  · チャットウィンドウ内のリンク\n\n" ..
    "|cffff9900Blizzardチャットが必要：|r\n" ..
    "  · 実績パネルの実績\n" ..
    "  · バンクパネルのアイテム\n" ..
    "  · ギルドバンクパネルのアイテム\n" ..
    "  · マウントジャーナルの乗り物\n" ..
    "  · タレントパネルのタレント\n" ..
    "  · トランスモグリフィケーションの外見\n" ..
    "  · 一部の拡張パック固有パネル\n\n" ..
    "|cffffd100なぜですか？|r\n" ..
    "これらのパネルはBlizzardの特定の入力ボックスを確認するWoW内部の|cff5599ffChatEdit_InsertLink|r関数を使用しています。BigChatBoxはこれらの呼び出しのほとんどを傍受しますが、Blizzardの実装方法により一部のパネルは標準フックを完全にバイパスします。これはWoW APIの制限であり、バグではありません。\n\n" ..
    "|cffffd100解決策|r\n" ..
    "|cff5599ffBlizzardチャットキーバインド|r（デフォルト：Ctrl+Enter）を押すと即座にBlizzardのネイティブチャット入力に切り替わります。そこで入力またはShiftクリックしてEnterで送信すると、BigChatBoxは次のメッセージから自動的に再開します。\n\n" ..
    "このキーを変更または解除するには：\n" ..
    "  · |cffffd100/bcb|r > 詳細タブ\n" ..
    "  · Esc > キーバインド > アドオン > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "%sに切り替えてセットアップを再起動しますか？\nBigChatBoxは新しい言語を適用するために再読み込みされます。"

-- !! v5.6.1 Emoji & Emoticon picker !!-----------------------------------------
L["SECTION_EMOJI"]          = "顔文字ピッカー"
L["CB_SHOW_EMOJI_PICKER"]   = "顔文字ピッカーボタンを表示"
L["EMOJI_PICKER_TITLE"]     = "顔文字ピッカー"
L["EMOJI_PICKER_TOOLTIP"]   = "クリックして顔文字ピッカーを開く"
L["EMOJI_TAB_LAST"]         = "最近使用"
L["EMOJI_TAB_ASCII"]        = "顔文字"
L["EMOJI_LAST_EMPTY"]       = "最近の選択はありません。"

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "履歴を検索..."

L["BTN_SAVE_SNIPPET"]           = "保存"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "デフォルトスタイルを使用"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "チェックすると、アクティブなスタイルに関わらず複数行ボックスはデフォルトスタイルを使用します。現在のBCBの外観を使用するにはチェックを外してください。"

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "複数行入力"
L["CB_ENABLE_MULTILINE"]        = "複数行入力を有効にする"
L["CB_ENABLE_MULTILINE_HELP"]   = "複数行のメッセージを作成するための大きな入力ボックスを開きます。各行は別々に送信されます。"
L["KEYBIND_OPEN_MULTILINE"]     = "複数行入力を開く："
L["MULTILINE_KEYBIND_HELP"]     = "デフォルト：Shift+Enter。Enterで新しい行を追加し、Shift+Enterですべての行を送信する大きな入力ボックスを開きます。"
L["BTN_OPEN_KEYBINDINGS"]       = "キーバインドを開く"
L["MULTILINE_SEND_BTN"]         = "送信"
L["MULTILINE_CHANNEL_LABEL"]    = "チャンネル：%s"
L["MULTILINE_BLOCKED_SECURE"]   = "M+/アリーナ/レーティングBG中は複数行入力を使用できません。"
L["MULTILINE_HINT"]             = "Enter = 改行   |   Shift+Enter = すべて送信"
