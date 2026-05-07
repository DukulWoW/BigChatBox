-- BigChatBox Localization - Korean (koKR)
-- Version: 5.6.1
-- Full translation for 5.6.1 locale system. Overrides all keys that differ from enUS.
-- Missing keys fall back to enUS automatically.

local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "koKR" and (BigChatBox and BigChatBox._forcedLocale) ~= "koKR" then return end

-- ── Addon identity ────────────────────────────────────────────────────────────
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "버전"
L["LOADED_MSG"]   = "BigChatBox v%s 로드됨! /bcb 를 입력하여 옵션을 여세요."

-- ── Config window tabs ────────────────────────────────────────────────────────
L["TAB_GENERAL"]   = "일반"
L["TAB_DESIGNER"]  = "디자이너"
L["TAB_PLACEMENT"] = "배치"
L["TAB_FEATURES"]  = "기능"
L["TAB_SNIPPETS"]  = "단축 문구"
L["TAB_HISTORY"]   = "기록"
L["TAB_ADVANCED"]  = "고급"
L["TAB_RESET"]     = "초기화"

-- ── Reset tab ─────────────────────────────────────────────────────────────────
L["RESET_TAB_HEADER"]       = "초기화 및 복원"
L["RESET_TAB_DESC"]         = "이 작업은 영구적이며 취소할 수 없습니다."
L["RESET_ALL_HELP"]         = "모든 항목을 초기화합니다: 위치, 외관, 기록, 단축 문구."
L["RESET_APPEARANCE_HELP"]  = "배경, 테두리, 글꼴, 색상만 초기화합니다."
L["RESET_PLACEMENT_HELP"]   = "위치와 크기를 기본값으로 초기화합니다."
L["RESET_HISTORY_HELP"]     = "저장된 채팅 및 귓속말 기록을 모두 지웁니다."
L["RESET_SNIPPETS_HELP"]    = "모든 단축 문구를 삭제합니다."
L["RESET_STYLES_HELP"]      = "저장된 사용자 지정 스타일을 모두 삭제합니다."
L["RESTART_SETUP_HELP"]     = "모든 설정을 초기화하고 초기 설정 마법사를 다시 실행합니다."

-- ── Shared UI ─────────────────────────────────────────────────────────────────
L["PREVIEW"]        = "미리보기"
L["TYPE_SOMETHING"] = "여기에 입력하세요..."
L["CLOSE"]          = "닫기"
L["ACTIONS"]        = "작업"
L["RESET"]          = "초기화"
L["OK"]             = "확인"
L["CANCEL"]         = "취소"
L["YES"]            = "예"
L["NO"]             = "아니오"
L["SAVE"]           = "저장"
L["DELETE"]         = "삭제"
L["EDIT"]           = "편집"
L["IMPORT"]         = "가져오기"
L["EXPORT"]         = "내보내기"
L["DUPLICATE"]      = "복제"
L["SHARE"]          = "공유"
L["ENABLED"]        = "활성화됨"
L["DISABLED"]       = "비활성화됨"

-- ── General tab ───────────────────────────────────────────────────────────────
L["BTN_VIEW_PATCH_NOTES"]     = "패치 노트 보기"
L["BTN_HELP_AND_TIPS"]        = "도움말 및 팁"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "전투 잠금 정보"
L["BTN_SHIFT_CLICK_INFO"]     = "Shift 클릭 정보"

-- General tab feature grid
L["CELL_SNIPPETS_HDR"]       = "|cff5599ff단축 문구|r"
L["CELL_SNIPPETS_DESC"]      = "전송 시 확장되는 텍스트 단축키.\n단축 문구 탭에서 관리합니다."
L["CELL_ANCHOR_HDR"]         = "|cff5599ff앵커 편집기|r"
L["CELL_ANCHOR_DESC"]        = "클릭하여 드래그해 위치를 변경합니다.\n방향키로 픽셀 단위 정밀 조정."
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ff자동 완성|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "명령어, 귓속말 대상,\n단축 문구 트리거(!길드)에 스마트 Tab 완성."
L["CELL_HISTORY_HDR"]        = "|cff5599ff채팅 기록|r"
L["CELL_HISTORY_DESC"]       = "타임스탬프가 있는 전체 기록.\n마우스 휠로 스크롤."
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ff사용자 지정|r"
L["CELL_CUSTOMIZATION_DESC"] = "디자이너 탭에서 배경, 테두리,\n글꼴, 색상 설정. 스타일 저장 및 공유."
L["CELL_SECURE_HDR"]         = "|cffff9900보안 콘텐츠|r"
L["CELL_SECURE_DESC"]        = "쐐기돌, 투기장, 등급 전장에서\n채팅 보호를 위해 자동 일시 정지."
L["CELL_SHARING_HDR"]        = "|cff5599ff공유|r"
L["CELL_SHARING_DESC"]       = "스타일과 단축 문구를 짧은 문자열로\n내보내어 친구와 공유합니다."
L["CELL_LONGMSG_HDR"]        = "|cff5599ff긴 메시지|r"
L["CELL_LONGMSG_DESC"]       = "255자를 초과하는 메시지는 자동으로\n분할됩니다. 자동, 알림 또는 확인."

-- ── Styles (Designer tab) ─────────────────────────────────────────────────────
L["STYLES"]              = "스타일"
L["ACTIVE_STYLE"]        = "현재 스타일"
L["BTN_SAVE_STYLE"]      = "스타일 저장"
L["BTN_DELETE_STYLE"]    = "스타일 삭제"
L["BTN_EXPORT_STYLE"]    = "스타일 내보내기"
L["BTN_IMPORT_STYLE"]    = "스타일 가져오기"

-- ── Designer tab sections ─────────────────────────────────────────────────────
L["SECTION_SIZE"]         = "크기"
L["SECTION_BACKGROUND"]   = "배경"
L["SECTION_BORDER"]       = "테두리"
L["SECTION_FONTS"]        = "글꼴"
L["SECTION_TEXT_OPTIONS"] = "텍스트 옵션"

-- Designer tab slider / dropdown labels
L["LABEL_WIDTH"]              = "너비"
L["LABEL_HEIGHT"]             = "높이"
L["LABEL_SCALE"]              = "배율"
L["LABEL_BG_TEXTURE"]         = "배경 텍스처"
L["LABEL_BG_OPACITY"]         = "배경 불투명도"
L["LABEL_BG_BRIGHTNESS"]      = "배경 밝기"
L["LABEL_BG_SCALE"]           = "배경 배율"
L["LABEL_TINT_INTENSITY"]     = "색조 강도"
L["LABEL_BORDER_TEXTURE"]     = "테두리 텍스처"
L["LABEL_BORDER_OPACITY"]     = "테두리 불투명도"
L["LABEL_BORDER_BRIGHTNESS"]  = "테두리 밝기"
L["LABEL_BORDER_THICKNESS"]   = "테두리 두께"
L["LABEL_CHANNEL_FONT"]       = "채널 글꼴"
L["LABEL_INPUT_FONT"]         = "입력 글꼴"
L["LABEL_CHANNEL_FONT_SIZE"]  = "채널 글꼴 크기"
L["LABEL_INPUT_FONT_SIZE"]    = "입력 글꼴 크기"
L["LABEL_TEXT_ALIGNMENT"]     = "텍스트 정렬"
L["LABEL_FONT_OUTLINE"]       = "글꼴 외곽선"

-- Designer tab checkboxes
L["CB_DYNAMIC_HEIGHT"]   = "동적 높이"
L["CB_DYNAMIC_WIDTH"]    = "동적 너비"
L["CB_TINT_BG"]          = "채널 색상으로 배경 색조 적용"
L["CB_MATCH_TEXT_COLOR"] = "채널 색상에 맞게 텍스트 색상 변경"

-- ── Placement tab ─────────────────────────────────────────────────────────────
L["SECTION_LAYOUT_OPTIONS"]   = "레이아웃 옵션"
L["SECTION_POSITION"]         = "위치"
L["LABEL_CHANNEL_NAME_POS"]   = "채널 이름 위치"
L["CB_SHOW_CHANNEL"]           = "채널 이름 표시"
L["LABEL_AUTOCOMPLETE_POS"]   = "자동 완성 위치"
L["LABEL_CHAR_COUNTER_POS"]   = "글자 수 표시 위치"
L["CB_AUTO_HIDE_CHANNEL"]     = "채널 이름 자동 숨기기 (마우스 올리면 표시)"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "앵커 편집기 열기"

-- ── Features tab ─────────────────────────────────────────────────────────────
L["SECTION_FEATURE_TOGGLES"]  = "기능 켜기/끄기"
L["FEATURE_TOGGLES_DESC"]     = "BigChatBox 기능을 활성화하거나 비활성화합니다."
L["SECTION_SNIPPET_SYSTEM"]   = "단축 문구 시스템"
L["SECTION_AUTOCOMPLETE"]     = "자동 완성"
L["SECTION_HISTORY"]          = "기록"
L["SECTION_LINK_HOVER"]       = "링크 마우스 오버"
L["SECTION_LONG_MESSAGES"]    = "긴 메시지"
L["CB_ENABLE_SNIPPETS"]       = "단축 문구 시스템 활성화"
L["CB_AC_COMMANDS"]           = "슬래시 명령어 자동 완성 (/dance, /guild, ...)"
L["CB_AC_WHISPER"]            = "귓속말 이름 자동 완성 (/w <이름>)"
L["CB_AC_SNIPPETS"]           = "단축 문구 트리거 자동 완성 (!guild, ...)"
L["CB_AC_BNET"]               = "귓속말 자동 완성에 Battle.net 친구 표시"
L["CB_ENABLE_HISTORY"]        = "채팅 기록 활성화"
L["CB_MOUSEWHEEL_HISTORY"]    = "마우스 휠로 기록 스크롤"
L["CB_LINK_HOVER"]            = "링크에 마우스를 올리면 툴팁 표시"
L["LABEL_MSG_EXCEEDS_255"]    = "메시지가 255자를 초과할 때"

-- ── Snippets tab ──────────────────────────────────────────────────────────────
L["SNIPPETS_DISABLED_MSG"]    = "단축 문구 시스템이 비활성화되어 있습니다.\n기능 탭에서 활성화하세요."
L["SNIPPETS_HEADER"]          = "단축 문구"
L["SNIPPETS_DESC"]            = "채팅에 단축 문구 트리거(예: !guild)를 입력하고 Enter를 눌러 전송하면 확장됩니다."
L["SNIPPET_EDIT_HEADER"]      = "편집"
L["SNIPPET_ACTIVE"]           = "단축 문구 활성화됨"
L["SNIPPET_TRIGGER_LBL"]      = "트리거:"
L["SNIPPET_TEXT_LBL"]         = "텍스트:"
L["SNIPPET_CHANNEL_LBL"]      = "채널:"
L["SNIPPET_GLOBAL"]           = "모든 캐릭터에서 사용 가능"
L["SNIPPET_EMPTY_LIST"]       = "단축 문구가 없습니다.\n새 단축 문구 또는\n가져오기를 눌러 시작하세요."
L["BTN_NEW_SNIPPET"]          = "새 단축 문구"
L["BTN_EXPORT_ALL"]           = "전체 내보내기"
L["BTN_SHARE_SNIPPET"]        = "공유"
L["BTN_DUPLICATE_SNIPPET"]    = "복제"
L["BTN_DELETE_SNIPPET"]       = "삭제"
L["BTN_IMPORT_SNIPPET"]       = "가져오기"

-- ── History tab ───────────────────────────────────────────────────────────────
L["HISTORY_HEADER"]           = "채팅 기록"
L["HISTORY_HELP"]             = "텍스트를 클릭하여 재사용. 마우스를 올리면 타임스탬프 표시. X를 클릭하면 삭제 표시."
L["HISTORY_EMPTY"]            = "기록이 없습니다."
L["HISTORY_MORE"]             = "... 외 %d개"
L["WHISPERS_HEADER"]          = "최근 귓속말"
L["WHISPERS_CLICK_HINT"]      = "(클릭하여 귓속말)"
L["WHISPERS_EMPTY"]           = "귓속말 기록이 없습니다."
L["BTN_WIPE_HISTORY"]         = "전체 기록 지우기"
L["BTN_WIPE_COMMANDS"]        = "모든 /명령어 지우기"
L["BTN_REMOVE_ENTRIES"]       = "항목 삭제"

-- ── Advanced tab ──────────────────────────────────────────────────────────────
L["SECTION_PROFILES"]         = "프로필"
L["PROFILES_DESC"]            = "설정은 캐릭터별로 저장됩니다. 활성화하면 모든 캐릭터에서 공유됩니다."
L["CB_GLOBAL_PROFILE"]        = "모든 캐릭터에서 사용"
L["BEHAVIOR"]                 = "동작"
L["KEEP_OPEN"]                = "Escape를 누를 때까지 입력창 열어두기"
L["KEEP_OPEN_HELP"]           = "활성화하면 다른 곳을 클릭해도 입력창이 보입니다. Escape를 눌러 닫습니다."
L["SHOW_LOCKDOWN_WARNING"]    = "보안 콘텐츠 경고 표시"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "쐐기돌, 투기장, 등급 전장에서 BCB가 일시 정지될 때 채팅에 메시지를 표시합니다."
L["IGNORE_COMMANDS_HISTORY"]  = "기록에서 /명령어 무시"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "/target, /cast 같은 슬래시 명령어는 채팅 기록에 저장되지 않습니다."
L["SHOW_MINIMAP_BUTTON"]      = "미니맵 버튼 표시"
L["SHOW_MINIMAP_BUTTON_HELP"] = "좌클릭으로 설정 열기, 우클릭으로 빠른 설정 열기. 애드온 구획 버튼은 항상 사용 가능합니다."
L["HIDE_LOGIN_MSG"]           = "로그인 메시지 숨기기"
L["HIDE_LOGIN_MSG_HELP"]      = "로그인 시 \"BigChatBox 로드됨\" 메시지를 숨깁니다."
L["KEYBIND_OPEN_BLIZZARD"]    = "블리자드 채팅 열기:"
L["KEYBIND_NOT_BOUND"]        = "미지정"
L["KEYBIND_PRESS_KEY"]        = "키를 누르세요..."
L["KEYBIND_CONFLICT"]         = "%s는 이미 %s에 지정되어 있습니다. 덮어쓸까요?"
L["KEYBIND_TOOLTIP_BOUND"]    = "블리자드 채팅 열기 (%s)"
L["KEYBIND_TOOLTIP_UNBIND"]   = "우클릭으로 지정 해제"
L["KEYBIND_TOOLTIP_SET"]      = "클릭하여 단축키 설정"
L["KEYBIND_HELP"]             = "탈것, 업적, 장난감, 특성의 Shift 클릭을 위해 블리자드 기본 채팅을 엽니다. 기본값: Ctrl+Enter."
L["RESET_ALL"]                = "모든 설정 초기화"
L["RESET_APPEARANCE"]         = "외관 초기화"
L["RESET_PLACEMENT"]          = "배치 초기화"
L["RESET_HISTORY_BTN"]        = "기록 초기화"
L["RESET_SNIPPETS_BTN"]       = "단축 문구 초기화"
L["RESET_STYLES_BTN"]         = "스타일 초기화"
L["RESTART_SETUP"]            = "설정 마법사 재시작"

-- ── Reset / action confirmations (StaticPopupDialogs) ────────────────────────
L["POPUP_RESET_ALL"]          = "BigChatBox의 모든 설정을 기본값으로 초기화할까요?\n위치, 크기, 외관, 글꼴이 포함됩니다."
L["POPUP_RESET_APPEARANCE"]   = "외관을 기본값으로 초기화할까요?\n위치나 기록에는 영향을 주지 않습니다."
L["POPUP_RESET_PLACEMENT"]    = "배치를 기본값으로 초기화할까요?\n인터페이스가 다시 로드됩니다."
L["POPUP_RESET_HISTORY"]      = "채팅 및 귓속말 기록을 모두 초기화할까요?\n기록 길이가 100으로 설정됩니다.\n인터페이스가 다시 로드됩니다."
L["POPUP_RESET_SNIPPETS"]     = "모든 단축 문구를 삭제할까요? 인터페이스가 다시 로드됩니다."
L["POPUP_RESET_STYLES"]       = "사용자가 만든 스타일을 모두 삭제할까요?\n기본 스타일은 유지되어 현재 스타일이 됩니다.\n인터페이스가 다시 로드됩니다."
L["POPUP_WIPE_HISTORY"]       = "채팅 기록을 모두 지울까요?\n인터페이스가 다시 로드됩니다."
L["POPUP_WIPE_COMMANDS"]      = "채팅 기록에서 모든 /명령어를 삭제할까요?\n일반 메시지는 유지됩니다.\n인터페이스가 다시 로드됩니다."
L["POPUP_DELETE_STYLE"]       = "현재 스타일을 삭제할까요?"
L["POPUP_OVERWRITE_STYLE"]    = "'%s' 스타일이 이미 존재합니다. 덮어쓸까요?"
L["POPUP_SAVE_STYLE_TEXT"]    = "이 스타일의 이름을 입력하세요:"
L["POPUP_EXPORT_STYLE_TEXT"]  = "아래 스타일 문자열을 복사하세요:"
L["POPUP_IMPORT_STYLE_TEXT"]  = "스타일 문자열을 붙여넣으세요:"
L["POPUP_NAME_IMPORT_STYLE"]  = "가져온 스타일을 다음 이름으로 저장:"
L["POPUP_DELETE_SNIPPET"]     = "'%s' 단축 문구를 삭제할까요?"
L["POPUP_SHARE_SNIPPET_TEXT"] = "단축 문구 문자열 복사 (Ctrl+C):"
L["POPUP_IMPORT_SNIPPET_TEXT"] = "단축 문구 문자열 붙여넣기 (Ctrl+V):"
L["POPUP_RESTART_SETUP"]      = "모든 설정이 초기화되고 환영 마법사가 다시 시작됩니다.\n계속할까요?"
L["POPUP_QUIT_SETUP"]         = "설정을 종료할까요?\n기본 설정이 사용됩니다."
L["BTN_RESET_ALL_CONFIRM"]    = "모두 초기화"
L["BTN_WIPE_CONFIRM"]         = "예, 지우기"
L["BTN_DELETE_CONFIRM"]       = "삭제"
L["BTN_OVERWRITE_CONFIRM"]    = "덮어쓰기"
L["BTN_SKIP"]                 = "건너뛰기"
L["BTN_RESTART_SETUP_CONFIRM"] = "마법사 재시작"
L["BTN_QUIT_SETUP_CONFIRM"]   = "설정 종료"
L["BTN_SAVE_CLOSE"]           = "닫기"

-- ── Slash commands / print messages ──────────────────────────────────────────
L["SLASH_POSITION_RESET"]     = "위치가 기본값으로 초기화되었습니다"
L["SLASH_ANCHOR_UNAVAILABLE"] = "앵커 편집기를 사용할 수 없습니다."
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox:|r 채팅 기록이 지워졌습니다."
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox:|r 외관이 기본값으로 초기화되었습니다"
L["RESET_DONE"]               = "모든 설정이 기본값으로 초기화되었습니다."
L["COMBAT_CLOSE"]             = "전투 진입 -- 설정이 닫혔습니다."
L["COMBAT_BLOCKED"]           = "전투 중에는 설정을 열 수 없습니다."

-- ── Position / size labels (legacy keys) ─────────────────────────────────────
L["POSITION"]        = "위치"
L["X_POSITION"]      = "X 위치"
L["Y_POSITION"]      = "Y 위치"
L["SIZE"]            = "크기"
L["WIDTH"]           = "너비"
L["HEIGHT"]          = "높이"
L["SCALE"]           = "배율"
L["FONT_SIZES"]      = "글꼴 크기"
L["INPUT_FONT_SIZE"] = "입력 글꼴 크기"
L["CHANNEL_FONT_SIZE"] = "채널 글꼴 크기"
L["FONTS"]           = "글꼴"
L["INPUT_FONT"]      = "입력 글꼴"
L["CHANNEL_FONT"]    = "채널 글꼴"
L["BACKGROUND"]      = "배경"
L["BG_TEXTURE"]      = "배경 텍스처"
L["BG_TRANSPARENCY"] = "배경 불투명도"
L["BG_BRIGHTNESS"]   = "배경 밝기"
L["BG_SCALE"]        = "배경 배율"
L["BORDER"]          = "테두리"
L["BORDER_TEXTURE"]  = "테두리 텍스처"
L["BORDER_TRANSPARENCY"] = "테두리 불투명도"
L["BORDER_BRIGHTNESS"]   = "테두리 밝기"
L["BORDER_THICKNESS"]    = "테두리 두께"
L["TEXT_OPTIONS"]    = "텍스트 옵션"
L["MATCH_TEXT_COLOR"] = "채널 색상에 맞게 텍스트 색상 변경"
L["SHOW_OUTLINE"]    = "텍스트 외곽선 표시"
L["SHOW_SHADOW"]     = "텍스트 그림자 표시"
L["DROP_SHADOW"]     = "입력창 드롭 섀도우"
L["TEXT_ALIGN"]      = "텍스트 정렬"
L["CHAT_HISTORY"]    = "채팅 기록"
L["HISTORY_LENGTH"]  = "기록 길이"
L["WIPE_HISTORY"]    = "전체 기록 지우기"
L["RECENT_WHISPERS"] = "최근 귓속말"
L["SNIPPETS"]        = "단축 문구"
L["SNIPPET_TRIGGER"] = "트리거"
L["SNIPPET_TEXT"]    = "텍스트"
L["SNIPPET_SAVE"]    = "저장"
L["SNIPPET_DELETE"]  = "삭제"
L["SNIPPET_NEW"]     = "새 단축 문구"
L["SNIPPET_SHARE"]   = "단축 문구 공유"
L["SNIPPET_EXPORT"]  = "전체 내보내기"
L["SNIPPET_IMPORT"]  = "가져오기"
L["SNIPPET_RESET"]   = "단축 문구 초기화"
L["AUTOCOMPLETE"]    = "자동 완성"
L["AUTOCOMPLETE_POS"] = "자동 완성 위치"
L["CHANNEL_POS"]     = "채널 이름 위치"
L["AUTO_HIDE_CHANNEL"] = "채널 이름 자동 숨기기 (마우스 올리면 표시)"
L["LAYOUT_OPTIONS"]  = "레이아웃 옵션"
L["ANCHOR_EDITOR"]   = "앵커 편집기"
L["OPEN_ANCHOR_EDITOR"] = "앵커 편집기 열기"
L["ABOUT"]           = "정보"
L["ABOUT_DESC"]      = "채널 표시, 앵커 편집기, 완전한 외관 제어 기능이 있는 크고 사용자 지정 가능한 채팅 입력창."
L["PROFILES"]        = "프로필"
L["SAVE_STYLE"]      = "스타일 저장"
L["DELETE_STYLE"]    = "스타일 삭제"
L["DYNAMIC_HEIGHT"]  = "동적 높이"
L["DYNAMIC_WIDTH"]   = "동적 너비"
L["CHAR_COUNTER_POS"] = "글자 수 표시 위치"
L["LONG_MESSAGES"]   = "긴 메시지"
L["LONG_MSG_OFF"]    = "꺼짐"
L["LONG_MSG_SILENT"] = "자동"
L["LONG_MSG_NOTICE"] = "알림"
L["LONG_MSG_CONFIRM"] = "확인"
L["LONG_MSG_DESC_OFF"]     = "255자에서 잘림 (기본 WoW 동작)."
L["LONG_MSG_DESC_SILENT"]  = "자동으로 여러 메시지로 분할됩니다."
L["LONG_MSG_DESC_NOTICE"]  = "분할 후 몇 부분이 전송되었는지 표시합니다."
L["LONG_MSG_DESC_CONFIRM"] = "분할 전 확인을 요청합니다."
L["IMPORT_STYLE_BTN"]  = "스타일 문자열 가져오기"
L["FINISH_CONFIG_BTN"] = "완료 + 설정"
L["BG_COLOR"]          = "배경 색상"
L["MSG_SPLIT_NOTICE"]  = "메시지가 %d개 부분(%d자)으로 분할되었습니다."

-- ── v5.3.3 Keybinding strings ─────────────────────────────────────────────────
L["HELP_KEYBINDINGS_TITLE"] = "-- 단축키 --"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+Enter는 블리자드 기본 채팅으로 전환합니다 (어디서나 작동).\n탈것, 업적, 장난감 상자, 특성, 주문서처럼 BCB에 직접 삽입되지 않는\n항목을 Shift 클릭할 때 유용합니다. 블리자드 창에 입력한 후\nEnter를 눌러 전송하면 BCB가 다음 Enter에서 재개됩니다.\n\n고급 탭 또는\nEsc > 단축키 > 애드온 > BigChatBox에서 재지정하거나 해제할 수 있습니다."

-- ── v5.5.0 Welcome Panel ─────────────────────────────────────────────────────
L["WELCOME_TITLE"]          = "BigChatBox에 오신 것을 환영합니다!"
L["WELCOME_SUBTITLE"]       = "초기 설정"
L["WELCOME_TEXT"]           = "BigChatBox는 WoW의 작은 채팅 입력창을 크고 완전히 사용자 지정 가능한 입력창으로 교체합니다.\n\n크기, 배경, 테두리, 글꼴, 색상을 변경하거나 준비된 스타일을 선택할 수 있습니다. 채팅 기록, 텍스트 단축 문구, 스마트 자동 완성 등의 기능이 내장되어 있으며 언제든지 켜거나 끌 수 있습니다.\n\n이 빠른 설정으로 1분 이내에 시작할 수 있습니다."
L["WELCOME_SETUP_BTN"]      = "BigChatBox 설정"
L["WELCOME_LANG_LBL"]       = "표시 언어:"
L["WELCOME_STYLE_TITLE"]    = "스타일을 선택하세요!"
L["WELCOME_LAYOUT_TITLE"]   = "레이아웃 선택"
L["WELCOME_FEATURES_TITLE"] = "기능을 선택하세요!"
L["WELCOME_ADVANCED_TITLE"] = "고급 기능"
L["WELCOME_FINAL_TITLE"]    = "거의 완료!"
L["WELCOME_FINISH_BTN"]     = "완료!"
L["WELCOME_QUIT_CONFIRM"]   = "설정을 종료할까요? 기본 설정이 사용됩니다."
L["WELCOME_KEYBIND_INFO"]   = "대부분의 Shift 클릭 링크 삽입은 BigChatBox에서 직접 작동합니다. 일부 예외(탈것, 장난감, 특성)의 경우 이 단축키로 블리자드 채팅 입력으로 전환합니다."
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBox는 전투, 쐐기돌, 투기장, 등급 전장 중에 채팅을 보호하기 위해 자동으로 일시 정지합니다."
L["WELCOME_THANKS"]         = "BigChatBox를 사용해 주셔서 감사합니다!"
L["WELCOME_SECURE_TITLE"]   = "보안 콘텐츠"
L["WELCOME_KEYBIND_TITLE"]  = "블리자드 채팅 단축키"
L["WELCOME_CONFIG_HINT"]    = "/bcb 를 입력하면 언제든지 전체 설정 창을 열 수 있습니다."
L["FEATURE_HISTORY_DESC"]   = "타임스탬프와 함께 전송된 메시지를 저장합니다."
L["FEATURE_SNIPPETS_DESC"]  = "Enter를 누르면 확장되는 텍스트 단축키."
L["FEATURE_AC_SNIPPETS_DESC"]  = "!로 시작하는 단축 문구 트리거를 자동 완성합니다."
L["FEATURE_AC_COMMANDS_DESC"]  = "/dance, /guild 같은 슬래시 명령어를 자동 완성합니다."
L["FEATURE_AC_WHISPERS_DESC"]  = "귓속말 시 플레이어 이름을 자동 완성합니다."
L["FEATURE_MOUSEWHEEL_DESC"]   = "마우스 휠로 이전 메시지를 스크롤합니다."
L["FEATURE_GLOBAL_PROFILE_DESC"] = "이 계정의 모든 캐릭터에서 설정을 공유합니다."
L["FEATURE_KEEP_OPEN_DESC"]    = "다른 곳을 클릭해도 입력창이 보입니다."
L["RESTART_SETUP_CONFIRM"]  = "모든 설정이 초기화되고 환영 마법사가 다시 시작됩니다. 계속할까요?"

-- ── v5.6.0 Patch notes UI ────────────────────────────────────────────────────
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox -- 새로운 기능"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox -- 패치 노트"
L["PATCHNOTES_DONT_SHOW"]      = "다시 표시 안 함"
L["PATCHNOTES_GOT_IT"]         = "확인!"
L["PATCHNOTES_PREVIOUS"]       = "-- 이전 업데이트 --"

-- ── Keys added during source wiring (v5.6.0 localization pass) ───────────────

-- Features tab
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffff꺼짐|r -- 255자에서 잘림 (기본 WoW 동작).\n|cffffffff자동|r -- 자동으로 여러 메시지로 분할됩니다.\n|cffffffff알림|r -- 분할 후 몇 부분이 전송되었는지 표시합니다.\n|cffffffff확인|r -- 분할 전 확인을 요청합니다."

-- Snippets tab
L["SNIPPET_NOTHING_TO_EXPORT"] = "내보낼 단축 문구가 없습니다."

-- History tab
L["HISTORY_LENGTH_LABEL"] = "기록 길이"

-- ConfigMain print messages
L["PRINT_RESET_ALL"]         = "모든 설정이 기본값으로 초기화되었습니다. 다시 로드 중..."
L["PRINT_RESET_APPEARANCE"]  = "외관이 초기화되었습니다. 다시 로드 중..."
L["PRINT_RESET_PLACEMENT"]   = "배치가 초기화되었습니다. 다시 로드 중..."
L["PRINT_RESET_HISTORY"]     = "기록이 초기화되었습니다. 다시 로드 중..."
L["PRINT_SNIPPETS_REMOVED"]  = "모든 단축 문구가 삭제되었습니다."
L["PRINT_STYLES_REMOVED"]    = "모든 사용자 지정 스타일이 삭제되었습니다."
L["PRINT_NO_STYLE_STRING"]   = "스타일 문자열이 제공되지 않았습니다."
L["PRINT_STYLE_DECODE_FAIL"] = "스타일 문자열 디코딩에 실패했습니다. 손상되었을 수 있습니다."
L["PRINT_STYLE_INVALID"]     = "잘못된 스타일 문자열입니다. !BCB1: 또는 BCB: 접두사가 필요합니다."
L["PRINT_STYLE_IMPORTED"]    = "스타일을 가져왔습니다!"
L["PRINT_STYLE_SAVED"]       = "스타일 '%s'이(가) 저장되었습니다."
L["PRINT_STYLE_DELETED"]     = "스타일 '%s'이(가) 삭제되었습니다."
L["PRINT_SNIPPET_INVALID"]   = "잘못된 단축 문구 문자열입니다."
L["PRINT_SNIPPET_REMOVED"]   = "단축 문구 '%s'이(가) 삭제되었습니다."
L["PRINT_SNIPPETS_IMPORTED"] = "%d개의 단축 문구를 가져왔습니다."
L["PRINT_SNIPPETS_SKIPPED"]  = " %d개 건너뜀 (이미 존재함)."
L["PRINT_CANT_DELETE_DEFAULT"] = "기본 스타일은 삭제할 수 없습니다."
L["PRINT_SETUP_SKIPPED"]     = "설정을 건너뛰었습니다. |cff55ccff/bcb|r 를 입력하여 언제든지 구성하세요."
L["BTN_RESET_STYLES_CONFIRM"] = "스타일 초기화"

-- SlashCommands popups
L["POPUP_WIPE_WHISPERS"]     = "귓속말 기록을 지울까요? 이 작업은 취소할 수 없습니다."

-- WelcomePanel
L["WELCOME_CHOOSE_STYLE"]      = "스타일 선택:"
L["WELCOME_STYLE_NOTE"]        = "애드온 이름이 표시된 스타일은 해당 애드온이 필요합니다.\n나중에 디자이너 탭에서 모든 것을 완전히 사용자 지정할 수 있습니다."
L["WELCOME_LAYOUT_DESC"]       = "채널 이름과 자동 완성이 입력창에 대해 표시되는 위치를 선택합니다."
L["WELCOME_CHANNEL_POS_LBL"]   = "채널 이름 위치:"
L["WELCOME_AC_POS_LBL"]        = "자동 완성 위치:"
L["WELCOME_AUTOHIDE_HELP"]     = "입력창에 마우스를 올릴 때까지 채널 이름이 사라집니다."
L["WELCOME_CHARCOUNTER_LBL"]   = "글자 수 표시 위치:"
L["WELCOME_FEATURES_DESC"]     = "원하는 기능을 선택합니다. 모든 기능이 기본적으로 활성화됩니다.\n기능 탭에서 언제든지 변경할 수 있습니다."
L["WELCOME_LONGMSG_LBL"]       = "긴 메시지 (255자 초과):"
L["LONGMSG_DESC_OFF"]          = "255자에서 잘림"
L["LONGMSG_DESC_SILENT"]       = "자동 분할"
L["LONGMSG_DESC_NOTICE"]       = "알림과 함께 분할"
L["LONGMSG_DESC_CONFIRM"]      = "분할 전 확인"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "전투 잠금에 대해 더 알아보기"
L["WELCOME_WHY_KEYBIND"]       = "왜 이것이 필요한가요?"
L["WELCOME_CURRENT_KEYBIND"]   = "현재 단축키:"
L["WELCOME_KEYBIND_CLICK_HINT"] = "클릭하여 설정 · 우클릭하여 해제"
L["WELCOME_OPEN_HELP"]         = "도움말 및 팁 창 열기"
L["WELCOME_HELP_DESC"]         = "모든 명령어, 단축키, 기능 세부 정보는 도움말 창에서 확인할 수 있습니다."
L["WELCOME_RELOAD_NOTE"]       = "두 버튼 모두 인터페이스를 다시 로드합니다."
L["WELCOME_COMBAT_PAUSE"]      = "전투 진입 -- 설정이 일시 정지되었습니다."
L["WELCOME_SHIFTCLICK_TITLE"]  = "Shift 클릭 링크 삽입"
L["WELCOME_FEAT_HISTORY"]      = "채팅 기록"
L["WELCOME_FEAT_SNIPPETS"]     = "단축 문구 시스템"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "자동 완성: !단축 문구"
L["WELCOME_FEAT_AC_COMMANDS"]  = "자동 완성: /명령어"
L["WELCOME_FEAT_AC_WHISPER"]   = "자동 완성: 귓속말 이름"
L["WELCOME_FEAT_AC_BNET"]      = "자동 완성: Battle.net 친구"
L["WELCOME_FEAT_KEEP_OPEN"]    = "입력창 열어두기"

-- WelcomePanel navigation
L["BTN_PREVIOUS"]  = "이전"
L["BTN_NEXT"]      = "다음"

-- ── Language selector (Advanced tab) ─────────────────────────────────────────
L["SECTION_LANGUAGE"]        = "언어"
L["LANGUAGE_DESC"]           = "표시 언어를 변경합니다. 인터페이스 다시 로드가 필요합니다."
L["LANGUAGE_CLIENT"]         = "클라이언트 언어"
L["LANGUAGE_RELOAD_MSG"]     = "언어가 변경되었습니다. 인터페이스를 다시 로드합니다..."
L["POPUP_CHANGE_LANGUAGE"]   = "언어를 변경하고 인터페이스를 다시 로드할까요?"
L["BTN_RELOAD_CONFIRM"]      = "다시 로드"
L["LANGUAGE_COMING_SOON"]    = "|cff888888(준비 중)|r"

-- ── Help popup body strings ───────────────────────────────────────────────────
L["HELP_WINDOW_TITLE"] = "BigChatBox 도움말"

L["HELP_BODY_MAIN"] = [[|cffffd100-- 명령어 --|r
|cffffd100/bcb|r 또는 |cffffd100/bcb config|r -- 설정 창 열기.
|cffffd100/bcb edit|r -- 앵커 편집기를 열어 위치를 변경합니다.
|cffffd100/bcb reset|r -- 위치를 기본값으로 초기화합니다.

|cffffd100-- 채팅 기본 --|r
채널 이름을 |cffffd100좌클릭|r하여 채널 전환 (일반, 파티, 길드 등).
채널 이름을 |cffffd100우클릭|r하여 설정, 기록, 지우기 옵션 접근.
|cffffd100Enter|r로 메시지 전송. |cffffd100Escape|r로 지우고 닫기.
입력창에서 |cffffd100마우스 휠|r로 채팅 기록 스크롤.

|cffffd100-- 자동 완성 --|r
|cffffd100/|r를 입력하면 매칭되는 슬래시 명령어 표시 (Tab으로 순환, Enter로 확인).
|cffffd100!|r를 입력하면 단축 문구 트리거 자동 완성 (예: !guild, !inv).
귓속말 이름은 친구, 길드, 그룹, 최근 귓속말에서 자동 완성됩니다.
|cffffd100Tab|r / |cffffd100Shift+Tab|r으로 제안 목록 순환.

|cffffd100-- 단축 문구 --|r
Enter를 누를 때 확장되는 텍스트 단축키를 정의합니다.
예: !guild는 "LFM 쐐기돌+ 초대 귓속말 주세요!"로 확장될 수 있습니다.
각 단축 문구는 특정 채널로 제한할 수 있습니다.
|cff5599ff단축 문구|r 탭에서 관리, 생성, 가져오기, 내보내기를 합니다.

|cffffd100-- 링크 삽입 --|r
아이템, 주문, 업적 등에 |cffffd100Shift+클릭|r하여 링크를 삽입합니다.
가방, 주문서, 업적 패널, 전문 기술, 채팅 출력에서 작동합니다.
입력창의 링크를 |cffffd100마우스 오버|r하면 툴팁을 미리 봅니다.
직접 삽입을 지원하지 않는 패널은 |cff5599ffShift 클릭 정보|r 버튼을 참고하세요.

|cffffd100-- 사용자 지정 --|r
|cff5599ff디자이너|r 탭에서 배경, 테두리, 글꼴, 색상을 사용자 지정합니다.
|cff5599ff배치|r 탭에는 정밀한 위치 조정을 위한 앵커 편집기가 있습니다.
외관을 이름이 있는 스타일로 저장합니다. 스타일 문자열을 내보내고 가져와 공유합니다.
LSM이 설치되어 있으면 LibSharedMedia 텍스처와 글꼴이 지원됩니다.

|cffffd100-- 도구 및 토글 --|r
|cff5599ff기능|r 탭에서 각 기능을 활성화하거나 비활성화합니다:
자동 완성, 단축 문구, 링크 마우스 오버 툴팁, 채팅 기록 등.
|cffffd100열어두기|r 모드는 입력창이 포커스를 잃어도 보이게 유지합니다.

|cffffd100-- 프로필 및 스타일 --|r
설정은 기본적으로 캐릭터별로 저장됩니다.
고급 탭에서 |cffffd100모든 캐릭터에서 사용|r을 활성화하면 전역으로 설정을 공유합니다.
스타일은 시각적 외관(배경, 테두리, 글꼴, 색상)을 저장합니다.
내보내기/가져오기로 친구와 스타일을 공유하거나 캐릭터 간에 이동합니다.

|cffffd100-- 위치 및 크기 --|r
앵커 편집기에서 입력창을 클릭하여 드래그하면 새 위치로 이동합니다.
방향키로 한 번에 1픽셀씩 정밀하게 조정합니다.
Shift+드래그로 입력창을 대칭적으로 크기 조정합니다.
입력창에서 |cffffd100Shift+Alt+클릭|r하면 위치가 중앙으로 초기화됩니다.
앵커 편집기 정보 패널에서 정확한 위치와 크기 값을 설정할 수도 있습니다.

|cffffd100-- 긴 메시지 --|r
255자를 초과하는 메시지는 자동으로 여러 번 전송으로 분할될 수 있습니다.
|cff5599ff기능|r 탭에서 동작을 설정합니다: 꺼짐, 자동, 알림, 또는 확인.
글자 수 표시기가 한도까지 얼마나 남았는지 보여줍니다.

|cffffd100-- 동적 크기 조정 --|r
디자이너 탭에서 |cffffd100동적 높이|r와 |cffffd100동적 너비|r를 활성화합니다.
높이는 글꼴 크기에 맞게 조정되고, 너비는 메시지 길이에 따라 늘어납니다.]]

L["HELP_BODY_SECURE"] = "|cffffd100-- BigChatBox가 전투/쐐기돌 등에서 일시 정지하는 이유 --|r\n\n" ..
    "미드나이트 확장팩(12.0)과 함께 블리자드는 전투 중 애드온이 게임과 상호 작용하는 방식에 큰 변화를 도입했습니다. |cff5599ff애드온 무장 해제|r라 불리는 이 이니셔티브는 애드온이 전투 정보로 할 수 있는 작업을 제한합니다.\n\n" ..
    "|cffffd100무엇이 변경되었나요?|r\n" ..
    "전투 관련 데이터는 이제 |cffff9900\"비밀 값\"|r으로 처리됩니다. 애드온은 이 정보를 표시할 수 있지만 코드에서 읽거나 처리할 수 없습니다.\n\n" ..
    "많은 UI 프레임이 이제 전투 중 |cffff9900보호됩니다|r. 인스턴스 콘텐츠(쐐기돌, 투기장, 등급 전장)에서는 제한이 훨씬 엄격합니다. 이러한 보호된 프레임을 수정하거나 연결하는 애드온은 |cffff6666오염|r을 퍼뜨릴 위험이 있으며, 이는 게임 기능을 완전히 망가뜨릴 수 있습니다. 애드온뿐만 아니라 대상 지정, 주문 시전, 능력 사용과 같은 핵심 기능도 영향을 받습니다.\n\n" ..
    "|cffffd100BigChatBox에 어떤 영향이 있나요?|r\n" ..
    "WoW의 기본 채팅 입력창(ChatFrame1EditBox)은 /target, /cast, /focus 같은 보안 슬래시 명령어를 처리하기 때문에 보호된 프레임입니다. BigChatBox는 채팅 입력을 가로채기 위해 이 프레임에 연결합니다. 전투 및 인스턴스 경쟁 콘텐츠 중에 이러한 연결이 오염을 일으켜 전체 채팅 시스템을 차단할 수 있습니다.\n\n" ..
    "사용자를 보호하기 위해 BigChatBox는 전투 중과 쐐기돌, 투기장, 등급 전장 중에 |cff00ff00자동으로 일시 정지|r합니다. 블리자드의 기본 채팅 입력이 원활하게 대신합니다. 전투가 끝나거나 콘텐츠가 완료되면 BigChatBox가 자동으로 재개됩니다.\n\n" ..
    "|cffffd100왜 수정하지 않나요?|r\n" ..
    "이것은 |cffff0000버그가 아닙니다!|r WoW 보안 모델의 근본적인 제한 사항입니다. 전투 중 보호된 프레임을 수정하는 모든 애드온은 동일한 제한에 직면합니다. 블리자드는 애드온이 전투 결정을 자동화하는 것을 방지하기 위해 이러한 제한을 설계했으며, 채팅 편집창이 그 보호 범위에 해당합니다.\n\n" ..
    "|cffffd100결론|r\n" ..
    "BigChatBox는 전투 중과 시간이 제한된 경쟁 인스턴스(쐐기돌, 투기장, 등급 전장) 중에 일시 정지합니다. 해당 활동 중에도 블리자드 기본 채팅 입력을 사용하여 정상적으로 채팅할 수 있습니다. 전투가 끝나거나 활동이 완료되면 BigChatBox가 자동으로 재개됩니다."

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100-- 왜 모든 Shift 클릭이 작동하지 않나요? --|r\n\n" ..
    "대부분의 Shift 클릭 링크 삽입은 BigChatBox에서 직접 작동합니다. 그러나 일부 게임 패널은 블리자드 자체 채팅 입력창에만 링크를 삽입하는 내부 블리자드 함수를 사용하여 애드온 편집창을 우회합니다.\n\n" ..
    "|cff00ff00BigChatBox에서 작동:|r\n" ..
    "  · 개인 가방의 아이템\n" ..
    "  · 펫 일지의 펫\n" ..
    "  · 전승 패널의 전승 아이템\n" ..
    "  · 상인 패널의 아이템\n" ..
    "  · 우편함의 아이템\n" ..
    "  · 전문 기술 패널의 제작 레시피 및 재료\n" ..
    "  · 채팅 창의 링크\n\n" ..
    "|cffff9900블리자드 채팅이 필요:|r\n" ..
    "  · 업적 패널의 업적\n" ..
    "  · 은행 패널의 아이템\n" ..
    "  · 길드 은행 패널의 아이템\n" ..
    "  · 탈것 일지의 탈것\n" ..
    "  · 특성 패널의 특성\n" ..
    "  · 옷장의 외관\n" ..
    "  · 일부 확장팩 전용 패널\n\n" ..
    "|cffffd100왜인가요?|r\n" ..
    "이러한 패널은 블리자드의 특정 편집창을 확인하는 WoW 내부 |cff5599ffChatEdit_InsertLink|r 함수를 사용합니다. BigChatBox는 이러한 호출의 대부분을 가로채지만, 블리자드의 구현 방식으로 인해 일부 패널은 표준 후킹을 완전히 우회합니다. 이것은 WoW API의 한계이며 버그가 아닙니다.\n\n" ..
    "|cffffd100해결책|r\n" ..
    "|cff5599ff블리자드 채팅 단축키|r (기본값: Ctrl+Enter)를 누르면 즉시 블리자드 기본 채팅 입력으로 전환됩니다. 필요한 것을 입력하거나 Shift 클릭하고, Enter를 눌러 전송하면 다음 메시지부터 BigChatBox가 자동으로 재개됩니다.\n\n" ..
    "이 키를 재지정하거나 해제하려면:\n" ..
    "  · |cffffd100/bcb|r > 고급 탭\n" ..
    "  · Esc > 단축키 > 애드온 > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "%s(으)로 전환하고 설정을 다시 시작할까요?\nBigChatBox가 새 언어를 적용하기 위해 다시 로드됩니다."

-- ── v5.6.1 Emoji & Emoticon picker ───────────────────────────────────────────
L["SECTION_EMOJI"]          = "이모티콘 선택기"
L["CB_SHOW_EMOJI_PICKER"]   = "이모티콘 선택기 버튼 표시"
L["EMOJI_PICKER_TITLE"]     = "이모티콘 선택기"
L["EMOJI_PICKER_TOOLTIP"]   = "클릭하여 이모티콘 선택기 열기"
L["EMOJI_TAB_LAST"]         = "최근 사용"
L["EMOJI_TAB_ASCII"]        = "이모티콘"
L["EMOJI_LAST_EMPTY"]       = "최근 선택 항목이 없습니다."

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "기록 검색..."

L["BTN_SAVE_SNIPPET"]           = "저장"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "기본 스타일 사용"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "선택하면 활성 스타일에 관계없이 다중 줄 상자가 기본 스타일을 사용합니다. 현재 BCB 외관을 사용하려면 선택 해제하세요."

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "다중 줄 입력"
L["CB_ENABLE_MULTILINE"]        = "다중 줄 입력 활성화"
L["CB_ENABLE_MULTILINE_HELP"]   = "여러 줄 메시지를 작성할 수 있는 큰 입력창을 엽니다. 각 줄은 별도로 전송됩니다."
L["KEYBIND_OPEN_MULTILINE"]     = "다중 줄 입력 열기:"
L["MULTILINE_KEYBIND_HELP"]     = "기본값: Shift+Enter. Enter로 새 줄을 추가하고 Shift+Enter로 모든 줄을 전송하는 큰 입력창을 엽니다."
L["BTN_OPEN_KEYBINDINGS"]       = "키 바인딩 열기"
L["MULTILINE_SEND_BTN"]         = "전송"
L["MULTILINE_CHANNEL_LABEL"]    = "채널: %s"
L["MULTILINE_BLOCKED_SECURE"]   = "M+/투기장/평점 BG 중에는 다중 줄 입력을 사용할 수 없습니다."
L["MULTILINE_HINT"]             = "Enter = 새 줄   |   Shift+Enter = 모두 전송"
