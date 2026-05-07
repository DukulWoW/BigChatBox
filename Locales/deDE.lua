-- BigChatBox Localization - German (deDE)
-- Version: 5.6.0
-- Full rewrite for 5.6.0 locale system. Overrides all keys that differ from enUS.
-- Missing keys fall back to enUS automatically.

local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "deDE" and (BigChatBox and BigChatBox._forcedLocale) ~= "deDE" then return end

-- ── Addon identity ────────────────────────────────────────────────────────────
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "Version"
L["LOADED_MSG"]   = "BigChatBox v%s geladen! Tippe /bcb für Optionen."

-- ── Config window tabs ────────────────────────────────────────────────────────
L["TAB_GENERAL"]   = "Allgemein"
L["TAB_DESIGNER"]  = "Designer"
L["TAB_PLACEMENT"] = "Platzierung"
L["TAB_FEATURES"]  = "Funktionen"
L["TAB_SNIPPETS"]  = "Snippets"
L["TAB_HISTORY"]   = "Verlauf"
L["TAB_ADVANCED"]  = "Erweitert"
L["TAB_RESET"]     = "Zurücksetzen"

-- ── Reset tab ─────────────────────────────────────────────────────────────────
L["RESET_TAB_HEADER"]       = "Zurücksetzen & Wiederherstellen"
L["RESET_TAB_DESC"]         = "Diese Aktionen sind dauerhaft und können nicht rückgängig gemacht werden."
L["RESET_ALL_HELP"]         = "Setzt alles zurück: Position, Aussehen, Verlauf und Snippets."
L["RESET_APPEARANCE_HELP"]  = "Setzt nur Hintergrund, Rahmen, Schriften und Farben zurück."
L["RESET_PLACEMENT_HELP"]   = "Setzt Position und Größe auf Standardwerte zurück."
L["RESET_HISTORY_HELP"]     = "Löscht den gesamten gespeicherten Chat- und Flüsterverlauf."
L["RESET_SNIPPETS_HELP"]    = "Entfernt alle Snippets."
L["RESET_STYLES_HELP"]      = "Entfernt alle gespeicherten benutzerdefinierten Stile."
L["RESTART_SETUP_HELP"]     = "Setzt alle Einstellungen zurück und startet den Einrichtungsassistenten neu."

-- ── Shared UI ─────────────────────────────────────────────────────────────────
L["PREVIEW"]        = "Vorschau"
L["TYPE_SOMETHING"] = "Hier etwas eingeben..."
L["CLOSE"]          = "Schließen"
L["ACTIONS"]        = "Aktionen"
L["RESET"]          = "Zurücksetzen"
L["OK"]             = "OK"
L["CANCEL"]         = "Abbrechen"
L["YES"]            = "Ja"
L["NO"]             = "Nein"
L["SAVE"]           = "Speichern"
L["DELETE"]         = "Löschen"
L["EDIT"]           = "Bearbeiten"
L["IMPORT"]         = "Importieren"
L["EXPORT"]         = "Exportieren"
L["DUPLICATE"]      = "Duplizieren"
L["SHARE"]          = "Teilen"
L["ENABLED"]        = "Aktiviert"
L["DISABLED"]       = "Deaktiviert"
L["EXPORT"]         = "Exportieren"
L["IMPORT"]         = "Importieren"
L["STYLES"]         = "Stile"

-- ── General tab ───────────────────────────────────────────────────────────────
L["BTN_VIEW_PATCH_NOTES"]     = "Patch-Notizen anzeigen"
L["BTN_HELP_AND_TIPS"]        = "Hilfe & Tipps"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "Info: Kampfsperre"
L["BTN_SHIFT_CLICK_INFO"]     = "Info: Shift-Klick"

L["CELL_SNIPPETS_HDR"]       = "|cff5599ffSnippets|r"
L["CELL_SNIPPETS_DESC"]      = "Textkürzel, die beim Senden ersetzt werden.\nVerwaltung im Snippets-Tab."
L["CELL_ANCHOR_HDR"]         = "|cff5599ffAnker-Editor|r"
L["CELL_ANCHOR_DESC"]        = "Klicken und ziehen zum Neu-Positionieren.\nPfeil-Tasten für pixelgenaue Ausrichtung."
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ffAutovervollständigung|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "Tab für Befehle, Flüsternamen\nund Snippet-Auslöser (!guild)."
L["CELL_HISTORY_HDR"]        = "|cff5599ffChat-Verlauf|r"
L["CELL_HISTORY_DESC"]       = "Vollständiger Verlauf mit Zeitstempeln.\nScrollen mit dem Mausrad."
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ffAnpassung|r"
L["CELL_CUSTOMIZATION_DESC"] = "Designer-Tab für Hintergründe, Rahmen,\nSchriften, Farben. Stile speichern & teilen."
L["CELL_SECURE_HDR"]         = "|cffff9900Sicherer Inhalt|r"
L["CELL_SECURE_DESC"]        = "Pausiert automatisch in M+, Arenen und\ngewerteten SGs zum Schutz des Chats."
L["CELL_SHARING_HDR"]        = "|cff5599ffTeilen|r"
L["CELL_SHARING_DESC"]       = "Stile und Snippets als kurze Zeichenketten\nexportieren und mit Freunden teilen."
L["CELL_LONGMSG_HDR"]        = "|cff5599ffLange Nachrichten|r"
L["CELL_LONGMSG_DESC"]       = "Nachrichten über 255 Zeichen werden\nautomatisch aufgeteilt."

-- ── Styles (Designer tab) ─────────────────────────────────────────────────────
L["STYLES"]              = "Stile"
L["ACTIVE_STYLE"]        = "Aktiver Stil"
L["BTN_SAVE_STYLE"]      = "Stil speichern"
L["BTN_DELETE_STYLE"]    = "Stil löschen"
L["BTN_EXPORT_STYLE"]    = "Stil exportieren"
L["BTN_IMPORT_STYLE"]    = "Stil importieren"

-- ── Designer tab sections ─────────────────────────────────────────────────────
L["SECTION_SIZE"]         = "Größe"
L["SECTION_BACKGROUND"]   = "Hintergrund"
L["SECTION_BORDER"]       = "Rahmen"
L["SECTION_FONTS"]        = "Schriften"
L["SECTION_TEXT_OPTIONS"] = "Textoptionen"

-- Designer tab slider / dropdown labels
L["LABEL_WIDTH"]              = "Breite"
L["LABEL_HEIGHT"]             = "Höhe"
L["LABEL_SCALE"]              = "Skalierung"
L["LABEL_BG_TEXTURE"]         = "Hintergrundtextur"
L["LABEL_BG_OPACITY"]         = "Hintergrunddeckkraft"
L["LABEL_BG_BRIGHTNESS"]      = "Hintergrundhelligkeit"
L["LABEL_BG_SCALE"]           = "Hintergrundgröße"
L["LABEL_TINT_INTENSITY"]     = "Tönung Intensität"
L["LABEL_BORDER_TEXTURE"]     = "Rahmentextur"
L["LABEL_BORDER_OPACITY"]     = "Rahmendeckkraft"
L["LABEL_BORDER_BRIGHTNESS"]  = "Rahmenhelligkeit"
L["LABEL_BORDER_THICKNESS"]   = "Rahmendicke"
L["LABEL_CHANNEL_FONT"]       = "Kanal-Schrift"
L["LABEL_INPUT_FONT"]         = "Eingabe-Schrift"
L["LABEL_CHANNEL_FONT_SIZE"]  = "Kanal-Schriftgröße"
L["LABEL_INPUT_FONT_SIZE"]    = "Eingabe-Schriftgröße"
L["LABEL_TEXT_ALIGNMENT"]     = "Textausrichtung"
L["LABEL_FONT_OUTLINE"]       = "Schriftumriss"

-- Designer tab checkboxes
L["CB_DYNAMIC_HEIGHT"]   = "Dynamische Höhe"
L["CB_DYNAMIC_WIDTH"]    = "Dynamische Breite"
L["CB_TINT_BG"]          = "Hintergrund mit Kanalfarbe tönen"
L["CB_MATCH_TEXT_COLOR"] = "Textfarbe an Kanal anpassen"

-- ── Placement tab ─────────────────────────────────────────────────────────────
L["SECTION_LAYOUT_OPTIONS"]   = "Layout-Optionen"
L["SECTION_POSITION"]         = "Position"
L["LABEL_CHANNEL_NAME_POS"]   = "Position des Kanalnamens"
L["CB_SHOW_CHANNEL"]           = "Kanalname anzeigen"
L["LABEL_AUTOCOMPLETE_POS"]   = "Position der Autovervollständigung"
L["LABEL_CHAR_COUNTER_POS"]   = "Position des Zeichenzählers"
L["CB_AUTO_HIDE_CHANNEL"]     = "Kanalname automatisch ausblenden (bei Hover anzeigen)"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "Anker-Editor öffnen"

-- ── Features tab ─────────────────────────────────────────────────────────────
L["SECTION_FEATURE_TOGGLES"]  = "Funktions-Schalter"
L["FEATURE_TOGGLES_DESC"]     = "BigChatBox-Funktionen aktivieren oder deaktivieren."
L["SECTION_SNIPPET_SYSTEM"]   = "Snippet-System"
L["SECTION_AUTOCOMPLETE"]     = "Autovervollständigung"
L["SECTION_HISTORY"]          = "Verlauf"
L["SECTION_LINK_HOVER"]       = "Link-Hover"
L["SECTION_LONG_MESSAGES"]    = "Lange Nachrichten"
L["CB_ENABLE_SNIPPETS"]       = "Snippet-System aktivieren"
L["CB_AC_COMMANDS"]           = "Autovervollständigung für Befehle (/dance, /guild, ...)"
L["CB_AC_WHISPER"]            = "Autovervollständigung für Flüsternamen (/w <Name>)"
L["CB_AC_SNIPPETS"]           = "Autovervollständigung für Snippet-Auslöser (!guild, ...)"
L["CB_AC_BNET"]               = "Battle.net-Freunde in der Flüster-Autovervollständigung anzeigen"
L["CB_ENABLE_HISTORY"]        = "Chat-Verlauf aktivieren"
L["CB_MOUSEWHEEL_HISTORY"]    = "Verlauf mit dem Mausrad scrollen"
L["CB_LINK_HOVER"]            = "Tooltips beim Hovern über Links anzeigen"
L["LABEL_MSG_EXCEEDS_255"]    = "Wenn die Nachricht 255 Zeichen überschreitet"

-- ── Snippets tab ──────────────────────────────────────────────────────────────
L["SNIPPETS_DISABLED_MSG"]    = "Das Snippet-System ist deaktiviert.\nAktiviere es im Funktionen-Tab."
L["SNIPPETS_HEADER"]          = "Snippets"
L["SNIPPETS_DESC"]            = "Tippe einen Snippet-Auslöser (z.B. !guild) im Chat und drücke Enter zum Senden."
L["SNIPPET_EDIT_HEADER"]      = "Bearbeiten"
L["SNIPPET_ACTIVE"]           = "Snippet aktiv"
L["SNIPPET_TRIGGER_LBL"]      = "Auslöser:"
L["SNIPPET_TEXT_LBL"]         = "Text:"
L["SNIPPET_CHANNEL_LBL"]      = "Posten in:"
L["SNIPPET_GLOBAL"]           = "Für alle Charaktere verfügbar"
L["SNIPPET_EMPTY_LIST"]       = "Noch keine Snippets.\nKlicke auf Neues Snippet oder\nImportieren um zu beginnen."
L["BTN_NEW_SNIPPET"]          = "Neues Snippet"
L["BTN_EXPORT_ALL"]           = "Alle exportieren"
L["BTN_SHARE_SNIPPET"]        = "Teilen"
L["BTN_DUPLICATE_SNIPPET"]    = "Duplizieren"
L["BTN_DELETE_SNIPPET"]       = "Löschen"
L["BTN_IMPORT_SNIPPET"]       = "Importieren"

-- ── History tab ───────────────────────────────────────────────────────────────
L["HISTORY_HEADER"]           = "Chat-Verlauf"
L["HISTORY_HELP"]             = "Klicke auf Text zum Wiederverwenden. Hover für Zeitstempel. Klicke X zum Markieren."
L["HISTORY_EMPTY"]            = "Noch kein Verlauf."
L["HISTORY_MORE"]             = "... und %d weitere"
L["WHISPERS_HEADER"]          = "Letzte Flüsternachrichten"
L["WHISPERS_CLICK_HINT"]      = "(klicken zum Flüstern)"
L["WHISPERS_EMPTY"]           = "Kein Flüsterverlauf."
L["BTN_WIPE_HISTORY"]         = "Gesamten Verlauf löschen"
L["BTN_WIPE_COMMANDS"]        = "Alle /Befehle löschen"
L["BTN_REMOVE_ENTRIES"]       = "Einträge entfernen"

-- ── Advanced tab ──────────────────────────────────────────────────────────────
L["SECTION_PROFILES"]         = "Profile"
L["PROFILES_DESC"]            = "Einstellungen werden pro Charakter gespeichert. Aktivieren, um sie für alle Charaktere zu teilen."
L["CB_GLOBAL_PROFILE"]        = "Für alle Charaktere verwenden"
L["BEHAVIOR"]                 = "Verhalten"
L["KEEP_OPEN"]                = "Eingabefeld offen lassen bis Escape"
L["KEEP_OPEN_HELP"]           = "Wenn aktiviert, bleibt das Eingabefeld sichtbar, wenn du woanders klickst. Drücke Escape zum Schließen."
L["SHOW_LOCKDOWN_WARNING"]    = "Warnung bei gesichertem Inhalt anzeigen"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "Zeigt eine Chat-Meldung an, wenn BCB während M+-Schlüsselsteinen, Arenen und gewerteten Schlachtfeldern pausiert."
L["IGNORE_COMMANDS_HISTORY"]  = "/Befehle nicht im Verlauf speichern"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "Befehle wie /target und /cast werden nicht im Chat-Verlauf gespeichert."
L["SHOW_MINIMAP_BUTTON"]      = "Minimap-Schaltfläche anzeigen"
L["SHOW_MINIMAP_BUTTON_HELP"] = "Linksklick öffnet die Einstellungen, Rechtsklick öffnet die Schnelleinstellungen. Die Addon-Compartment-Schaltfläche ist immer verfügbar."
L["HIDE_LOGIN_MSG"]           = "Login-Meldung ausblenden"
L["HIDE_LOGIN_MSG_HELP"]      = "Blendet die \"BigChatBox geladen\"-Meldung beim Login aus."
L["KEYBIND_OPEN_BLIZZARD"]    = "Blizzard-Chat öffnen:"
L["KEYBIND_NOT_BOUND"]        = "Nicht belegt"
L["KEYBIND_PRESS_KEY"]        = "Taste drücken..."
L["KEYBIND_CONFLICT"]         = "%s ist bereits mit %s belegt. Überschreiben?"
L["KEYBIND_TOOLTIP_BOUND"]    = "Blizzard-Chat öffnen (%s)"
L["KEYBIND_TOOLTIP_UNBIND"]   = "Rechtsklick zum Entfernen"
L["KEYBIND_TOOLTIP_SET"]      = "Klicken zum Belegen"
L["KEYBIND_HELP"]             = "Öffnet Blizzards nativen Chat für Shift-Klick auf Reittiere, Erfolge, Spielzeuge und Talente. Standard: Strg+Enter."
L["RESET_ALL"]                = "Alle Einstellungen zurücksetzen"
L["RESET_APPEARANCE"]         = "Aussehen zurücksetzen"
L["RESET_PLACEMENT"]          = "Platzierung zurücksetzen"
L["RESET_HISTORY_BTN"]        = "Verlauf zurücksetzen"
L["RESET_SNIPPETS_BTN"]       = "Snippets zurücksetzen"
L["RESET_STYLES_BTN"]         = "Stile zurücksetzen"
L["RESTART_SETUP"]            = "Einrichtung neu starten"

-- ── Reset / action confirmations (StaticPopupDialogs) ────────────────────────
L["POPUP_RESET_ALL"]          = "ALLE BigChatBox-Einstellungen auf Standard zurücksetzen?\nDies umfasst Position, Größe, Aussehen und Schriften."
L["POPUP_RESET_APPEARANCE"]   = "Aussehen auf Standard zurücksetzen?\nBeeinflusst NICHT Position oder Verlauf."
L["POPUP_RESET_PLACEMENT"]    = "Platzierung auf Standard zurücksetzen?\nDie Benutzeroberfläche wird neu geladen."
L["POPUP_RESET_HISTORY"]      = "Gesamten Chat- und Flüsterverlauf zurücksetzen?\nVerlaufslänge wird auf 100 gesetzt.\nDie Benutzeroberfläche wird neu geladen."
L["POPUP_RESET_SNIPPETS"]     = "Alle Snippets entfernen? Die Benutzeroberfläche wird neu geladen."
L["POPUP_RESET_STYLES"]       = "ALLE benutzerdefinierten Stile entfernen?\nDer Standard-Stil bleibt erhalten und wird aktiv.\nDie Benutzeroberfläche wird neu geladen."
L["POPUP_WIPE_HISTORY"]       = "Gesamten Chat-Verlauf löschen?\nDie Benutzeroberfläche wird ebenfalls neu geladen."
L["POPUP_WIPE_COMMANDS"]      = "Alle /Befehle aus dem Chat-Verlauf entfernen?\nReguläre Nachrichten bleiben erhalten.\nDie Benutzeroberfläche wird ebenfalls neu geladen."
L["POPUP_DELETE_STYLE"]       = "Aktuellen Stil löschen?"
L["POPUP_OVERWRITE_STYLE"]    = "Ein Stil namens '%s' existiert bereits. Überschreiben?"
L["POPUP_SAVE_STYLE_TEXT"]    = "Einen Namen für diesen Stil eingeben:"
L["POPUP_EXPORT_STYLE_TEXT"]  = "Stil-Zeichenkette unten kopieren:"
L["POPUP_IMPORT_STYLE_TEXT"]  = "Stil-Zeichenkette unten einfügen:"
L["POPUP_NAME_IMPORT_STYLE"]  = "Importierten Stil speichern als:"
L["POPUP_DELETE_SNIPPET"]     = "Snippet '%s' löschen?"
L["POPUP_SHARE_SNIPPET_TEXT"] = "Snippet-Zeichenkette kopieren (Strg+C):"
L["POPUP_IMPORT_SNIPPET_TEXT"] = "Snippet-Zeichenkette einfügen (Strg+V):"
L["POPUP_RESTART_SETUP"]      = "Dies setzt ALLE Einstellungen zurück und startet den Einrichtungsassistenten neu.\nBist du sicher?"
L["POPUP_QUIT_SETUP"]         = "Einrichtung wirklich beenden?\nStandardeinstellungen werden verwendet."
L["BTN_RESET_ALL_CONFIRM"]    = "Alles zurücksetzen"
L["BTN_WIPE_CONFIRM"]         = "Ja, löschen"
L["BTN_DELETE_CONFIRM"]       = "Löschen"
L["BTN_OVERWRITE_CONFIRM"]    = "Überschreiben"
L["BTN_SKIP"]                 = "Überspringen"
L["BTN_RESTART_SETUP_CONFIRM"] = "Einrichtung neu starten"
L["BTN_QUIT_SETUP_CONFIRM"]   = "Einrichtung beenden"
L["BTN_SAVE_CLOSE"]           = "Schließen"

-- ── Slash commands / print messages ──────────────────────────────────────────
L["SLASH_POSITION_RESET"]     = "Position auf Standard zurückgesetzt"
L["SLASH_ANCHOR_UNAVAILABLE"] = "Anker-Editor nicht verfügbar."
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox:|r Chat-Verlauf gelöscht."
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox:|r Aussehen auf Standard zurückgesetzt"
L["RESET_DONE"]               = "Alle Einstellungen auf Standard zurückgesetzt."
L["COMBAT_CLOSE"]             = "Einstellungen geschlossen – Kampfmodus aktiv."
L["COMBAT_BLOCKED"]           = "Einstellungen können im Kampf nicht geöffnet werden."

-- ── Position / size labels (legacy keys kept for compat) ─────────────────────
L["POSITION"]       = "Position"
L["X_POSITION"]     = "X-Position"
L["Y_POSITION"]     = "Y-Position"
L["SIZE"]           = "Größe"
L["WIDTH"]          = "Breite"
L["HEIGHT"]         = "Höhe"
L["SCALE"]          = "Skalierung"
L["FONT_SIZES"]     = "Schriftgrößen"
L["INPUT_FONT_SIZE"]  = "Eingabe-Schriftgröße"
L["CHANNEL_FONT_SIZE"] = "Kanal-Schriftgröße"
L["FONTS"]          = "Schriften"
L["INPUT_FONT"]     = "Eingabe-Schrift"
L["CHANNEL_FONT"]   = "Kanal-Schrift"
L["BACKGROUND"]     = "Hintergrund"
L["BG_TEXTURE"]     = "Hintergrundtextur"
L["BG_TRANSPARENCY"] = "Hintergrunddeckkraft"
L["BG_BRIGHTNESS"]  = "Hintergrundhelligkeit"
L["BG_SCALE"]       = "Hintergrundgröße"
L["BORDER"]         = "Rahmen"
L["BORDER_TEXTURE"] = "Rahmentextur"
L["BORDER_TRANSPARENCY"] = "Rahmendeckkraft"
L["BORDER_BRIGHTNESS"]   = "Rahmenhelligkeit"
L["BORDER_THICKNESS"]    = "Rahmendicke"
L["TEXT_OPTIONS"]   = "Textoptionen"
L["MATCH_TEXT_COLOR"] = "Textfarbe an Kanal anpassen"
L["SHOW_OUTLINE"]   = "Textumriss anzeigen"
L["SHOW_SHADOW"]    = "Textschatten anzeigen"
L["DROP_SHADOW"]    = "Schatten auf dem Eingabefeld"
L["TEXT_ALIGN"]     = "Textausrichtung"
L["CHAT_HISTORY"]   = "Chat-Verlauf"
L["HISTORY_LENGTH"] = "Verlaufslänge"
L["WIPE_HISTORY"]   = "Gesamten Verlauf löschen"
L["RECENT_WHISPERS"] = "Letzte Flüsternachrichten"
L["SNIPPETS"]       = "Snippets"
L["SNIPPET_TRIGGER"] = "Auslöser"
L["SNIPPET_TEXT"]   = "Text"
L["SNIPPET_SAVE"]   = "Speichern"
L["SNIPPET_DELETE"] = "Löschen"
L["SNIPPET_NEW"]    = "Neues Snippet"
L["SNIPPET_SHARE"]  = "Snippet teilen"
L["SNIPPET_EXPORT"] = "Alle exportieren"
L["SNIPPET_IMPORT"] = "Importieren"
L["SNIPPET_RESET"]  = "Snippets zurücksetzen"
L["AUTOCOMPLETE"]   = "Autovervollständigung"
L["AUTOCOMPLETE_POS"] = "Position der Autovervollständigung"
L["CHANNEL_POS"]    = "Position des Kanalnamens"
L["AUTO_HIDE_CHANNEL"] = "Kanalname automatisch ausblenden (bei Hover anzeigen)"
L["LAYOUT_OPTIONS"] = "Layout-Optionen"
L["ANCHOR_EDITOR"]  = "Anker-Editor"
L["OPEN_ANCHOR_EDITOR"] = "Anker-Editor öffnen"
L["ABOUT"]          = "Über"
L["ABOUT_DESC"]     = "Ein großes, anpassbares Chat-Eingabefeld mit Kanalanzeige, Anker-Editor und vollständiger Designkontrolle."
L["PROFILES"]       = "Profile"
L["SAVE_STYLE"]     = "Stil speichern"
L["DELETE_STYLE"]   = "Stil löschen"
L["DYNAMIC_HEIGHT"] = "Dynamische Höhe"
L["DYNAMIC_WIDTH"]  = "Dynamische Breite"
L["CHAR_COUNTER_POS"] = "Position des Zeichenzählers"
L["LONG_MESSAGES"]  = "Lange Nachrichten"
L["LONG_MSG_OFF"]   = "Aus"
L["LONG_MSG_SILENT"] = "Still"
L["LONG_MSG_NOTICE"] = "Hinweis"
L["LONG_MSG_CONFIRM"] = "Bestätigen"
L["LONG_MSG_DESC_OFF"]     = "Nachricht wird bei 255 Zeichen abgeschnitten (Standard-WoW-Verhalten)."
L["LONG_MSG_DESC_SILENT"]  = "Wird automatisch in mehrere Nachrichten aufgeteilt."
L["LONG_MSG_DESC_NOTICE"]  = "Teilt auf und zeigt an, wie viele Teile gesendet wurden."
L["LONG_MSG_DESC_CONFIRM"] = "Fragt vor dem Aufteilen nach einer Bestätigung."
L["IMPORT_STYLE_BTN"]  = "Stil-Zeichenkette importieren"
L["FINISH_CONFIG_BTN"] = "Fertig + Einstellungen"
L["BG_COLOR"]          = "Hintergrundfarbe"
L["MSG_SPLIT_NOTICE"]  = "Nachricht in %d Teile aufgeteilt (%d Zeichen)."

-- ── v5.3.3 Keybinding strings ─────────────────────────────────────────────────
L["HELP_KEYBINDINGS_TITLE"] = "— Tastenbelegungen —"
L["HELP_KEYBINDINGS_TEXT"]  = "Strg+Enter wechselt zu Blizzards Standard-Chat (überall verfügbar).\nNützlich für Shift-Klick auf Gegenstände, die nicht in BCB eingefügt werden\n(Reittiere, Erfolge, Spielzeugkiste, Talente, Zauberbuch). Im Blizzard-Feld\ntexten, dann Enter zum Senden. BCB wird beim nächsten Enter-Druck fortgesetzt.\n\nDu kannst dies im Erweitert-Tab oder unter\nEsc > Tastenbelegungen > AddOns > BigChatBox ändern."

-- ── v5.5.0 Welcome Panel ─────────────────────────────────────────────────────
L["WELCOME_TITLE"]          = "Willkommen bei BigChatBox!"
L["WELCOME_SUBTITLE"]       = "Ersteinrichtung"
L["WELCOME_TEXT"]           = "BigChatBox ersetzt WoWs kleines Chat-Eingabefeld durch ein großes, vollständig anpassbares Eingabefeld.\n\nDu kannst Größe, Hintergrund, Rahmen, Schriften und Farben anpassen – oder einen fertigen Stil auswählen. Funktionen wie Chat-Verlauf, Text-Snippets und smarte Autovervollständigung sind eingebaut und können ein- oder ausgeschaltet werden.\n\nDiese kurze Einrichtung bringt dich in weniger als einer Minute zum Start."
L["WELCOME_SETUP_BTN"]      = "BigChatBox einrichten"
L["WELCOME_LANG_LBL"]       = "Anzeigesprache:"
L["WELCOME_STYLE_TITLE"]    = "Wähle deinen Stil!"
L["WELCOME_LAYOUT_TITLE"]   = "Layout auswählen"
L["WELCOME_FEATURES_TITLE"] = "Wähle deine Funktionen!"
L["WELCOME_ADVANCED_TITLE"] = "Erweiterte Funktionen"
L["WELCOME_FINAL_TITLE"]    = "Fast fertig!"
L["WELCOME_FINISH_BTN"]     = "Fertig!"
L["WELCOME_QUIT_CONFIRM"]   = "Einrichtung wirklich beenden? Standardeinstellungen werden verwendet."
L["WELCOME_KEYBIND_INFO"]   = "Die meisten Shift-Klick-Link-Einfügungen funktionieren direkt in BigChatBox. Für die wenigen, die es nicht tun (wie Reittiere, Spielzeuge und Talente), wechselt diese Tastenbelegung zu Blizzards Chat-Eingabe."
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBox pausiert automatisch während Kampf, M+-Schlüsselsteinen, Arenen und gewerteten Schlachtfeldern, um deinen Chat zu schützen."
L["WELCOME_THANKS"]         = "Danke, dass du BigChatBox verwendest!"
L["WELCOME_SECURE_TITLE"]   = "Sicherer Inhalt"
L["WELCOME_KEYBIND_TITLE"]  = "Blizzard-Chat Tastenbelegung"
L["WELCOME_CONFIG_HINT"]    = "Tippe /bcb, um das vollständige Einstellungsfenster jederzeit zu öffnen."
L["FEATURE_HISTORY_DESC"]   = "Speichert gesendete Nachrichten mit Zeitstempeln."
L["FEATURE_SNIPPETS_DESC"]  = "Textkürzel, die sich beim Drücken von Enter entfalten."
L["FEATURE_AC_SNIPPETS_DESC"]  = "Autovervollständigung für Snippet-Auslöser beginnend mit !"
L["FEATURE_AC_COMMANDS_DESC"]  = "Autovervollständigung für Befehle wie /dance, /guild."
L["FEATURE_AC_WHISPERS_DESC"]  = "Autovervollständigung für Spielernamen beim Flüstern."
L["FEATURE_MOUSEWHEEL_DESC"]   = "Durch vorherige Nachrichten mit dem Mausrad scrollen."
L["FEATURE_GLOBAL_PROFILE_DESC"] = "Einstellungen für alle Charaktere auf diesem Account teilen."
L["FEATURE_KEEP_OPEN_DESC"]    = "Eingabefeld bleibt sichtbar, wenn du woanders klickst."
L["RESTART_SETUP_CONFIRM"]  = "Dies setzt ALLE Einstellungen zurück und startet den Einrichtungsassistenten neu. Bist du sicher?"

-- ── v5.6.0 Patch notes UI ────────────────────────────────────────────────────
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox — Was ist neu"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox — Patch-Notizen"
L["PATCHNOTES_DONT_SHOW"]      = "Nicht mehr anzeigen"
L["PATCHNOTES_GOT_IT"]         = "Verstanden!"
L["PATCHNOTES_PREVIOUS"]       = "— Frühere Updates —"

-- ── Keys added during source wiring (v5.6.0 localization pass) ───────────────

-- Features tab
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffffAus|r — Nachricht wird bei 255 Zeichen abgeschnitten (Standard-WoW-Verhalten).\n|cffffffffStill|r — Wird automatisch in mehrere Nachrichten aufgeteilt.\n|cffffffffHinweis|r — Teilt auf und zeigt an, wie viele Teile gesendet wurden.\n|cffffffffBestätigen|r — Fragt vor dem Aufteilen nach einer Bestätigung."

-- Snippets tab
L["SNIPPET_NOTHING_TO_EXPORT"] = "Keine Snippets zum Exportieren."

-- History tab
L["HISTORY_LENGTH_LABEL"] = "Verlaufslänge"

-- ConfigMain print messages
L["PRINT_RESET_ALL"]         = "Alle Einstellungen zurückgesetzt. Neu laden..."
L["PRINT_RESET_APPEARANCE"]  = "Aussehen zurückgesetzt. Neu laden..."
L["PRINT_RESET_PLACEMENT"]   = "Platzierung zurückgesetzt. Neu laden..."
L["PRINT_RESET_HISTORY"]     = "Verlauf zurückgesetzt. Neu laden..."
L["PRINT_SNIPPETS_REMOVED"]  = "Alle Snippets entfernt."
L["PRINT_STYLES_REMOVED"]    = "Alle benutzerdefinierten Stile entfernt."
L["PRINT_NO_STYLE_STRING"]   = "Keine Stil-Zeichenkette angegeben."
L["PRINT_STYLE_DECODE_FAIL"] = "Dekodierung der Stil-Zeichenkette fehlgeschlagen. Sie ist möglicherweise beschädigt."
L["PRINT_STYLE_INVALID"]     = "Ungültige Stil-Zeichenkette. Präfix !BCB1: oder BCB: erwartet."
L["PRINT_STYLE_IMPORTED"]    = "Stil importiert!"
L["PRINT_STYLE_SAVED"]       = "Stil '%s' gespeichert."
L["PRINT_STYLE_DELETED"]     = "Stil '%s' gelöscht."
L["PRINT_SNIPPET_INVALID"]   = "Ungültige Snippet-Zeichenkette."
L["PRINT_SNIPPET_REMOVED"]   = "Snippet '%s' entfernt."
L["PRINT_SNIPPETS_IMPORTED"] = "%d Snippet(s) importiert."
L["PRINT_SNIPPETS_SKIPPED"]  = " %d übersprungen (bereits vorhanden)."
L["PRINT_CANT_DELETE_DEFAULT"] = "Der Standard-Stil kann nicht gelöscht werden."
L["PRINT_SETUP_SKIPPED"]     = "Einrichtung übersprungen. Tippe jederzeit |cff55ccff/bcb|r zum Konfigurieren."
L["BTN_RESET_STYLES_CONFIRM"] = "Stile zurücksetzen"

-- SlashCommands popups
L["POPUP_WIPE_WHISPERS"]     = "Flüsterverlauf löschen? Dies kann nicht rückgängig gemacht werden."

-- WelcomePanel
L["WELCOME_CHOOSE_STYLE"]      = "Stil auswählen:"
L["WELCOME_STYLE_NOTE"]        = "Mit Addon-Namen markierte Stile erfordern diese Addons.\nAlles kann später im Designer-Tab vollständig angepasst werden."
L["WELCOME_LAYOUT_DESC"]       = "Wähle, wo Kanalname und Autovervollständigung relativ zum Eingabefeld erscheinen."
L["WELCOME_CHANNEL_POS_LBL"]   = "Position des Kanalnamens:"
L["WELCOME_AC_POS_LBL"]        = "Position der Autovervollständigung:"
L["WELCOME_AUTOHIDE_HELP"]     = "Der Kanalname wird ausgeblendet, bis du über das Eingabefeld hoverst."
L["WELCOME_CHARCOUNTER_LBL"]   = "Position des Zeichenzählers:"
L["WELCOME_FEATURES_DESC"]     = "Wähle die gewünschten Funktionen aus. Alle sind standardmäßig aktiviert.\nDu kannst diese jederzeit im Funktionen-Tab ändern."
L["WELCOME_LONGMSG_LBL"]       = "Lange Nachrichten (über 255 Zeichen):"
L["LONGMSG_DESC_OFF"]          = "Bei 255 Zeichen abschneiden"
L["LONGMSG_DESC_SILENT"]       = "Automatisch aufteilen"
L["LONGMSG_DESC_NOTICE"]       = "Aufteilen mit Chat-Hinweis"
L["LONGMSG_DESC_CONFIRM"]      = "Vor dem Aufteilen fragen"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "Mehr über Kampfsperren erfahren"
L["WELCOME_WHY_KEYBIND"]       = "Warum gibt es das?"
L["WELCOME_CURRENT_KEYBIND"]   = "Aktuelle Tastenbelegung:"
L["WELCOME_KEYBIND_CLICK_HINT"] = "Klicken zum Belegen · Rechtsklick zum Entfernen"
L["WELCOME_OPEN_HELP"]         = "Hilfe & Tipps öffnen"
L["WELCOME_HELP_DESC"]         = "Alle Befehle, Tastenkürzel und Funktionsdetails sind im Hilfefenster verfügbar."
L["WELCOME_RELOAD_NOTE"]       = "Beide Schaltflächen laden die Benutzeroberfläche neu."
L["WELCOME_COMBAT_PAUSE"]      = "Einrichtung pausiert – Kampfmodus aktiv."
L["WELCOME_SHIFTCLICK_TITLE"]  = "Shift-Klick-Link-Einfügung"
L["WELCOME_FEAT_HISTORY"]      = "Chat-Verlauf"
L["WELCOME_FEAT_SNIPPETS"]     = "Snippet-System"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "Autovervollständigung: !Snippets"
L["WELCOME_FEAT_AC_COMMANDS"]  = "Autovervollständigung: /Befehle"
L["WELCOME_FEAT_AC_WHISPER"]   = "Autovervollständigung: Flüsternamen"
L["WELCOME_FEAT_AC_BNET"]      = "Autovervollständigung: Battle.net-Freunde"
L["WELCOME_FEAT_KEEP_OPEN"]    = "Eingabefeld offen lassen"

-- WelcomePanel navigation
L["BTN_PREVIOUS"]  = "Zurück"
L["BTN_NEXT"]      = "Weiter"

-- ── Language selector (Advanced tab) ─────────────────────────────────────────
L["SECTION_LANGUAGE"]        = "Sprache"
L["LANGUAGE_DESC"]           = "Anzeigesprache überschreiben. Erfordert einen Neustart der Benutzeroberfläche."
L["LANGUAGE_CLIENT"]         = "Client-Sprache"
L["LANGUAGE_RELOAD_MSG"]     = "Sprache geändert. Benutzeroberfläche wird neu geladen..."
L["POPUP_CHANGE_LANGUAGE"]   = "Sprache ändern und die Benutzeroberfläche neu laden?"
L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "Zu %s wechseln und Einrichtung neu starten?\nBigChatBox wird neu geladen, um die neue Sprache anzuwenden."
L["BTN_RELOAD_CONFIRM"]      = "Neu laden"
L["LANGUAGE_COMING_SOON"]    = "|cff888888(Demnächst verfügbar)|r"

-- ── Help popup body strings (v5.6.0+) ────────────────────────────────────────
L["HELP_WINDOW_TITLE"] = "BigChatBox-Hilfe"

L["HELP_BODY_MAIN"] = [[|cffffd100— Befehle —|r
|cffffd100/bcb|r oder |cffffd100/bcb config|r — Einstellungsfenster öffnen.
|cffffd100/bcb edit|r — Anker-Editor öffnen, um neu zu positionieren.
|cffffd100/bcb reset|r — Position auf Standard zurücksetzen.

|cffffd100— Chat-Grundlagen —|r
|cffffd100Linksklick|r auf den Kanalnamen, um Kanäle zu wechseln (Sagen, Gruppe, Gilde usw.).
|cffffd100Rechtsklick|r auf den Kanalnamen für Einstellungen, Verlauf und Löschoptionen.
|cffffd100Enter|r sendet die Nachricht. |cffffd100Escape|r leert und schließt das Feld.
|cffffd100Mausrad|r im Eingabefeld scrollt durch den Chat-Verlauf.

|cffffd100— Autovervollständigung —|r
|cffffd100/|r eingeben, um passende Befehle zu sehen (Tab zum Wechseln, Enter zum Bestätigen).
|cffffd100!|r eingeben, um Snippet-Auslöser zu vervollständigen (z.B. !guild, !einladen).
Flüsternamen werden aus Freunden, Gilde, Gruppe und letzten Flüsternachrichten ergänzt.
|cffffd100Tab|r / |cffffd100Shift+Tab|r zum Durchblättern der Vorschläge.

|cffffd100— Snippets —|r
Textkürzel definieren, die sich beim Drücken von Enter entfalten.
Beispiel: !guild könnte zu „LFG Mythic+ — Flüstern für Einladung!" werden.
Jedes Snippet kann auf bestimmte Kanäle beschränkt werden.
Snippets verwalten, erstellen, importieren und exportieren im |cff5599ffSnippets|r-Tab.

|cffffd100— Link-Einfügung —|r
|cffffd100Shift+Klick|r auf Gegenstände, Zauber, Erfolge und mehr, um Links einzufügen.
Funktioniert aus Taschen, Zauberbuch, Erfolge, Berufe und Chat-Ausgabe.
|cffffd100Hover|r über Links im Eingabefeld für Tooltip-Vorschauen.
Für Panels ohne direkte Einfügung siehe den |cff5599ffShift-Klick-Info|r-Knopf.

|cffffd100— Anpassung —|r
Der |cff5599ffDesigner|r-Tab ermöglicht die Anpassung von Hintergrund, Rahmen, Schriften und Farben.
Der |cff5599ffPlatzierung|r-Tab enthält den Anker-Editor zur präzisen Positionierung.
Aussehen als benannten Stil speichern. Stile als Zeichenketten exportieren und importieren.
LibSharedMedia-Texturen und Schriften werden unterstützt, wenn LSM installiert ist.

|cffffd100— Werkzeuge & Schalter —|r
Der |cff5599ffFunktionen|r-Tab ermöglicht das Aktivieren oder Deaktivieren einzelner Funktionen:
Autovervollständigung, Snippets, Link-Hover-Tooltips, Chat-Verlauf und mehr.
Der |cffffd100Offen-bleiben|r-Modus hält das Eingabefeld sichtbar, auch wenn es den Fokus verliert.

|cffffd100— Profile & Stile —|r
Einstellungen werden standardmäßig pro Charakter gespeichert.
|cffffd100Für alle Charaktere verwenden|r unter Erweitert aktivieren, um Einstellungen global zu teilen.
Stile speichern das visuelle Aussehen (Hintergrund, Rahmen, Schriften, Farben).
Export/Import nutzen, um Stile mit Freunden oder zwischen Charakteren zu teilen.

|cffffd100— Position & Größe —|r
Der Anker-Editor ermöglicht das Klicken und Ziehen des Felds an eine neue Position.
Pfeiltasten verschieben um 1 Pixel für Präzision.
Shift+Ziehen ändert die Größe symmetrisch.
|cffffd100Shift+Alt+Klick|r auf das Feld setzt die Position auf Mitte zurück.
Genaue Position und Größenwerte können auch im Infopanel des Anker-Editors gesetzt werden.

|cffffd100— Lange Nachrichten —|r
Nachrichten über 255 Zeichen können automatisch in mehrere Sendungen aufgeteilt werden.
Das Verhalten im |cff5599ffFunktionen|r-Tab konfigurieren: Aus, Still, Hinweis oder Bestätigen.
Ein Zeichenzähler zeigt an, wie nah man am Limit ist.

|cffffd100— Dynamische Größe —|r
|cffffd100Dynamische Höhe|r und |cffffd100Dynamische Breite|r im Designer-Tab aktivieren.
Die Höhe passt sich der Schriftgröße an, die Breite wächst mit der Nachrichtenlänge.]]

L["HELP_BODY_SECURE"] = "|cffffd100— Warum pausiert BigChatBox während Kampf / M+ usw.? —|r\n\n" ..
    "Mit der Midnight-Erweiterung (12.0) hat Blizzard grundlegende Änderungen eingeführt, wie Addons während des Kampfes mit dem Spiel interagieren. Diese Initiative, |cff5599ffAddon-Entwaffnung|r genannt, begrenzt, was Addons mit Kampfinformationen tun können.\n\n" ..
    "|cffffd100Was hat sich geändert?|r\n" ..
    "Kampfbezogene Daten werden jetzt als |cffff9900\"Geheimwerte\"|r behandelt. Addons können diese Informationen anzeigen, aber nicht in ihrem Code lesen oder verarbeiten.\n\n" ..
    "Viele UI-Rahmen sind jetzt |cffff9900geschützt|r während des Kampfes. In Instanzinhalten (M+-Schlüsselsteine, Arenen, gewertete Schlachtfelder) sind die Einschränkungen noch strenger. Jedes Addon, das diese geschützten Rahmen modifiziert oder sich einklinkt, riskiert die Verbreitung von |cffff6666Taint|r, was die Spielfunktionalität komplett unterbrechen kann.\n\n" ..
    "|cffffd100Wie betrifft das BigChatBox?|r\n" ..
    "WoWs Standard-Chat-Eingabe (ChatFrame1EditBox) ist ein geschützter Rahmen, weil er sichere Slash-Befehle wie /target, /cast und /focus verarbeitet. BigChatBox klinkt sich in diesen Rahmen ein, um Chat-Eingaben abzufangen. Während Kampf und Instanzinhalten kann dies Taint verursachen.\n\n" ..
    "Zum Schutz |cff00ff00pausiert BigChatBox automatisch|r während Kampf und während M+-Schlüsselsteinen, Arenen und gewerteten Schlachtfeldern. Blizzards Standard-Chat-Eingabe übernimmt nahtlos. Wenn der Kampf endet oder der Inhalt abgeschlossen ist, wird BigChatBox automatisch fortgesetzt.\n\n" ..
    "|cffffd100Warum kann man es nicht einfach beheben?|r\n" ..
    "Dies ist kein |cffff0000Fehler!|r Es ist eine grundlegende Einschränkung in WoWs Sicherheitsmodell. Jedes Addon, das geschützte Rahmen während des Kampfes modifiziert, hat dieselbe Einschränkung. Blizzard hat diese Einschränkungen eingeführt, um zu verhindern, dass Addons Kampfentscheidungen automatisieren.\n\n" ..
    "|cffffd100Das Wesentliche|r\n" ..
    "BigChatBox pausiert während Kampf und während zeitgesteuerten Wettbewerbsinstanzen (M+, Arenen, gewertete SGs). Du kannst während dieser Aktivitäten weiterhin normal chatten, indem du Blizzards eingebaute Chat-Eingabe verwendest. BigChatBox wird automatisch fortgesetzt, wenn der Kampf endet oder die Aktivität abgeschlossen ist."

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100— Warum funktionieren nicht alle Shift-Klicks? —|r\n\n" ..
    "Die meisten Shift-Klick-Link-Einfügungen funktionieren direkt in BigChatBox. Einige Spielpanels verwenden jedoch interne Blizzard-Funktionen, die Links nur in Blizzards eigene Chat-Eingabe einfügen.\n\n" ..
    "|cff00ff00Funktioniert in BigChatBox:|r\n" ..
    "  · Gegenstände aus persönlichen Taschen\n" ..
    "  · Haustiere aus dem Haustier-Journal\n" ..
    "  · Erbstücke aus dem Erbstück-Panel\n" ..
    "  · Gegenstände von Händlerpanels\n" ..
    "  · Gegenstände aus dem Briefkasten\n" ..
    "  · Handwerksrezepte und Reagenzien aus dem Berufe-Panel\n" ..
    "  · Links aus dem Chat-Fenster\n\n" ..
    "|cffff9900Benötigt Blizzard-Chat:|r\n" ..
    "  · Erfolge aus dem Erfolge-Panel\n" ..
    "  · Gegenstände aus dem Bank-Panel\n" ..
    "  · Gegenstände aus dem Gildenbank-Panel\n" ..
    "  · Reittiere aus dem Reittier-Journal\n" ..
    "  · Talente aus dem Talente-Panel\n" ..
    "  · Erscheinungsbilder aus der Garderobe\n" ..
    "  · Einige erweiterungsspezifische Panels\n\n" ..
    "|cffffd100Warum?|r\n" ..
    "Diese Panels verwenden WoWs interne |cff5599ffChatEdit_InsertLink|r-Funktion, die nur Blizzards spezifische Eingabebox prüft. BigChatBox fängt die meisten dieser Aufrufe ab, aber einige Panels umgehen den Standard-Hook vollständig. Dies ist eine WoW-API-Einschränkung, kein Fehler.\n\n" ..
    "|cffffd100Die Lösung|r\n" ..
    "Die |cff5599ffBlizzard-Chat-Tastenbelegung|r (Standard: Strg+Enter) wechselt sofort zu Blizzards nativer Chat-Eingabe. Dort eingeben oder Shift-Klick nutzen, Enter drücken zum Senden, und BigChatBox setzt automatisch fort.\n\n" ..
    "Du kannst diese Taste belegen oder entfernen unter:\n" ..
    "  · |cffffd100/bcb|r > Erweitert-Tab\n" ..
    "  · Esc > Tastenbelegungen > AddOns > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "Zu %s wechseln und Einrichtung neu starten?\nBigChatBox wird neu geladen, um die neue Sprache anzuwenden."

-- ── v5.6.1 Emoji & Emoticon picker ───────────────────────────────────────────
L["SECTION_EMOJI"]          = "Emoticon-Auswahl"
L["CB_SHOW_EMOJI_PICKER"]   = "Emoticon-Auswahl-Schaltfläche anzeigen"
L["EMOJI_PICKER_TITLE"]     = "Emoticon-Auswahl"
L["EMOJI_PICKER_TOOLTIP"]   = "Klicken, um die Emoticon-Auswahl zu öffnen"
L["EMOJI_TAB_LAST"]         = "Zuletzt verwendet"
L["EMOJI_TAB_ASCII"]        = "Emoticons"
L["EMOJI_LAST_EMPTY"]       = "Noch keine kürzlichen Auswahlen."

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "Verlauf durchsuchen..."

L["BTN_SAVE_SNIPPET"]           = "Speichern"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "Standard-Stil verwenden"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "Wenn aktiviert, verwendet die Mehrzeilenbox den Standard-Stil, unabhängig vom aktiven Stil. Deaktivieren, um das aktuelle BCB-Aussehen zu verwenden."

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "Mehrzeilige Eingabe"
L["CB_ENABLE_MULTILINE"]        = "Mehrzeilige Eingabe aktivieren"
L["CB_ENABLE_MULTILINE_HELP"]   = "Öffnet ein großes mehrzeiliges Feld zum Verfassen von Nachrichten. Jede Zeile wird separat gesendet."
L["KEYBIND_OPEN_MULTILINE"]     = "Mehrzeilige Eingabe öffnen:"
L["MULTILINE_KEYBIND_HELP"]     = "Standard: Shift+Enter. Öffnet ein großes Eingabefeld, in dem Enter eine neue Zeile hinzufügt und Shift+Enter alle Zeilen sendet."
L["BTN_OPEN_KEYBINDINGS"]       = "Tastenbelegungen öffnen"
L["MULTILINE_SEND_BTN"]         = "Senden"
L["MULTILINE_CHANNEL_LABEL"]    = "Kanal: %s"
L["MULTILINE_BLOCKED_SECURE"]   = "Mehrzeilige Eingabe nicht verfügbar während M+/Arena/gewertetes SG."
L["MULTILINE_HINT"]             = "Enter = neue Zeile   |   Shift+Enter = alle senden"
