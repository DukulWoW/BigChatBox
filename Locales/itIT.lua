-- BigChatBox Localization - Italian (itIT)
-- Version: 5.6.1
local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "itIT" and (BigChatBox and BigChatBox._forcedLocale) ~= "itIT" then return end

-- !! Addon identity !!---------------------------------------------------------
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "Versione"
L["LOADED_MSG"]   = "BigChatBox v%s caricato. Digita /bcb per aprire le opzioni."

-- !! Config window tabs !!------------------------------------------------------
L["TAB_GENERAL"]   = "Generale"
L["TAB_DESIGNER"]  = "Designer"
L["TAB_PLACEMENT"] = "Posizione"
L["TAB_FEATURES"]  = "Funzioni"
L["TAB_SNIPPETS"]  = "Snippet"
L["TAB_HISTORY"]   = "Cronologia"
L["TAB_ADVANCED"]  = "Avanzate"
L["TAB_RESET"]     = "Ripristina"

-- !! Reset tab !!---------------------------------------------------------------
L["RESET_TAB_HEADER"]       = "Ripristina e restaura"
L["RESET_TAB_DESC"]         = "Queste azioni sono permanenti e non possono essere annullate."
L["RESET_ALL_HELP"]         = "Ripristina tutto: posizione, aspetto, cronologia e snippet."
L["RESET_APPEARANCE_HELP"]  = "Ripristina solo sfondo, bordo, carattere e colori."
L["RESET_PLACEMENT_HELP"]   = "Ripristina posizione e dimensione ai valori predefiniti."
L["RESET_HISTORY_HELP"]     = "Cancella tutta la cronologia di chat e sussurri salvata."
L["RESET_SNIPPETS_HELP"]    = "Elimina tutti gli snippet."
L["RESET_STYLES_HELP"]      = "Elimina tutti gli stili personalizzati salvati."
L["RESTART_SETUP_HELP"]     = "Ripristina tutte le impostazioni e riesegui la procedura guidata di configurazione iniziale."

-- !! Shared UI !!---------------------------------------------------------------
L["PREVIEW"]        = "Anteprima"
L["TYPE_SOMETHING"] = "Scrivi qualcosa..."
L["CLOSE"]          = "Chiudi"
L["ACTIONS"]        = "Azioni"
L["RESET"]          = "Ripristina"
L["OK"]             = "OK"
L["CANCEL"]         = "Annulla"
L["YES"]            = "Si"
L["NO"]             = "No"
L["SAVE"]           = "Salva"
L["DELETE"]         = "Elimina"
L["EDIT"]           = "Modifica"
L["IMPORT"]         = "Importa"
L["EXPORT"]         = "Esporta"
L["DUPLICATE"]      = "Duplica"
L["SHARE"]          = "Condividi"
L["ENABLED"]        = "Attivo"
L["DISABLED"]       = "Disattivo"

-- !! General tab !!-------------------------------------------------------------
L["BTN_VIEW_PATCH_NOTES"]     = "Vedi note della patch"
L["BTN_HELP_AND_TIPS"]        = "Aiuto e suggerimenti"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "Info blocco in combattimento"
L["BTN_SHIFT_CLICK_INFO"]     = "Info Shift+clic"

L["CELL_SNIPPETS_HDR"]       = "|cff5599ffSnippet|r"
L["CELL_SNIPPETS_DESC"]      = "Scorciatoie di testo espanse all'invio.\nGestite nella scheda Snippet."
L["CELL_ANCHOR_HDR"]         = "|cff5599ffEditor ancoraggio|r"
L["CELL_ANCHOR_DESC"]        = "Clicca e trascina per riposizionare.\nTasti freccia per precisione al pixel."
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ffAutocompletamento|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "Tab intelligente per comandi,\ndestinatari sussurri e snippet (!guild)."
L["CELL_HISTORY_HDR"]        = "|cff5599ffCronologia chat|r"
L["CELL_HISTORY_DESC"]       = "Cronologia completa con timestamp.\nScorri con la rotella del mouse."
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ffPersonalizzazione|r"
L["CELL_CUSTOMIZATION_DESC"] = "Scheda Designer per sfondo, bordo,\ncarattere e colori. Salva e condividi stili."
L["CELL_SECURE_HDR"]         = "|cffff9900Contenuto sicuro|r"
L["CELL_SECURE_DESC"]        = "Sospeso automaticamente in M+, arena\ne BG classificato per proteggere la chat."
L["CELL_SHARING_HDR"]        = "|cff5599ffCondivisione|r"
L["CELL_SHARING_DESC"]       = "Esporta stili e snippet come stringhe\nbrevi da condividere con gli amici."
L["CELL_LONGMSG_HDR"]        = "|cff5599ffMessaggi lunghi|r"
L["CELL_LONGMSG_DESC"]       = "I messaggi oltre 255 caratteri\nvengono divisi automaticamente."

-- !! Styles (Designer tab) !!---------------------------------------------------
L["STYLES"]              = "Stili"
L["ACTIVE_STYLE"]        = "Stile attivo"
L["BTN_SAVE_STYLE"]      = "Salva stile"
L["BTN_DELETE_STYLE"]    = "Elimina stile"
L["BTN_EXPORT_STYLE"]    = "Esporta stile"
L["BTN_IMPORT_STYLE"]    = "Importa stile"

-- !! Designer tab sections !!---------------------------------------------------
L["SECTION_SIZE"]         = "Dimensione"
L["SECTION_BACKGROUND"]   = "Sfondo"
L["SECTION_BORDER"]       = "Bordo"
L["SECTION_FONTS"]        = "Caratteri"
L["SECTION_TEXT_OPTIONS"] = "Opzioni testo"

L["LABEL_WIDTH"]              = "Larghezza"
L["LABEL_HEIGHT"]             = "Altezza"
L["LABEL_SCALE"]              = "Scala"
L["LABEL_BG_TEXTURE"]         = "Texture sfondo"
L["LABEL_BG_OPACITY"]         = "Opacita sfondo"
L["LABEL_BG_BRIGHTNESS"]      = "Luminosita sfondo"
L["LABEL_BG_SCALE"]           = "Scala sfondo"
L["LABEL_TINT_INTENSITY"]     = "Intensita tinta"
L["LABEL_BORDER_TEXTURE"]     = "Texture bordo"
L["LABEL_BORDER_OPACITY"]     = "Opacita bordo"
L["LABEL_BORDER_BRIGHTNESS"]  = "Luminosita bordo"
L["LABEL_BORDER_THICKNESS"]   = "Spessore bordo"
L["LABEL_CHANNEL_FONT"]       = "Carattere canale"
L["LABEL_INPUT_FONT"]         = "Carattere input"
L["LABEL_CHANNEL_FONT_SIZE"]  = "Dimensione carattere canale"
L["LABEL_INPUT_FONT_SIZE"]    = "Dimensione carattere input"
L["LABEL_TEXT_ALIGNMENT"]     = "Allineamento testo"
L["LABEL_FONT_OUTLINE"]       = "Contorno carattere"

L["CB_DYNAMIC_HEIGHT"]   = "Altezza dinamica"
L["CB_DYNAMIC_WIDTH"]    = "Larghezza dinamica"
L["CB_TINT_BG"]          = "Colora sfondo con il colore del canale"
L["CB_MATCH_TEXT_COLOR"] = "Abbina colore testo al canale"

-- !! Placement tab !!-----------------------------------------------------------
L["SECTION_LAYOUT_OPTIONS"]   = "Opzioni layout"
L["SECTION_POSITION"]         = "Posizione"
L["LABEL_CHANNEL_NAME_POS"]   = "Posizione nome canale"
L["CB_SHOW_CHANNEL"]           = "Mostra nome canale"
L["LABEL_AUTOCOMPLETE_POS"]   = "Posizione autocompletamento"
L["LABEL_CHAR_COUNTER_POS"]   = "Posizione contatore caratteri"
L["CB_AUTO_HIDE_CHANNEL"]     = "Nascondi nome canale automaticamente (mostra al passaggio del cursore)"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "Apri editor ancoraggio"

-- !! Features tab !!------------------------------------------------------------
L["SECTION_FEATURE_TOGGLES"]  = "Attiva/disattiva funzioni"
L["FEATURE_TOGGLES_DESC"]     = "Attiva o disattiva le funzioni di BigChatBox."
L["SECTION_SNIPPET_SYSTEM"]   = "Sistema snippet"
L["SECTION_AUTOCOMPLETE"]     = "Autocompletamento"
L["SECTION_HISTORY"]          = "Cronologia"
L["SECTION_LINK_HOVER"]       = "Link al passaggio cursore"
L["SECTION_LONG_MESSAGES"]    = "Messaggi lunghi"
L["CB_ENABLE_SNIPPETS"]       = "Attiva sistema snippet"
L["CB_AC_COMMANDS"]           = "Autocompletamento comandi barra (/dance, /guild, ecc.)"
L["CB_AC_WHISPER"]            = "Autocompletamento destinatari sussurro (/w <nome>)"
L["CB_AC_SNIPPETS"]           = "Autocompletamento snippet (!guild, ecc.)"
L["CB_AC_BNET"]               = "Mostra amici Battle.net nell'autocompletamento sussurri"
L["CB_ENABLE_HISTORY"]        = "Attiva cronologia chat"
L["CB_MOUSEWHEEL_HISTORY"]    = "Scorri cronologia con la rotella del mouse"
L["CB_LINK_HOVER"]            = "Mostra tooltip al passaggio del cursore sui link"
L["LABEL_MSG_EXCEEDS_255"]    = "Quando il messaggio supera 255 caratteri"

-- !! Snippets tab !!------------------------------------------------------------
L["SNIPPETS_DISABLED_MSG"]    = "Il sistema snippet e disattivo.\nAttivalo nella scheda Funzioni."
L["SNIPPETS_HEADER"]          = "Snippet"
L["SNIPPETS_DESC"]            = "Digita un trigger snippet nella chat (es. !guild) e premi Invio per espanderlo."
L["SNIPPET_EDIT_HEADER"]      = "Modifica"
L["SNIPPET_ACTIVE"]           = "Snippet attivo"
L["SNIPPET_TRIGGER_LBL"]      = "Trigger:"
L["SNIPPET_TEXT_LBL"]         = "Testo:"
L["SNIPPET_CHANNEL_LBL"]      = "Canale:"
L["SNIPPET_GLOBAL"]           = "Disponibile per tutti i personaggi"
L["SNIPPET_EMPTY_LIST"]       = "Nessuno snippet ancora.\nClicca «Nuovo snippet» o\n«Importa» per iniziare."
L["BTN_NEW_SNIPPET"]          = "Nuovo snippet"
L["BTN_EXPORT_ALL"]           = "Esporta tutto"
L["BTN_SHARE_SNIPPET"]        = "Condividi"
L["BTN_DUPLICATE_SNIPPET"]    = "Duplica"
L["BTN_DELETE_SNIPPET"]       = "Elimina"
L["BTN_IMPORT_SNIPPET"]       = "Importa"

-- !! History tab !!-------------------------------------------------------------
L["HISTORY_HEADER"]           = "Cronologia chat"
L["HISTORY_HELP"]             = "Clicca sul testo per riutilizzarlo. Passa il cursore per vedere il timestamp. Clicca X per rimuovere."
L["HISTORY_EMPTY"]            = "Nessuna cronologia ancora."
L["HISTORY_MORE"]             = "... altri %d"
L["WHISPERS_HEADER"]          = "Sussurri recenti"
L["WHISPERS_CLICK_HINT"]      = "(Clicca per sussurrare)"
L["WHISPERS_EMPTY"]           = "Nessuna cronologia sussurri."
L["BTN_WIPE_HISTORY"]         = "Cancella tutta la cronologia"
L["BTN_WIPE_COMMANDS"]        = "Cancella tutti i /comandi"
L["BTN_REMOVE_ENTRIES"]       = "Rimuovi voci selezionate"

-- !! Advanced tab !!------------------------------------------------------------
L["SECTION_PROFILES"]         = "Profili"
L["PROFILES_DESC"]            = "Le impostazioni vengono salvate per personaggio. Attiva per condividerle tra tutti."
L["CB_GLOBAL_PROFILE"]        = "Usa per tutti i personaggi"
L["BEHAVIOR"]                 = "Comportamento"
L["KEEP_OPEN"]                = "Mantieni la casella di input aperta fino alla pressione di Esc"
L["KEEP_OPEN_HELP"]           = "Quando attivo, la casella di input rimane visibile anche cliccando altrove. Premi Esc per chiuderla."
L["SHOW_LOCKDOWN_WARNING"]    = "Mostra avviso contenuto sicuro"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "Mostra un messaggio in chat quando BCB viene sospeso in M+, arena e BG classificato."
L["IGNORE_COMMANDS_HISTORY"]  = "Ignora /comandi nella cronologia"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "I comandi barra come /target o /cast non vengono salvati nella cronologia."
L["SHOW_MINIMAP_BUTTON"]      = "Mostra pulsante minimappa"
L["SHOW_MINIMAP_BUTTON_HELP"] = "Clic sinistro per aprire impostazioni, clic destro per impostazioni rapide. Il pulsante nella barra addon e sempre disponibile."
L["HIDE_LOGIN_MSG"]           = "Nascondi messaggio di accesso"
L["HIDE_LOGIN_MSG_HELP"]      = "Nasconde il messaggio «BigChatBox caricato» all'accesso."
L["KEYBIND_OPEN_BLIZZARD"]    = "Apri chat Blizzard:"
L["KEYBIND_NOT_BOUND"]        = "Non assegnato"
L["KEYBIND_PRESS_KEY"]        = "Premi un tasto..."
L["KEYBIND_CONFLICT"]         = "%s e gia assegnato a %s. Sovrascrivere?"
L["KEYBIND_TOOLTIP_BOUND"]    = "Apri chat Blizzard (%s)"
L["KEYBIND_TOOLTIP_UNBIND"]   = "Clic destro per rimuovere assegnazione"
L["KEYBIND_TOOLTIP_SET"]      = "Clicca per assegnare un tasto"
L["KEYBIND_HELP"]             = "Apre la casella di chat nativa di Blizzard per Shift+clic su cavalcature, imprese, giocattoli e talenti. Predefinito: Ctrl+Invio."
L["RESET_ALL"]                = "Ripristina tutto"
L["RESET_APPEARANCE"]         = "Ripristina aspetto"
L["RESET_PLACEMENT"]          = "Ripristina posizione"
L["RESET_HISTORY_BTN"]        = "Ripristina cronologia"
L["RESET_SNIPPETS_BTN"]       = "Ripristina snippet"
L["RESET_STYLES_BTN"]         = "Ripristina stili"
L["RESTART_SETUP"]            = "Riesegui procedura guidata"

-- !! Confirmations !!-----------------------------------------------------------
L["POPUP_RESET_ALL"]          = "Ripristinare tutte le impostazioni di BigChatBox?\nInclude posizione, dimensione, aspetto e caratteri."
L["POPUP_RESET_APPEARANCE"]   = "Ripristinare l'aspetto ai valori predefiniti?\nNon influisce sulla posizione o sulla cronologia."
L["POPUP_RESET_PLACEMENT"]    = "Ripristinare la posizione ai valori predefiniti?\nL'interfaccia verra ricaricata."
L["POPUP_RESET_HISTORY"]      = "Ripristinare tutta la cronologia di chat e sussurri?\nLa lunghezza della cronologia verra impostata a 100.\nL'interfaccia verra ricaricata."
L["POPUP_RESET_SNIPPETS"]     = "Eliminare tutti gli snippet? L'interfaccia verra ricaricata."
L["POPUP_RESET_STYLES"]       = "Eliminare tutti gli stili creati dall'utente?\nLo stile predefinito rimarra e diventera quello corrente.\nL'interfaccia verra ricaricata."
L["POPUP_WIPE_HISTORY"]       = "Cancellare tutta la cronologia di chat?\nAnche l'interfaccia verra ricaricata."
L["POPUP_WIPE_COMMANDS"]      = "Rimuovere tutti i /comandi dalla cronologia?\nI messaggi normali verranno mantenuti.\nAnche l'interfaccia verra ricaricata."
L["POPUP_DELETE_STYLE"]       = "Eliminare lo stile corrente?"
L["POPUP_OVERWRITE_STYLE"]    = "Esiste gia uno stile chiamato «%s». Sovrascrivere?"
L["POPUP_SAVE_STYLE_TEXT"]    = "Inserisci un nome per questo stile:"
L["POPUP_EXPORT_STYLE_TEXT"]  = "Copia la stringa dello stile qui sotto:"
L["POPUP_IMPORT_STYLE_TEXT"]  = "Incolla la stringa dello stile:"
L["POPUP_NAME_IMPORT_STYLE"]  = "Salva lo stile importato come:"
L["POPUP_DELETE_SNIPPET"]     = "Eliminare lo snippet «%s»?"
L["POPUP_SHARE_SNIPPET_TEXT"] = "Copia la stringa dello snippet (Ctrl+C):"
L["POPUP_IMPORT_SNIPPET_TEXT"] = "Incolla la stringa dello snippet (Ctrl+V):"
L["POPUP_RESTART_SETUP"]      = "Verranno ripristinate tutte le impostazioni e la procedura guidata verra riavviata.\nContinuare?"
L["POPUP_QUIT_SETUP"]         = "Uscire dalla configurazione?\nVerranno usate le impostazioni predefinite."
L["BTN_RESET_ALL_CONFIRM"]    = "Ripristina tutto"
L["BTN_WIPE_CONFIRM"]         = "Si, cancella"
L["BTN_DELETE_CONFIRM"]       = "Elimina"
L["BTN_OVERWRITE_CONFIRM"]    = "Sovrascrivi"
L["BTN_SKIP"]                 = "Salta"
L["BTN_RESTART_SETUP_CONFIRM"] = "Riavvia procedura"
L["BTN_QUIT_SETUP_CONFIRM"]   = "Esci dalla configurazione"
L["BTN_SAVE_CLOSE"]           = "Chiudi"

-- !! Slash / print messages !!--------------------------------------------------
L["SLASH_POSITION_RESET"]     = "Posizione ripristinata ai valori predefiniti"
L["SLASH_ANCHOR_UNAVAILABLE"] = "L'editor ancoraggio non e disponibile."
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox:|r Cronologia chat cancellata."
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox:|r Aspetto ripristinato ai valori predefiniti"
L["RESET_DONE"]               = "Tutte le impostazioni sono state ripristinate ai valori predefiniti."
L["COMBAT_CLOSE"]             = "Combattimento iniziato -- impostazioni chiuse."
L["COMBAT_BLOCKED"]           = "Impossibile aprire le impostazioni durante il combattimento."

-- !! Position / size labels (legacy) !!-----------------------------------------
L["POSITION"]        = "Posizione"
L["X_POSITION"]      = "Posizione X"
L["Y_POSITION"]      = "Posizione Y"
L["SIZE"]            = "Dimensione"
L["WIDTH"]           = "Larghezza"
L["HEIGHT"]          = "Altezza"
L["SCALE"]           = "Scala"
L["FONT_SIZES"]      = "Dimensioni carattere"
L["INPUT_FONT_SIZE"] = "Dimensione carattere input"
L["CHANNEL_FONT_SIZE"] = "Dimensione carattere canale"
L["FONTS"]           = "Caratteri"
L["INPUT_FONT"]      = "Carattere input"
L["CHANNEL_FONT"]    = "Carattere canale"
L["BACKGROUND"]      = "Sfondo"
L["BG_TEXTURE"]      = "Texture sfondo"
L["BG_TRANSPARENCY"] = "Opacita sfondo"
L["BG_BRIGHTNESS"]   = "Luminosita sfondo"
L["BG_SCALE"]        = "Scala sfondo"
L["BORDER"]          = "Bordo"
L["BORDER_TEXTURE"]  = "Texture bordo"
L["BORDER_TRANSPARENCY"] = "Opacita bordo"
L["BORDER_BRIGHTNESS"]   = "Luminosita bordo"
L["BORDER_THICKNESS"]    = "Spessore bordo"
L["TEXT_OPTIONS"]    = "Opzioni testo"
L["MATCH_TEXT_COLOR"] = "Abbina colore testo al canale"
L["SHOW_OUTLINE"]    = "Mostra contorno testo"
L["SHOW_SHADOW"]     = "Mostra ombra testo"
L["DROP_SHADOW"]     = "Ombra sulla casella di input"
L["TEXT_ALIGN"]      = "Allineamento testo"
L["CHAT_HISTORY"]    = "Cronologia chat"
L["HISTORY_LENGTH"]  = "Lunghezza cronologia"
L["WIPE_HISTORY"]    = "Cancella tutta la cronologia"
L["RECENT_WHISPERS"] = "Sussurri recenti"
L["SNIPPETS"]        = "Snippet"
L["SNIPPET_TRIGGER"] = "Trigger"
L["SNIPPET_TEXT"]    = "Testo"
L["SNIPPET_SAVE"]    = "Salva"
L["SNIPPET_DELETE"]  = "Elimina"
L["SNIPPET_NEW"]     = "Nuovo snippet"
L["SNIPPET_SHARE"]   = "Condividi snippet"
L["SNIPPET_EXPORT"]  = "Esporta tutto"
L["SNIPPET_IMPORT"]  = "Importa"
L["SNIPPET_RESET"]   = "Ripristina snippet"
L["AUTOCOMPLETE"]    = "Autocompletamento"
L["AUTOCOMPLETE_POS"] = "Posizione autocompletamento"
L["CHANNEL_POS"]     = "Posizione nome canale"
L["AUTO_HIDE_CHANNEL"] = "Nascondi nome canale automaticamente (mostra al passaggio del cursore)"
L["LAYOUT_OPTIONS"]  = "Opzioni layout"
L["ANCHOR_EDITOR"]   = "Editor ancoraggio"
L["OPEN_ANCHOR_EDITOR"] = "Apri editor ancoraggio"
L["ABOUT"]           = "Informazioni"
L["ABOUT_DESC"]      = "Una grande casella di input chat personalizzabile con visualizzazione canale, editor ancoraggio e controllo completo dell'aspetto."
L["PROFILES"]        = "Profili"
L["SAVE_STYLE"]      = "Salva stile"
L["DELETE_STYLE"]    = "Elimina stile"
L["DYNAMIC_HEIGHT"]  = "Altezza dinamica"
L["DYNAMIC_WIDTH"]   = "Larghezza dinamica"
L["CHAR_COUNTER_POS"] = "Posizione contatore caratteri"
L["LONG_MESSAGES"]   = "Messaggi lunghi"
L["LONG_MSG_OFF"]    = "Disattivo"
L["LONG_MSG_SILENT"] = "Silenzioso"
L["LONG_MSG_NOTICE"] = "Avviso"
L["LONG_MSG_CONFIRM"] = "Conferma"
L["LONG_MSG_DESC_OFF"]     = "Il messaggio viene troncato a 255 caratteri (comportamento predefinito di WoW)."
L["LONG_MSG_DESC_SILENT"]  = "Diviso automaticamente in piu messaggi."
L["LONG_MSG_DESC_NOTICE"]  = "Divide e indica quante parti sono state inviate."
L["LONG_MSG_DESC_CONFIRM"] = "Chiede conferma prima di dividere."
L["IMPORT_STYLE_BTN"]  = "Importa stringa stile"
L["FINISH_CONFIG_BTN"] = "Termina + Configura"
L["BG_COLOR"]          = "Colore sfondo"
L["MSG_SPLIT_NOTICE"]  = "Messaggio diviso in %d parti (%d caratteri)."

-- !! v5.3.3 Keybinding strings !!-----------------------------------------------
L["HELP_KEYBINDINGS_TITLE"] = "-- Tasti di scelta rapida --"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+Invio passa alla chat predefinita di Blizzard (funziona ovunque).\nUtile per Shift+clic su cavalcature, imprese, giocattoli, talenti e il\nlibro degli incantesimi che non possono essere inseriti direttamente in BCB.\nDigita nella casella Blizzard e premi Invio per inviare; BCB riprende al\nprossimo Invio.\n\nPuoi modificare o rimuovere questa assegnazione nella scheda Avanzate o in\n«Esc > Tasti di scelta rapida > Addon > BigChatBox»."

-- !! v5.5.0 Welcome Panel !!----------------------------------------------------
L["WELCOME_TITLE"]          = "Benvenuto in BigChatBox!"
L["WELCOME_SUBTITLE"]       = "Configurazione iniziale"
L["WELCOME_TEXT"]           = "BigChatBox sostituisce la piccola casella di input chat di WoW con una grande e completamente personalizzabile.\n\nPuoi modificare dimensione, sfondo, bordo, carattere e colori, oppure scegliere uno stile predefinito. Funzioni come cronologia chat, snippet di testo e autocompletamento intelligente sono integrate e possono essere attivate o disattivate in qualsiasi momento.\n\nQuesta configurazione rapida ti mettera in pista in meno di un minuto."
L["WELCOME_SETUP_BTN"]      = "Configura BigChatBox"
L["WELCOME_LANG_LBL"]       = "Lingua:"
L["WELCOME_STYLE_TITLE"]    = "Scegli il tuo stile!"
L["WELCOME_LAYOUT_TITLE"]   = "Scegli il layout"
L["WELCOME_FEATURES_TITLE"] = "Scegli le tue funzioni!"
L["WELCOME_ADVANCED_TITLE"] = "Funzioni avanzate"
L["WELCOME_FINAL_TITLE"]    = "Quasi fatto!"
L["WELCOME_FINISH_BTN"]     = "Fatto!"
L["WELCOME_QUIT_CONFIRM"]   = "Uscire dalla configurazione? Verranno usate le impostazioni predefinite."
L["WELCOME_KEYBIND_INFO"]   = "La maggior parte dei Shift+clic sui link funziona direttamente in BigChatBox. Per i pochi che non funzionano (cavalcature, giocattoli e talenti), questo tasto passa alla casella chat di Blizzard."
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBox viene sospeso automaticamente durante il combattimento, M+, arena e BG classificato per proteggere la tua chat."
L["WELCOME_THANKS"]         = "Grazie per usare BigChatBox!"
L["WELCOME_SECURE_TITLE"]   = "Contenuto sicuro"
L["WELCOME_KEYBIND_TITLE"]  = "Tasto chat Blizzard"
L["WELCOME_CONFIG_HINT"]    = "Digita /bcb in qualsiasi momento per aprire la finestra delle impostazioni complete."
L["FEATURE_HISTORY_DESC"]   = "Salva i messaggi inviati con timestamp."
L["FEATURE_SNIPPETS_DESC"]  = "Scorciatoie di testo espanse premendo Invio."
L["FEATURE_AC_SNIPPETS_DESC"]  = "Autocompleta trigger snippet che iniziano con !."
L["FEATURE_AC_COMMANDS_DESC"]  = "Autocompleta comandi barra come /dance o /guild."
L["FEATURE_AC_WHISPERS_DESC"]  = "Autocompleta nomi giocatori nei sussurri."
L["FEATURE_MOUSEWHEEL_DESC"]   = "Usa la rotella del mouse per scorrere i messaggi precedenti."
L["FEATURE_GLOBAL_PROFILE_DESC"] = "Condivide le impostazioni tra tutti i personaggi di questo account."
L["FEATURE_KEEP_OPEN_DESC"]    = "La casella di input rimane visibile anche cliccando altrove."
L["RESTART_SETUP_CONFIRM"]  = "Verranno ripristinate tutte le impostazioni e la procedura guidata verra riavviata. Continuare?"

-- !! v5.6.0 Patch notes UI !!---------------------------------------------------
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox -- Novita"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox -- Note della patch"
L["PATCHNOTES_DONT_SHOW"]      = "Non mostrare di nuovo"
L["PATCHNOTES_GOT_IT"]         = "Capito!"
L["PATCHNOTES_PREVIOUS"]       = "-- Aggiornamenti precedenti --"

-- !! Keys added during source wiring (v5.6.0 localization pass) !!--------------
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffffDisattivo|r -- Troncato a 255 caratteri (comportamento predefinito di WoW).\n|cffffffffSilenzioso|r -- Diviso automaticamente in piu messaggi.\n|cffffffffAvviso|r -- Divide e indica quante parti sono state inviate.\n|cffffffffConferma|r -- Chiede conferma prima di dividere."

L["SNIPPET_NOTHING_TO_EXPORT"] = "Nessuno snippet da esportare."

L["HISTORY_LENGTH_LABEL"] = "Lunghezza cronologia"

L["PRINT_RESET_ALL"]         = "Tutte le impostazioni sono state ripristinate ai valori predefiniti. Ricaricamento in corso..."
L["PRINT_RESET_APPEARANCE"]  = "Aspetto ripristinato. Ricaricamento in corso..."
L["PRINT_RESET_PLACEMENT"]   = "Posizione ripristinata. Ricaricamento in corso..."
L["PRINT_RESET_HISTORY"]     = "Cronologia ripristinata. Ricaricamento in corso..."
L["PRINT_SNIPPETS_REMOVED"]  = "Tutti gli snippet sono stati rimossi."
L["PRINT_STYLES_REMOVED"]    = "Tutti gli stili personalizzati sono stati rimossi."
L["PRINT_NO_STYLE_STRING"]   = "Nessuna stringa stile fornita."
L["PRINT_STYLE_DECODE_FAIL"] = "Impossibile decodificare la stringa stile; potrebbe essere corrotta."
L["PRINT_STYLE_INVALID"]     = "Stringa stile non valida. Prefisso !BCB1: o BCB: atteso."
L["PRINT_STYLE_IMPORTED"]    = "Stile importato correttamente."
L["PRINT_STYLE_SAVED"]       = "Stile «%s» salvato."
L["PRINT_STYLE_DELETED"]     = "Stile «%s» eliminato."
L["PRINT_SNIPPET_INVALID"]   = "Stringa snippet non valida."
L["PRINT_SNIPPET_REMOVED"]   = "Snippet «%s» rimosso."
L["PRINT_SNIPPETS_IMPORTED"] = "%d snippet importati."
L["PRINT_SNIPPETS_SKIPPED"]  = " %d ignorati (esistono gia)."
L["PRINT_CANT_DELETE_DEFAULT"] = "Impossibile eliminare lo stile predefinito."
L["PRINT_SETUP_SKIPPED"]     = "Configurazione saltata. Digita |cff55ccff/bcb|r per configurare in qualsiasi momento."
L["BTN_RESET_STYLES_CONFIRM"] = "Ripristina stili"

L["POPUP_WIPE_WHISPERS"]     = "Cancellare la cronologia dei sussurri? Questa azione non puo essere annullata."

L["WELCOME_CHOOSE_STYLE"]      = "Scegli uno stile:"
L["WELCOME_STYLE_NOTE"]        = "Gli stili con nome addon richiedono quell'addon installato.\nPuoi personalizzare tutto completamente nella scheda Designer."
L["WELCOME_LAYOUT_DESC"]       = "Scegli dove appariranno il nome del canale e l'autocompletamento rispetto alla casella di input."
L["WELCOME_CHANNEL_POS_LBL"]   = "Posizione nome canale:"
L["WELCOME_AC_POS_LBL"]        = "Posizione autocompletamento:"
L["WELCOME_AUTOHIDE_HELP"]     = "Il nome del canale scompare finche non passi il cursore sulla casella di input."
L["WELCOME_CHARCOUNTER_LBL"]   = "Posizione contatore caratteri:"
L["WELCOME_FEATURES_DESC"]     = "Attiva le funzioni che vuoi usare. Tutte sono attive per impostazione predefinita.\nPuoi modificarle in qualsiasi momento nella scheda Funzioni."
L["WELCOME_LONGMSG_LBL"]       = "Messaggi lunghi (oltre 255 caratteri):"
L["LONGMSG_DESC_OFF"]          = "Tronca a 255 caratteri"
L["LONGMSG_DESC_SILENT"]       = "Dividi automaticamente"
L["LONGMSG_DESC_NOTICE"]       = "Dividi con avviso"
L["LONGMSG_DESC_CONFIRM"]      = "Chiedi prima di dividere"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "Scopri di piu sul blocco in combattimento"
L["WELCOME_WHY_KEYBIND"]       = "Perche ho bisogno di questo?"
L["WELCOME_CURRENT_KEYBIND"]   = "Tasto corrente:"
L["WELCOME_KEYBIND_CLICK_HINT"] = "Clicca per assegnare - Clic destro per rimuovere"
L["WELCOME_OPEN_HELP"]         = "Apri finestra aiuto e suggerimenti"
L["WELCOME_HELP_DESC"]         = "Tutti i comandi, i tasti di scelta rapida e i dettagli delle funzioni sono disponibili nella finestra di aiuto."
L["WELCOME_RELOAD_NOTE"]       = "Entrambi i pulsanti ricaricheranno la tua interfaccia."
L["WELCOME_COMBAT_PAUSE"]      = "Configurazione sospesa -- combattimento iniziato."
L["WELCOME_SHIFTCLICK_TITLE"]  = "Inserimento link con Shift+clic"
L["WELCOME_FEAT_HISTORY"]      = "Cronologia chat"
L["WELCOME_FEAT_SNIPPETS"]     = "Sistema snippet"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "Autocompletamento: !snippet"
L["WELCOME_FEAT_AC_COMMANDS"]  = "Autocompletamento: /comandi"
L["WELCOME_FEAT_AC_WHISPER"]   = "Autocompletamento: sussurri"
L["WELCOME_FEAT_AC_BNET"]      = "Autocompletamento: amici Battle.net"
L["WELCOME_FEAT_KEEP_OPEN"]    = "Mantieni casella di input aperta"

L["BTN_PREVIOUS"]  = "Precedente"
L["BTN_NEXT"]      = "Avanti"

-- !! Language selector !!-------------------------------------------------------
L["SECTION_LANGUAGE"]        = "Lingua"
L["LANGUAGE_DESC"]           = "Cambia la lingua dell'interfaccia. Richiede ricaricamento."
L["LANGUAGE_CLIENT"]         = "Lingua del client"
L["LANGUAGE_RELOAD_MSG"]     = "Lingua modificata. Ricaricamento interfaccia..."
L["POPUP_CHANGE_LANGUAGE"]   = "Cambiare lingua e ricaricare l'interfaccia?"
L["BTN_RELOAD_CONFIRM"]      = "Ricarica"
L["LANGUAGE_COMING_SOON"]    = "|cff888888(Presto disponibile)|r"

-- !! Help popup body strings !!-------------------------------------------------
L["HELP_WINDOW_TITLE"] = "Aiuto BigChatBox"

L["HELP_BODY_MAIN"] = [[|cffffd100-- Comandi --|r
|cffffd100/bcb|r o |cffffd100/bcb config|r -- Apre la finestra delle impostazioni.
|cffffd100/bcb edit|r -- Apre l'editor ancoraggio per spostare la casella.
|cffffd100/bcb reset|r -- Ripristina la posizione ai valori predefiniti.

|cffffd100-- Basi della chat --|r
|cffffd100Clic sinistro|r sul nome del canale per cambiare canale (Generale, Gruppo, Gilda, ecc.).
|cffffd100Clic destro|r sul nome del canale per accedere a impostazioni, cronologia e cancellazione.
|cffffd100Invio|r per inviare il messaggio. |cffffd100Esc|r per cancellare e chiudere.
|cffffd100Rotella del mouse|r nella casella di input per vedere la cronologia chat.

|cffffd100-- Autocompletamento --|r
Digita |cffffd100/|r per vedere i comandi barra corrispondenti (Tab per scorrere, Invio per confermare).
Digita |cffffd100!|r per autocompletare trigger snippet (es. !guild, !inv).
I destinatari dei sussurri vengono completati da amici, gilda, gruppo e sussurri recenti.
|cffffd100Tab|r / |cffffd100Shift+Tab|r per scorrere i suggerimenti.

|cffffd100-- Snippet --|r
Definisci scorciatoie di testo espanse premendo Invio.
Es.: !guild si espande in "LFM M+, sussurra per invito".
Ogni snippet puo essere limitato a un canale specifico.
Gestisci, crea, importa ed esporta snippet nella scheda |cff5599ffSnippet|r.

|cffffd100-- Inserimento link --|r
|cffffd100Shift+clic|r su oggetti, incantesimi, imprese, ecc. per inserire un link.
Funziona in borse, libro degli incantesimi, pannello imprese, professioni e output chat.
|cffffd100Passa il cursore|r su un link nella casella di input per visualizzare l'anteprima del tooltip.
Per i pannelli che non supportano l'inserimento diretto, consulta il pulsante |cff5599ffInfo Shift+clic|r.

|cffffd100-- Personalizzazione --|r
Usa la scheda |cff5599ffDesigner|r per personalizzare sfondo, bordo, carattere e colori.
La scheda |cff5599ffPosizione|r include l'editor ancoraggio per l'allineamento preciso.
Salva l'aspetto come stile nominato. Esporta/importa stringhe stile per condividere.
Supporta texture e caratteri di LibSharedMedia se installato.

|cffffd100-- Strumenti e attivatori --|r
Attiva o disattiva ogni funzione individualmente nella scheda |cff5599ffFunzioni|r:
autocompletamento, snippet, tooltip link al passaggio cursore, cronologia chat e altro.
La modalita |cffffd100Mantieni aperto|r fa rimanere visibile la casella di input anche quando perde il focus.

|cffffd100-- Profili e stili --|r
Le impostazioni vengono salvate per personaggio per impostazione predefinita.
Attiva |cffffd100Usa per tutti i personaggi|r in Avanzate per condividere le impostazioni globalmente.
Gli stili salvano l'aspetto visivo (sfondo, bordo, carattere, colori).
Usa Esporta/Importa per condividere stili con gli amici o spostarli tra personaggi.

|cffffd100-- Posizione e dimensione --|r
Clicca e trascina la casella di input nell'editor ancoraggio per spostarla.
I tasti freccia la spostano di 1 pixel alla volta per precisione.
Shift+trascinamento ridimensiona la casella simmetricamente.
|cffffd100Shift+Alt+clic|r sulla casella di input ripristina la posizione al centro dello schermo.
Puoi anche inserire valori esatti di posizione e dimensione nel pannello info dell'editor ancoraggio.

|cffffd100-- Messaggi lunghi --|r
I messaggi oltre 255 caratteri possono essere divisi automaticamente in piu invii.
Configura il comportamento nella scheda |cff5599ffFunzioni|r: disattivo, silenzioso, avviso o conferma.
Il contatore caratteri mostra quanto manca al limite.

|cffffd100-- Dimensione dinamica --|r
Attiva |cffffd100Altezza dinamica|r e |cffffd100Larghezza dinamica|r nella scheda Designer.
L'altezza si adatta alla dimensione del carattere; la larghezza cresce con la lunghezza del messaggio.]]

L["HELP_BODY_SECURE"] = "|cffffd100-- Perche BigChatBox si sospende in combattimento/M+/ecc. --|r\n\n" ..
    "Con l'espansione Mezzanotte (12.0), Blizzard ha apportato modifiche significative al modo in cui gli addon interagiscono con il gioco durante il combattimento. Questa iniziativa e nota come |cff5599ffDisarmo degli Addon|r e limita il modo in cui gli addon possono gestire le informazioni di combattimento.\n\n" ..
    "|cffffd100Cosa e cambiato?|r\n" ..
    "I dati relativi al combattimento vengono ora trattati come |cffff9900valori segreti|r. Gli addon possono visualizzare queste informazioni, ma non leggerle o elaborarle nel codice.\n\n" ..
    "Molti frame dell'interfaccia sono ora |cffff9900protetti|r durante il combattimento. Nel contenuto di istanza (M+, arena, BG classificato), le restrizioni sono ancora piu severe. Qualsiasi addon che modifichi o agganci questi frame protetti rischia di propagare |cffff6666contaminazione|r, potenzialmente compromettendo completamente le funzionalita del gioco -- non solo dell'addon, ma anche funzioni di base come selezionare il bersaglio, lanciare incantesimi e usare abilita.\n\n" ..
    "|cffffd100Come influisce su BigChatBox?|r\n" ..
    "La casella di input chat predefinita di WoW (ChatFrame1EditBox) e un frame protetto perche gestisce comandi barra sicuri come /target, /cast e /focus. BigChatBox aggancia questo frame per intercettare l'input della chat. Durante il combattimento e nel contenuto competitivo di istanza, questi agganci possono causare contaminazione, bloccando l'intero sistema chat.\n\n" ..
    "Per proteggerti, BigChatBox si |cff00ff00sospende automaticamente|r durante il combattimento e in M+, arena e BG classificato. La casella di input chat predefinita di Blizzard subentra senza interruzioni. Quando il combattimento termina o il contenuto e completato, BigChatBox riprende automaticamente.\n\n" ..
    "|cffffd100Perche non viene semplicemente corretto?|r\n" ..
    "Non e un |cffff0000bug|r. E una limitazione fondamentale del modello di sicurezza di WoW. Tutti gli addon che modificano frame protetti durante il combattimento affrontano la stessa restrizione. Blizzard ha progettato queste limitazioni per impedire agli addon di automatizzare le decisioni di combattimento, e la casella di input chat rientra nell'ambito protetto.\n\n" ..
    "|cffffd100Riepilogo|r\n" ..
    "BigChatBox si sospende durante il combattimento e nel contenuto a tempo (M+, arena, BG classificato). Nel frattempo puoi comunque chattare normalmente con la casella di input predefinita di Blizzard. Quando il combattimento termina o l'attivita e completata, BigChatBox riprendera automaticamente."

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100-- Perche non tutti i Shift+clic funzionano? --|r\n\n" ..
    "La maggior parte dei Shift+clic per inserire link funziona direttamente in BigChatBox. Tuttavia, alcuni pannelli del gioco utilizzano una funzione interna di Blizzard che inserisce link solo nella casella di input di Blizzard, bypassando quella degli addon.\n\n" ..
    "|cff00ff00Funziona in BigChatBox:|r\n" ..
    "  - Oggetti nelle borse personali\n" ..
    "  - Mascotte dal Diario mascotte\n" ..
    "  - Eredita dal pannello eredita\n" ..
    "  - Oggetti del mercante\n" ..
    "  - Oggetti dalla cassetta postale\n" ..
    "  - Ricette e materiali dal pannello professioni\n" ..
    "  - Link nelle finestre chat\n\n" ..
    "|cffff9900Richiede chat Blizzard:|r\n" ..
    "  - Imprese dal pannello imprese\n" ..
    "  - Oggetti dalla banca\n" ..
    "  - Oggetti dalla banca di gilda\n" ..
    "  - Cavalcature dal Diario cavalcature\n" ..
    "  - Talenti dal pannello talenti\n" ..
    "  - Aspetti dalla trasmogrifficazione\n" ..
    "  - Alcuni pannelli specifici dell'espansione\n\n" ..
    "|cffffd100Perche?|r\n" ..
    "Questi pannelli usano la funzione interna di WoW |cff5599ffChatEdit_InsertLink|r, che verifica una specifica casella di input di Blizzard. BCB intercetta la maggior parte di queste chiamate, ma alcuni pannelli aggirano completamente gli agganci standard a causa di come Blizzard li implementa. E una limitazione dell'API di WoW, non un bug.\n\n" ..
    "|cffffd100Soluzione|r\n" ..
    "Premi il |cff5599ffTasto chat Blizzard|r (predefinito: Ctrl+Invio) per passare istantaneamente alla casella chat nativa. Digita o fai Shift+clic li e premi Invio per inviare; BigChatBox riprendera automaticamente al messaggio successivo.\n\n" ..
    "Per modificare o rimuovere questo tasto:\n" ..
    "  - |cffffd100/bcb|r > scheda Avanzate\n" ..
    "  - Esc > Tasti di scelta rapida > Addon > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "Passare a %s e riavviare la configurazione?\nBigChatBox verra ricaricato per applicare la nuova lingua."

-- !! v5.6.1 Emoji & Emoticon picker !!-----------------------------------------
L["SECTION_EMOJI"]          = "Selettore emoji"
L["CB_SHOW_EMOJI_PICKER"]   = "Mostra pulsante selettore emoji"
L["EMOJI_PICKER_TITLE"]     = "Selettore emoji"
L["EMOJI_PICKER_TOOLTIP"]   = "Clicca per aprire il selettore emoji"
L["EMOJI_TAB_LAST"]         = "Recenti"
L["EMOJI_TAB_ASCII"]        = "Emoticon"
L["EMOJI_LAST_EMPTY"]       = "Nessuna selezione recente."

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "Cerca nella cronologia..."

L["BTN_SAVE_SNIPPET"]           = "Salva"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "Usa stile predefinito"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "Se selezionato, la casella multiriga usa lo stile predefinito indipendentemente dallo stile attivo. Deseleziona per usare l'aspetto BCB corrente."

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "Inserimento multiriga"
L["CB_ENABLE_MULTILINE"]        = "Abilita inserimento multiriga"
L["CB_ENABLE_MULTILINE_HELP"]   = "Apre una grande casella multiriga per comporre messaggi. Ogni riga viene inviata separatamente."
L["KEYBIND_OPEN_MULTILINE"]     = "Apri inserimento multiriga:"
L["MULTILINE_KEYBIND_HELP"]     = "Predefinito: Maiusc+Invio. Apre una grande casella di inserimento dove Invio aggiunge una nuova riga e Maiusc+Invio invia tutte le righe."
L["BTN_OPEN_KEYBINDINGS"]       = "Apri tasti di scelta rapida"
L["MULTILINE_SEND_BTN"]         = "Invia"
L["MULTILINE_CHANNEL_LABEL"]    = "Canale: %s"
L["MULTILINE_BLOCKED_SECURE"]   = "L'inserimento multiriga non è disponibile durante M+/Arena/BG classificata."
L["MULTILINE_HINT"]             = "Invio = nuova riga   |   Maiusc+Invio = invia tutto"
