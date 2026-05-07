-- BigChatBox Localization - French (frFR)
-- Version: 5.6.1
-- Full translation for 5.6.1 locale system. Overrides all keys that differ from enUS.
-- Missing keys fall back to enUS automatically.

local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "frFR" and (BigChatBox and BigChatBox._forcedLocale) ~= "frFR" then return end

-- ── Addon identity ────────────────────────────────────────────────────────────
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "Version"
L["LOADED_MSG"]   = "BigChatBox v%s chargé ! Tapez /bcb pour les options."

-- ── Config window tabs ────────────────────────────────────────────────────────
L["TAB_GENERAL"]   = "Général"
L["TAB_DESIGNER"]  = "Concepteur"
L["TAB_PLACEMENT"] = "Placement"
L["TAB_FEATURES"]  = "Fonctions"
L["TAB_SNIPPETS"]  = "Extraits"
L["TAB_HISTORY"]   = "Historique"
L["TAB_ADVANCED"]  = "Avancé"
L["TAB_RESET"]     = "Réinitialiser"

-- ── Reset tab ─────────────────────────────────────────────────────────────────
L["RESET_TAB_HEADER"]       = "Réinitialisation"
L["RESET_TAB_DESC"]         = "Ces actions sont permanentes et irréversibles."
L["RESET_ALL_HELP"]         = "Réinitialise tout : position, apparence, historique et extraits."
L["RESET_APPEARANCE_HELP"]  = "Réinitialise uniquement l'arrière-plan, la bordure, les polices et les couleurs."
L["RESET_PLACEMENT_HELP"]   = "Réinitialise la position et la taille par défaut."
L["RESET_HISTORY_HELP"]     = "Efface tout l'historique de chat et de chuchotements."
L["RESET_SNIPPETS_HELP"]    = "Supprime tous les extraits."
L["RESET_STYLES_HELP"]      = "Supprime tous les styles personnalisés enregistrés."
L["RESTART_SETUP_HELP"]     = "Réinitialise tous les paramètres et relance l'assistant de configuration."

-- ── Shared UI ─────────────────────────────────────────────────────────────────
L["PREVIEW"]        = "Aperçu"
L["TYPE_SOMETHING"] = "Tapez quelque chose ici..."
L["CLOSE"]          = "Fermer"
L["ACTIONS"]        = "Actions"
L["RESET"]          = "Réinitialiser"
L["OK"]             = "OK"
L["CANCEL"]         = "Annuler"
L["YES"]            = "Oui"
L["NO"]             = "Non"
L["SAVE"]           = "Enregistrer"
L["DELETE"]         = "Supprimer"
L["EDIT"]           = "Modifier"
L["IMPORT"]         = "Importer"
L["EXPORT"]         = "Exporter"
L["DUPLICATE"]      = "Dupliquer"
L["SHARE"]          = "Partager"
L["ENABLED"]        = "Activé"
L["DISABLED"]       = "Désactivé"

-- ── General tab ───────────────────────────────────────────────────────────────
L["BTN_VIEW_PATCH_NOTES"]     = "Voir les notes de mise à jour"
L["BTN_HELP_AND_TIPS"]        = "Aide et astuces"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "Info verrouillage combat"
L["BTN_SHIFT_CLICK_INFO"]     = "Info clic Maj"

-- General tab feature grid
L["CELL_SNIPPETS_HDR"]       = "|cff5599ffExtraits|r"
L["CELL_SNIPPETS_DESC"]      = "Raccourcis texte développés à l'envoi.\nGérés dans l'onglet Extraits."
L["CELL_ANCHOR_HDR"]         = "|cff5599ffÉditeur d'ancrage|r"
L["CELL_ANCHOR_DESC"]        = "Cliquez et faites glisser pour repositionner.\nTouches directionnelles pour la précision au pixel."
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ffAutocomplétion|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "Tab intelligent pour les commandes, chuchotements\net déclencheurs d'extraits (!guilde)."
L["CELL_HISTORY_HDR"]        = "|cff5599ffHistorique de chat|r"
L["CELL_HISTORY_DESC"]       = "Historique complet avec horodatages.\nFaites défiler avec la molette."
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ffPersonnalisation|r"
L["CELL_CUSTOMIZATION_DESC"] = "Onglet Concepteur pour arrière-plans, bordures,\npolices, couleurs. Sauvegardez et partagez les styles."
L["CELL_SECURE_HDR"]         = "|cffff9900Contenu sécurisé|r"
L["CELL_SECURE_DESC"]        = "Pause automatique en M+, arènes et\nchamps de bataille notés pour protéger votre chat."
L["CELL_SHARING_HDR"]        = "|cff5599ffPartage|r"
L["CELL_SHARING_DESC"]       = "Exportez styles et extraits sous forme de\nchaînes courtes à partager avec vos amis."
L["CELL_LONGMSG_HDR"]        = "|cff5599ffLongs messages|r"
L["CELL_LONGMSG_DESC"]       = "Les messages dépassant 255 caractères sont\ndivisés automatiquement. Silencieux, avis ou confirmation."

-- ── Styles (Designer tab) ─────────────────────────────────────────────────────
L["STYLES"]              = "Styles"
L["ACTIVE_STYLE"]        = "Style actif"
L["BTN_SAVE_STYLE"]      = "Enregistrer le style"
L["BTN_DELETE_STYLE"]    = "Supprimer le style"
L["BTN_EXPORT_STYLE"]    = "Exporter le style"
L["BTN_IMPORT_STYLE"]    = "Importer un style"

-- ── Designer tab sections ─────────────────────────────────────────────────────
L["SECTION_SIZE"]         = "Taille"
L["SECTION_BACKGROUND"]   = "Arrière-plan"
L["SECTION_BORDER"]       = "Bordure"
L["SECTION_FONTS"]        = "Polices"
L["SECTION_TEXT_OPTIONS"] = "Options de texte"

-- Designer tab slider / dropdown labels
L["LABEL_WIDTH"]              = "Largeur"
L["LABEL_HEIGHT"]             = "Hauteur"
L["LABEL_SCALE"]              = "Échelle"
L["LABEL_BG_TEXTURE"]         = "Texture d'arrière-plan"
L["LABEL_BG_OPACITY"]         = "Opacité de l'arrière-plan"
L["LABEL_BG_BRIGHTNESS"]      = "Luminosité de l'arrière-plan"
L["LABEL_BG_SCALE"]           = "Échelle de l'arrière-plan"
L["LABEL_TINT_INTENSITY"]     = "Intensité de la teinte"
L["LABEL_BORDER_TEXTURE"]     = "Texture de bordure"
L["LABEL_BORDER_OPACITY"]     = "Opacité de la bordure"
L["LABEL_BORDER_BRIGHTNESS"]  = "Luminosité de la bordure"
L["LABEL_BORDER_THICKNESS"]   = "Épaisseur de la bordure"
L["LABEL_CHANNEL_FONT"]       = "Police du canal"
L["LABEL_INPUT_FONT"]         = "Police de saisie"
L["LABEL_CHANNEL_FONT_SIZE"]  = "Taille de police du canal"
L["LABEL_INPUT_FONT_SIZE"]    = "Taille de police de saisie"
L["LABEL_TEXT_ALIGNMENT"]     = "Alignement du texte"
L["LABEL_FONT_OUTLINE"]       = "Contour de police"

-- Designer tab checkboxes
L["CB_DYNAMIC_HEIGHT"]   = "Hauteur dynamique"
L["CB_DYNAMIC_WIDTH"]    = "Largeur dynamique"
L["CB_TINT_BG"]          = "Teinter l'arrière-plan avec la couleur du canal"
L["CB_MATCH_TEXT_COLOR"] = "Faire correspondre la couleur du texte au canal"

-- ── Placement tab ─────────────────────────────────────────────────────────────
L["SECTION_LAYOUT_OPTIONS"]   = "Options de mise en page"
L["SECTION_POSITION"]         = "Position"
L["LABEL_CHANNEL_NAME_POS"]   = "Position du nom de canal"
L["CB_SHOW_CHANNEL"]           = "Afficher le nom du canal"
L["LABEL_AUTOCOMPLETE_POS"]   = "Position de l'autocomplétion"
L["LABEL_CHAR_COUNTER_POS"]   = "Position du compteur de caractères"
L["CB_AUTO_HIDE_CHANNEL"]     = "Masquer automatiquement le nom du canal (afficher au survol)"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "Ouvrir l'éditeur d'ancrage"

-- ── Features tab ─────────────────────────────────────────────────────────────
L["SECTION_FEATURE_TOGGLES"]  = "Activer/désactiver les fonctions"
L["FEATURE_TOGGLES_DESC"]     = "Activez ou désactivez les fonctions de BigChatBox."
L["SECTION_SNIPPET_SYSTEM"]   = "Système d'extraits"
L["SECTION_AUTOCOMPLETE"]     = "Autocomplétion"
L["SECTION_HISTORY"]          = "Historique"
L["SECTION_LINK_HOVER"]       = "Survol de liens"
L["SECTION_LONG_MESSAGES"]    = "Longs messages"
L["CB_ENABLE_SNIPPETS"]       = "Activer le système d'extraits"
L["CB_AC_COMMANDS"]           = "Autocomplétion des commandes (/dance, /guilde, ...)"
L["CB_AC_WHISPER"]            = "Autocomplétion des noms pour les chuchotements (/w <nom>)"
L["CB_AC_SNIPPETS"]           = "Autocomplétion des déclencheurs d'extraits (!guilde, ...)"
L["CB_AC_BNET"]               = "Afficher les amis Battle.net dans l'autocomplétion des chuchotements"
L["CB_ENABLE_HISTORY"]        = "Activer l'historique de chat"
L["CB_MOUSEWHEEL_HISTORY"]    = "Faire défiler l'historique avec la molette"
L["CB_LINK_HOVER"]            = "Afficher les infobulles au survol des liens"
L["LABEL_MSG_EXCEEDS_255"]    = "Quand le message dépasse 255 caractères"

-- ── Snippets tab ──────────────────────────────────────────────────────────────
L["SNIPPETS_DISABLED_MSG"]    = "Le système d'extraits est désactivé.\nActivez-le dans l'onglet Fonctions."
L["SNIPPETS_HEADER"]          = "Extraits"
L["SNIPPETS_DESC"]            = "Tapez un déclencheur d'extrait (ex. !guilde) dans le chat et appuyez sur Entrée pour l'envoyer."
L["SNIPPET_EDIT_HEADER"]      = "Modifier"
L["SNIPPET_ACTIVE"]           = "Extrait actif"
L["SNIPPET_TRIGGER_LBL"]      = "Déclencheur :"
L["SNIPPET_TEXT_LBL"]         = "Texte :"
L["SNIPPET_CHANNEL_LBL"]      = "Publier dans :"
L["SNIPPET_GLOBAL"]           = "Disponible pour tous les personnages"
L["SNIPPET_EMPTY_LIST"]       = "Aucun extrait pour l'instant.\nCliquez sur Nouvel extrait ou\nImporter pour commencer."
L["BTN_NEW_SNIPPET"]          = "Nouvel extrait"
L["BTN_EXPORT_ALL"]           = "Tout exporter"
L["BTN_SHARE_SNIPPET"]        = "Partager"
L["BTN_DUPLICATE_SNIPPET"]    = "Dupliquer"
L["BTN_DELETE_SNIPPET"]       = "Supprimer"
L["BTN_IMPORT_SNIPPET"]       = "Importer"

-- ── History tab ───────────────────────────────────────────────────────────────
L["HISTORY_HEADER"]           = "Historique de chat"
L["HISTORY_HELP"]             = "Cliquez pour réutiliser. Survolez pour l'horodatage. Cliquez sur X pour marquer la suppression."
L["HISTORY_EMPTY"]            = "Pas encore d'historique."
L["HISTORY_MORE"]             = "... et %d de plus"
L["WHISPERS_HEADER"]          = "Chuchotements récents"
L["WHISPERS_CLICK_HINT"]      = "(cliquer pour chuchoter)"
L["WHISPERS_EMPTY"]           = "Pas d'historique de chuchotements."
L["BTN_WIPE_HISTORY"]         = "Effacer tout l'historique"
L["BTN_WIPE_COMMANDS"]        = "Effacer toutes les /commandes"
L["BTN_REMOVE_ENTRIES"]       = "Supprimer les entrées"

-- ── Advanced tab ──────────────────────────────────────────────────────────────
L["SECTION_PROFILES"]         = "Profils"
L["PROFILES_DESC"]            = "Les paramètres sont sauvegardés par personnage. Activez pour partager sur tous les personnages."
L["CB_GLOBAL_PROFILE"]        = "Utiliser pour tous les personnages"
L["BEHAVIOR"]                 = "Comportement"
L["KEEP_OPEN"]                = "Garder la zone de saisie ouverte jusqu'à Échap"
L["KEEP_OPEN_HELP"]           = "Quand activé, la zone de saisie reste visible si vous cliquez ailleurs. Appuyez sur Échap pour fermer."
L["SHOW_LOCKDOWN_WARNING"]    = "Afficher l'avertissement de contenu sécurisé"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "Affiche un message dans le chat quand BCB se met en pause en M+, arènes et champs de bataille notés."
L["IGNORE_COMMANDS_HISTORY"]  = "Ignorer les /commandes dans l'historique"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "Les commandes comme /cible et /lancer ne seront pas sauvegardées dans l'historique."
L["SHOW_MINIMAP_BUTTON"]      = "Afficher le bouton de minicarte"
L["SHOW_MINIMAP_BUTTON_HELP"] = "Clic gauche ouvre la config, clic droit ouvre les paramètres rapides. Le bouton du compartiment est toujours disponible."
L["HIDE_LOGIN_MSG"]           = "Masquer le message de connexion"
L["HIDE_LOGIN_MSG_HELP"]      = "Masque le message \"BigChatBox chargé\" à la connexion."
L["KEYBIND_OPEN_BLIZZARD"]    = "Ouvrir le chat Blizzard :"
L["KEYBIND_NOT_BOUND"]        = "Non lié"
L["KEYBIND_PRESS_KEY"]        = "Appuyez sur une touche..."
L["KEYBIND_CONFLICT"]         = "%s est déjà lié à %s. Remplacer ?"
L["KEYBIND_TOOLTIP_BOUND"]    = "Ouvrir le chat Blizzard (%s)"
L["KEYBIND_TOOLTIP_UNBIND"]   = "Clic droit pour délier"
L["KEYBIND_TOOLTIP_SET"]      = "Cliquez pour définir un raccourci"
L["KEYBIND_HELP"]             = "Ouvre le chat natif de Blizzard pour le Maj+clic sur les montures, succès, jouets et talents. Défaut : Ctrl+Entrée."
L["RESET_ALL"]                = "Tout réinitialiser"
L["RESET_APPEARANCE"]         = "Réinitialiser l'apparence"
L["RESET_PLACEMENT"]          = "Réinitialiser le placement"
L["RESET_HISTORY_BTN"]        = "Réinitialiser l'historique"
L["RESET_SNIPPETS_BTN"]       = "Réinitialiser les extraits"
L["RESET_STYLES_BTN"]         = "Réinitialiser les styles"
L["RESTART_SETUP"]            = "Relancer l'assistant"

-- ── Reset / action confirmations (StaticPopupDialogs) ────────────────────────
L["POPUP_RESET_ALL"]          = "Réinitialiser TOUS les paramètres de BigChatBox ?\nCela inclut la position, la taille, l'apparence et les polices."
L["POPUP_RESET_APPEARANCE"]   = "Réinitialiser l'apparence par défaut ?\nN'affecte pas la position ni l'historique."
L["POPUP_RESET_PLACEMENT"]    = "Réinitialiser le placement par défaut ?\nCela rechargera l'interface."
L["POPUP_RESET_HISTORY"]      = "Réinitialiser tout l'historique de chat et de chuchotements ?\nLa longueur de l'historique sera fixée à 100.\nCela rechargera l'interface."
L["POPUP_RESET_SNIPPETS"]     = "Supprimer tous les extraits ? Cela rechargera l'interface."
L["POPUP_RESET_STYLES"]       = "Supprimer TOUS les styles créés par l'utilisateur ?\nLe style par défaut sera conservé et deviendra actif.\nCela rechargera l'interface."
L["POPUP_WIPE_HISTORY"]       = "Effacer tout l'historique de chat ?\nCela rechargera également l'interface."
L["POPUP_WIPE_COMMANDS"]      = "Supprimer toutes les /commandes de l'historique ?\nLes messages normaux seront conservés.\nCela rechargera également l'interface."
L["POPUP_DELETE_STYLE"]       = "Supprimer le style actuel ?"
L["POPUP_OVERWRITE_STYLE"]    = "Un style nommé '%s' existe déjà. L'écraser ?"
L["POPUP_SAVE_STYLE_TEXT"]    = "Entrez un nom pour ce style :"
L["POPUP_EXPORT_STYLE_TEXT"]  = "Copiez la chaîne de style ci-dessous :"
L["POPUP_IMPORT_STYLE_TEXT"]  = "Collez une chaîne de style ci-dessous :"
L["POPUP_NAME_IMPORT_STYLE"]  = "Enregistrer le style importé sous :"
L["POPUP_DELETE_SNIPPET"]     = "Supprimer l'extrait '%s' ?"
L["POPUP_SHARE_SNIPPET_TEXT"] = "Copiez la chaîne d'extrait (Ctrl+C) :"
L["POPUP_IMPORT_SNIPPET_TEXT"] = "Collez la chaîne d'extrait (Ctrl+V) :"
L["POPUP_RESTART_SETUP"]      = "Cela réinitialisera TOUS les paramètres et relancera l'assistant.\nÊtes-vous sûr ?"
L["POPUP_QUIT_SETUP"]         = "Voulez-vous vraiment quitter la configuration ?\nLes paramètres par défaut seront utilisés."
L["BTN_RESET_ALL_CONFIRM"]    = "Tout réinitialiser"
L["BTN_WIPE_CONFIRM"]         = "Oui, effacer"
L["BTN_DELETE_CONFIRM"]       = "Supprimer"
L["BTN_OVERWRITE_CONFIRM"]    = "Écraser"
L["BTN_SKIP"]                 = "Ignorer"
L["BTN_RESTART_SETUP_CONFIRM"] = "Relancer l'assistant"
L["BTN_QUIT_SETUP_CONFIRM"]   = "Quitter la config"
L["BTN_SAVE_CLOSE"]           = "Fermer"

-- ── Slash commands / print messages ──────────────────────────────────────────
L["SLASH_POSITION_RESET"]     = "Position réinitialisée par défaut"
L["SLASH_ANCHOR_UNAVAILABLE"] = "Éditeur d'ancrage non disponible."
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox :|r Historique de chat effacé."
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox :|r Apparence réinitialisée par défaut"
L["RESET_DONE"]               = "Tous les paramètres ont été réinitialisés par défaut."
L["COMBAT_CLOSE"]             = "Config fermée -- entrée en combat."
L["COMBAT_BLOCKED"]           = "Impossible d'ouvrir la config en combat."

-- ── Position / size labels (legacy keys) ─────────────────────────────────────
L["POSITION"]        = "Position"
L["X_POSITION"]      = "Position X"
L["Y_POSITION"]      = "Position Y"
L["SIZE"]            = "Taille"
L["WIDTH"]           = "Largeur"
L["HEIGHT"]          = "Hauteur"
L["SCALE"]           = "Échelle"
L["FONT_SIZES"]      = "Tailles de police"
L["INPUT_FONT_SIZE"] = "Taille de police de saisie"
L["CHANNEL_FONT_SIZE"] = "Taille de police du canal"
L["FONTS"]           = "Polices"
L["INPUT_FONT"]      = "Police de saisie"
L["CHANNEL_FONT"]    = "Police du canal"
L["BACKGROUND"]      = "Arrière-plan"
L["BG_TEXTURE"]      = "Texture d'arrière-plan"
L["BG_TRANSPARENCY"] = "Opacité de l'arrière-plan"
L["BG_BRIGHTNESS"]   = "Luminosité de l'arrière-plan"
L["BG_SCALE"]        = "Échelle de l'arrière-plan"
L["BORDER"]          = "Bordure"
L["BORDER_TEXTURE"]  = "Texture de bordure"
L["BORDER_TRANSPARENCY"] = "Opacité de la bordure"
L["BORDER_BRIGHTNESS"]   = "Luminosité de la bordure"
L["BORDER_THICKNESS"]    = "Épaisseur de la bordure"
L["TEXT_OPTIONS"]    = "Options de texte"
L["MATCH_TEXT_COLOR"] = "Faire correspondre la couleur du texte au canal"
L["SHOW_OUTLINE"]    = "Afficher le contour du texte"
L["SHOW_SHADOW"]     = "Afficher l'ombre du texte"
L["DROP_SHADOW"]     = "Ombre portée sur la zone de saisie"
L["TEXT_ALIGN"]      = "Alignement du texte"
L["CHAT_HISTORY"]    = "Historique de chat"
L["HISTORY_LENGTH"]  = "Longueur de l'historique"
L["WIPE_HISTORY"]    = "Effacer tout l'historique"
L["RECENT_WHISPERS"] = "Chuchotements récents"
L["SNIPPETS"]        = "Extraits"
L["SNIPPET_TRIGGER"] = "Déclencheur"
L["SNIPPET_TEXT"]    = "Texte"
L["SNIPPET_SAVE"]    = "Enregistrer"
L["SNIPPET_DELETE"]  = "Supprimer"
L["SNIPPET_NEW"]     = "Nouvel extrait"
L["SNIPPET_SHARE"]   = "Partager l'extrait"
L["SNIPPET_EXPORT"]  = "Tout exporter"
L["SNIPPET_IMPORT"]  = "Importer"
L["SNIPPET_RESET"]   = "Réinitialiser les extraits"
L["AUTOCOMPLETE"]    = "Autocomplétion"
L["AUTOCOMPLETE_POS"] = "Position de l'autocomplétion"
L["CHANNEL_POS"]     = "Position du nom de canal"
L["AUTO_HIDE_CHANNEL"] = "Masquer automatiquement le nom du canal (afficher au survol)"
L["LAYOUT_OPTIONS"]  = "Options de mise en page"
L["ANCHOR_EDITOR"]   = "Éditeur d'ancrage"
L["OPEN_ANCHOR_EDITOR"] = "Ouvrir l'éditeur d'ancrage"
L["ABOUT"]           = "À propos"
L["ABOUT_DESC"]      = "Une grande zone de saisie de chat personnalisable avec affichage du canal, éditeur d'ancrage et contrôle complet de l'apparence."
L["PROFILES"]        = "Profils"
L["SAVE_STYLE"]      = "Enregistrer le style"
L["DELETE_STYLE"]    = "Supprimer le style"
L["DYNAMIC_HEIGHT"]  = "Hauteur dynamique"
L["DYNAMIC_WIDTH"]   = "Largeur dynamique"
L["CHAR_COUNTER_POS"] = "Position du compteur de caractères"
L["LONG_MESSAGES"]   = "Longs messages"
L["LONG_MSG_OFF"]    = "Désactivé"
L["LONG_MSG_SILENT"] = "Silencieux"
L["LONG_MSG_NOTICE"] = "Avis"
L["LONG_MSG_CONFIRM"] = "Confirmer"
L["LONG_MSG_DESC_OFF"]     = "Le message est coupé à 255 caractères (comportement WoW par défaut)."
L["LONG_MSG_DESC_SILENT"]  = "Divisé automatiquement en plusieurs messages."
L["LONG_MSG_DESC_NOTICE"]  = "Divise et affiche combien de parties ont été envoyées."
L["LONG_MSG_DESC_CONFIRM"] = "Demande une confirmation avant de diviser."
L["IMPORT_STYLE_BTN"]  = "Importer une chaîne de style"
L["FINISH_CONFIG_BTN"] = "Terminer + Config"
L["BG_COLOR"]          = "Couleur d'arrière-plan"
L["MSG_SPLIT_NOTICE"]  = "Message divisé en %d parties (%d caractères)."

-- ── v5.3.3 Keybinding strings ─────────────────────────────────────────────────
L["HELP_KEYBINDINGS_TITLE"] = "-- Raccourcis clavier --"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+Entrée bascule vers le chat par défaut de Blizzard (fonctionne partout).\nUtile pour le Maj+clic sur les objets qui ne s'insèrent pas dans BCB (montures,\nsuccès, boîte à jouets, talents, livre de sorts). Tapez dans la zone Blizzard,\npuis appuyez sur Entrée pour envoyer. BCB reprend à votre prochain appui sur Entrée.\n\nVous pouvez relier ou délier cette touche dans l'onglet Avancé ou dans\nÉchap > Raccourcis clavier > Extensions > BigChatBox."

-- ── v5.5.0 Welcome Panel ─────────────────────────────────────────────────────
L["WELCOME_TITLE"]          = "Bienvenue dans BigChatBox !"
L["WELCOME_SUBTITLE"]       = "Configuration initiale"
L["WELCOME_TEXT"]           = "BigChatBox remplace la petite zone de saisie de chat de WoW par une grande zone entièrement personnalisable.\n\nVous pouvez changer la taille, l'arrière-plan, la bordure, les polices et les couleurs -- ou choisir un style prêt à l'emploi. Des fonctions comme l'historique de chat, les extraits de texte et l'autocomplétion intelligente sont intégrées et peuvent être activées ou désactivées.\n\nCette configuration rapide vous permettra de démarrer en moins d'une minute."
L["WELCOME_SETUP_BTN"]      = "Configurer BigChatBox"
L["WELCOME_LANG_LBL"]       = "Langue d'affichage :"
L["WELCOME_STYLE_TITLE"]    = "Choisissez votre style !"
L["WELCOME_LAYOUT_TITLE"]   = "Choisissez votre mise en page"
L["WELCOME_FEATURES_TITLE"] = "Choisissez vos fonctions !"
L["WELCOME_ADVANCED_TITLE"] = "Fonctions avancées"
L["WELCOME_FINAL_TITLE"]    = "Presque terminé !"
L["WELCOME_FINISH_BTN"]     = "Terminer !"
L["WELCOME_QUIT_CONFIRM"]   = "Voulez-vous vraiment quitter la configuration ? Les paramètres par défaut seront utilisés."
L["WELCOME_KEYBIND_INFO"]   = "La plupart des insertions de liens par Maj+clic fonctionnent directement dans BigChatBox. Pour les rares exceptions (montures, jouets, talents), ce raccourci bascule vers la saisie de chat de Blizzard."
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBox se met automatiquement en pause pendant le combat, les M+, les arènes et les champs de bataille notés pour protéger votre chat."
L["WELCOME_THANKS"]         = "Merci d'utiliser BigChatBox !"
L["WELCOME_SECURE_TITLE"]   = "Contenu sécurisé"
L["WELCOME_KEYBIND_TITLE"]  = "Raccourci chat Blizzard"
L["WELCOME_CONFIG_HINT"]    = "Tapez /bcb pour ouvrir la fenêtre des paramètres complets à tout moment."
L["FEATURE_HISTORY_DESC"]   = "Sauvegarde vos messages envoyés avec horodatages."
L["FEATURE_SNIPPETS_DESC"]  = "Raccourcis texte développés quand vous appuyez sur Entrée."
L["FEATURE_AC_SNIPPETS_DESC"]  = "Autocomplète les déclencheurs d'extraits commençant par !"
L["FEATURE_AC_COMMANDS_DESC"]  = "Autocomplète les commandes comme /dance, /guilde."
L["FEATURE_AC_WHISPERS_DESC"]  = "Autocomplète les noms de joueurs pour les chuchotements."
L["FEATURE_MOUSEWHEEL_DESC"]   = "Faites défiler les messages précédents avec la molette."
L["FEATURE_GLOBAL_PROFILE_DESC"] = "Partagez les paramètres entre tous les personnages de ce compte."
L["FEATURE_KEEP_OPEN_DESC"]    = "La zone de saisie reste visible quand vous cliquez ailleurs."
L["RESTART_SETUP_CONFIRM"]  = "Cela réinitialisera TOUS les paramètres et relancera l'assistant. Êtes-vous sûr ?"

-- ── v5.6.0 Patch notes UI ────────────────────────────────────────────────────
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox -- Nouveautés"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox -- Notes de mise à jour"
L["PATCHNOTES_DONT_SHOW"]      = "Ne plus afficher"
L["PATCHNOTES_GOT_IT"]         = "Compris !"
L["PATCHNOTES_PREVIOUS"]       = "-- Mises à jour précédentes --"

-- ── Keys added during source wiring (v5.6.0 localization pass) ───────────────

-- Features tab
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffffDésactivé|r -- Le message est coupé à 255 caractères (comportement WoW par défaut).\n|cffffffffSilencieux|r -- Divisé automatiquement en plusieurs messages.\n|cffffffffAvis|r -- Divise et indique combien de parties ont été envoyées.\n|cffffffffConfirmer|r -- Demande une confirmation avant de diviser."

-- Snippets tab
L["SNIPPET_NOTHING_TO_EXPORT"] = "Aucun extrait à exporter."

-- History tab
L["HISTORY_LENGTH_LABEL"] = "Longueur de l'historique"

-- ConfigMain print messages
L["PRINT_RESET_ALL"]         = "Tous les paramètres réinitialisés par défaut. Rechargement..."
L["PRINT_RESET_APPEARANCE"]  = "Apparence réinitialisée. Rechargement..."
L["PRINT_RESET_PLACEMENT"]   = "Placement réinitialisé. Rechargement..."
L["PRINT_RESET_HISTORY"]     = "Historique réinitialisé. Rechargement..."
L["PRINT_SNIPPETS_REMOVED"]  = "Tous les extraits supprimés."
L["PRINT_STYLES_REMOVED"]    = "Tous les styles personnalisés supprimés."
L["PRINT_NO_STYLE_STRING"]   = "Aucune chaîne de style fournie."
L["PRINT_STYLE_DECODE_FAIL"] = "Échec du décodage de la chaîne de style. Elle est peut-être corrompue."
L["PRINT_STYLE_INVALID"]     = "Chaîne de style invalide. Préfixe !BCB1: ou BCB: attendu."
L["PRINT_STYLE_IMPORTED"]    = "Style importé !"
L["PRINT_STYLE_SAVED"]       = "Style '%s' enregistré."
L["PRINT_STYLE_DELETED"]     = "Style '%s' supprimé."
L["PRINT_SNIPPET_INVALID"]   = "Chaîne d'extrait invalide."
L["PRINT_SNIPPET_REMOVED"]   = "Extrait '%s' supprimé."
L["PRINT_SNIPPETS_IMPORTED"] = "%d extrait(s) importé(s)."
L["PRINT_SNIPPETS_SKIPPED"]  = " %d ignoré(s) (déjà existants)."
L["PRINT_CANT_DELETE_DEFAULT"] = "Impossible de supprimer le style par défaut."
L["PRINT_SETUP_SKIPPED"]     = "Configuration ignorée. Tapez |cff55ccff/bcb|r à tout moment pour configurer."
L["BTN_RESET_STYLES_CONFIRM"] = "Réinitialiser les styles"

-- SlashCommands popups
L["POPUP_WIPE_WHISPERS"]     = "Effacer l'historique des chuchotements ? Cette action est irréversible."

-- WelcomePanel
L["WELCOME_CHOOSE_STYLE"]      = "Choisissez un style :"
L["WELCOME_STYLE_NOTE"]        = "Les styles marqués avec des noms d'extension nécessitent ces extensions.\nVous pouvez tout personnaliser dans l'onglet Concepteur."
L["WELCOME_LAYOUT_DESC"]       = "Choisissez où le nom du canal et l'autocomplétion apparaissent par rapport à la zone de saisie."
L["WELCOME_CHANNEL_POS_LBL"]   = "Position du nom de canal :"
L["WELCOME_AC_POS_LBL"]        = "Position de l'autocomplétion :"
L["WELCOME_AUTOHIDE_HELP"]     = "Le nom du canal s'estompe jusqu'à ce que vous survoliez la zone de saisie."
L["WELCOME_CHARCOUNTER_LBL"]   = "Position du compteur de caractères :"
L["WELCOME_FEATURES_DESC"]     = "Activez les fonctions souhaitées. Toutes sont activées par défaut.\nVous pouvez les modifier à tout moment dans l'onglet Fonctions."
L["WELCOME_LONGMSG_LBL"]       = "Longs messages (plus de 255 caractères) :"
L["LONGMSG_DESC_OFF"]          = "Coupé à 255 caractères"
L["LONGMSG_DESC_SILENT"]       = "Division automatique"
L["LONGMSG_DESC_NOTICE"]       = "Division avec avis"
L["LONGMSG_DESC_CONFIRM"]      = "Demander avant de diviser"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "En savoir plus sur le verrouillage combat"
L["WELCOME_WHY_KEYBIND"]       = "Pourquoi cela existe-t-il ?"
L["WELCOME_CURRENT_KEYBIND"]   = "Raccourci actuel :"
L["WELCOME_KEYBIND_CLICK_HINT"] = "Cliquer pour définir · Clic droit pour délier"
L["WELCOME_OPEN_HELP"]         = "Ouvrir la fenêtre Aide et astuces"
L["WELCOME_HELP_DESC"]         = "Toutes les commandes, raccourcis et détails des fonctions sont disponibles dans la fenêtre d'aide."
L["WELCOME_RELOAD_NOTE"]       = "Les deux boutons rechargeront votre interface."
L["WELCOME_COMBAT_PAUSE"]      = "Configuration en pause -- entrée en combat."
L["WELCOME_SHIFTCLICK_TITLE"]  = "Insertion de lien par Maj+clic"
L["WELCOME_FEAT_HISTORY"]      = "Historique de chat"
L["WELCOME_FEAT_SNIPPETS"]     = "Système d'extraits"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "Autocomplétion : !Extraits"
L["WELCOME_FEAT_AC_COMMANDS"]  = "Autocomplétion : /Commandes"
L["WELCOME_FEAT_AC_WHISPER"]   = "Autocomplétion : Noms de joueurs"
L["WELCOME_FEAT_AC_BNET"]      = "Autocomplétion : Amis Battle.net"
L["WELCOME_FEAT_KEEP_OPEN"]    = "Garder la zone de saisie ouverte"

-- WelcomePanel navigation
L["BTN_PREVIOUS"]  = "Précédent"
L["BTN_NEXT"]      = "Suivant"

-- ── Language selector (Advanced tab) ─────────────────────────────────────────
L["SECTION_LANGUAGE"]        = "Langue"
L["LANGUAGE_DESC"]           = "Remplacer la langue d'affichage. Nécessite un rechargement de l'interface."
L["LANGUAGE_CLIENT"]         = "Langue du client"
L["LANGUAGE_RELOAD_MSG"]     = "Langue modifiée. Rechargement de l'interface..."
L["POPUP_CHANGE_LANGUAGE"]   = "Changer la langue et recharger l'interface ?"
L["BTN_RELOAD_CONFIRM"]      = "Recharger"
L["LANGUAGE_COMING_SOON"]    = "|cff888888(Bientôt disponible)|r"

-- ── Help popup body strings ───────────────────────────────────────────────────
L["HELP_WINDOW_TITLE"] = "Aide BigChatBox"

L["HELP_BODY_MAIN"] = [[|cffffd100-- Commandes --|r
|cffffd100/bcb|r ou |cffffd100/bcb config|r -- Ouvrir la fenêtre des paramètres.
|cffffd100/bcb edit|r -- Ouvrir l'éditeur d'ancrage pour repositionner.
|cffffd100/bcb reset|r -- Réinitialiser la position par défaut.

|cffffd100-- Bases du chat --|r
|cffffd100Clic gauche|r sur le nom du canal pour changer de canal (Dire, Groupe, Guilde, etc.).
|cffffd100Clic droit|r sur le nom du canal pour la config, l'historique et les options d'effacement.
|cffffd100Entrée|r envoie votre message. |cffffd100Échap|r efface et ferme.
La |cffffd100molette|r sur la zone de saisie fait défiler l'historique de chat.

|cffffd100-- Autocomplétion --|r
Tapez |cffffd100/|r pour voir les commandes correspondantes (Tab pour cycler, Entrée pour confirmer).
Tapez |cffffd100!|r pour autocomplèter les déclencheurs d'extraits (ex. !guilde, !inv).
Les noms de chuchotements s'autocomplètent depuis les amis, la guilde, le groupe et les récents.
|cffffd100Tab|r / |cffffd100Maj+Tab|r pour cycler parmi les suggestions.

|cffffd100-- Extraits --|r
Définissez des raccourcis texte développés quand vous appuyez sur Entrée.
Exemple : !guilde peut se développer en « RCH Mythique+ chuchotez pour invitation ! »
Chaque extrait peut être restreint à des canaux spécifiques.
Gérez, créez, importez et exportez dans l'onglet |cff5599ffExtraits|r.

|cffffd100-- Insertion de liens --|r
|cffffd100Maj+clic|r sur des objets, sorts, succès, etc. pour insérer des liens.
Fonctionne depuis les sacs, le livre de sorts, le panneau de succès, les métiers et le chat.
|cffffd100Survolez|r les liens dans la zone de saisie pour prévisualiser les infobulles.
Pour les panneaux sans insertion directe, consultez le bouton |cff5599ffInfo clic Maj|r.

|cffffd100-- Personnalisation --|r
L'onglet |cff5599ffConcepteur|r permet de personnaliser l'arrière-plan, la bordure, les polices et les couleurs.
L'onglet |cff5599ffPlacement|r contient l'éditeur d'ancrage pour un positionnement précis.
Sauvegardez votre apparence sous un style nommé. Exportez et importez des chaînes de style.
Les textures et polices LibSharedMedia sont supportées si vous avez LSM installé.

|cffffd100-- Outils et bascules --|r
L'onglet |cff5599ffFonctions|r permet d'activer ou désactiver chaque fonction :
autocomplétion, extraits, infobulles au survol, historique de chat, et plus.
Le mode |cffffd100Garder ouvert|r garde la zone de saisie visible même quand elle perd le focus.

|cffffd100-- Profils et styles --|r
Les paramètres sont sauvegardés par personnage par défaut.
Activez |cffffd100Utiliser pour tous les personnages|r dans Avancé pour partager les paramètres globalement.
Les styles sauvegardent votre apparence visuelle (arrière-plan, bordure, polices, couleurs).
Utilisez Exporter/Importer pour partager des styles avec des amis ou entre personnages.

|cffffd100-- Position et taille --|r
L'éditeur d'ancrage vous permet de cliquer-glisser la zone vers une nouvelle position.
Les touches directionnelles déplacent d'1 pixel à la fois pour la précision.
Maj+glisser redimensionne la zone symétriquement.
|cffffd100Maj+Alt+Clic|r sur la zone réinitialise sa position au centre.
Vous pouvez aussi définir des valeurs de position et taille exactes dans le panneau info.

|cffffd100-- Longs messages --|r
Les messages dépassant 255 caractères peuvent être divisés automatiquement.
Configurez le comportement dans l'onglet |cff5599ffFonctions|r : Désactivé, Silencieux, Avis, ou Confirmer.
Un compteur de caractères indique votre proximité avec la limite.

|cffffd100-- Taille dynamique --|r
Activez |cffffd100Hauteur dynamique|r et |cffffd100Largeur dynamique|r dans l'onglet Concepteur.
La hauteur s'adapte à la taille de police, la largeur croît avec la longueur du message.]]

L["HELP_BODY_SECURE"] = "|cffffd100-- Pourquoi BigChatBox se met-il en pause pendant le combat / M+ etc. --|r\n\n" ..
    "Avec l'extension Minuit (12.0), Blizzard a introduit des changements majeurs dans la façon dont les extensions interagissent avec le jeu pendant le combat. Cette initiative, appelée |cff5599ffDésarmement des extensions|r, limite ce que les extensions peuvent faire avec les informations de combat.\n\n" ..
    "|cffffd100Qu'est-ce qui a changé ?|r\n" ..
    "Les données liées au combat sont désormais traitées comme des |cffff9900« valeurs secrètes »|r. Les extensions peuvent afficher ces informations mais ne peuvent pas les lire ni les traiter dans leur code.\n\n" ..
    "De nombreux cadres d'interface sont maintenant |cffff9900protégés|r pendant le combat. Dans le contenu instancié (M+, arènes, champs de bataille notés), les restrictions sont encore plus strictes. Toute extension qui modifie ou s'accroche à ces cadres protégés risque de propager une |cffff6666contamination|r, ce qui peut briser complètement les fonctionnalités du jeu -- pas seulement l'extension, mais des fonctions essentielles comme cibler, lancer des sorts et utiliser des capacités.\n\n" ..
    "|cffffd100Comment cela affecte-t-il BigChatBox ?|r\n" ..
    "La zone de saisie de chat par défaut de WoW (ChatFrame1EditBox) est un cadre protégé car elle traite des commandes sécurisées comme /cible, /lancer et /focus. BigChatBox s'accroche à ce cadre pour intercepter la saisie de chat. Pendant le combat et le contenu compétitif instancié, ces crochets peuvent provoquer une contamination qui bloquerait tout votre système de chat.\n\n" ..
    "Pour vous protéger, BigChatBox |cff00ff00se met automatiquement en pause|r pendant le combat et pendant les M+, arènes et champs de bataille notés. La zone de saisie par défaut de Blizzard prend le relais sans interruption. Quand le combat se termine ou que le contenu est terminé, BigChatBox reprend automatiquement.\n\n" ..
    "|cffffd100Pourquoi ne pas simplement le corriger ?|r\n" ..
    "Ce n'est pas un |cffff0000bug !|r C'est une restriction fondamentale dans le modèle de sécurité de WoW. Chaque extension qui modifie des cadres protégés pendant le combat fait face à la même limitation. Blizzard a conçu ces restrictions pour empêcher les extensions d'automatiser les décisions de combat, et la zone de saisie de chat entre dans ce périmètre protégé.\n\n" ..
    "|cffffd100En résumé|r\n" ..
    "BigChatBox se met en pause pendant le combat et pendant les instances compétitives chronométrées (M+, arènes, champs de bataille notés). Vous pouvez toujours chatter normalement pendant ces activités en utilisant la saisie de chat intégrée de Blizzard. BigChatBox reprend automatiquement quand le combat se termine ou que l'activité est complète."

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100-- Pourquoi les Maj+clics ne fonctionnent-ils pas tous ? --|r\n\n" ..
    "La plupart des insertions de liens par Maj+clic fonctionnent directement dans BigChatBox. Cependant, quelques panneaux du jeu utilisent des fonctions internes de Blizzard qui n'insèrent des liens que dans la propre zone de saisie de Blizzard, contournant toute zone de saisie d'extension.\n\n" ..
    "|cff00ff00Fonctionne dans BigChatBox :|r\n" ..
    "  · Objets des sacs personnels\n" ..
    "  · Familiers du journal de familiers\n" ..
    "  · Héritages du panneau de héritages\n" ..
    "  · Objets des panneaux de vendeurs\n" ..
    "  · Objets de la boîte aux lettres\n" ..
    "  · Recettes et réactifs des métiers\n" ..
    "  · Liens depuis la fenêtre de chat\n\n" ..
    "|cffff9900Nécessite le chat Blizzard :|r\n" ..
    "  · Succès du panneau de succès\n" ..
    "  · Objets du panneau de banque\n" ..
    "  · Objets de la banque de guilde\n" ..
    "  · Montures du journal de montures\n" ..
    "  · Talents du panneau de talents\n" ..
    "  · Apparences de la garde-robe\n" ..
    "  · Certains panneaux propres à l'extension\n\n" ..
    "|cffffd100Pourquoi ?|r\n" ..
    "Ces panneaux utilisent la fonction interne |cff5599ffChatEdit_InsertLink|r de WoW qui vérifie spécifiquement la zone de saisie de Blizzard. BigChatBox intercepte la plupart de ces appels, mais certains panneaux contournent entièrement le crochet standard en raison de leur implémentation par Blizzard. C'est une limitation de l'API de WoW, pas un bug.\n\n" ..
    "|cffffd100La solution|r\n" ..
    "Le |cff5599ffRaccourci chat Blizzard|r (défaut : Ctrl+Entrée) bascule instantanément vers la saisie de chat native de Blizzard. Tapez ou faites un Maj+clic sur ce dont vous avez besoin, appuyez sur Entrée pour envoyer, et BigChatBox reprend automatiquement à votre prochain message.\n\n" ..
    "Vous pouvez relier ou délier cette touche dans :\n" ..
    "  · |cffffd100/bcb|r > onglet Avancé\n" ..
    "  · Échap > Raccourcis clavier > Extensions > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "Passer en %s et relancer la configuration ?\nBigChatBox rechargera pour appliquer la nouvelle langue."

-- ── v5.6.1 Emoji & Emoticon picker ───────────────────────────────────────────
L["SECTION_EMOJI"]          = "Sélecteur d'émoticônes"
L["CB_SHOW_EMOJI_PICKER"]   = "Afficher le bouton du sélecteur d'émoticônes"
L["EMOJI_PICKER_TITLE"]     = "Sélecteur d'émoticônes"
L["EMOJI_PICKER_TOOLTIP"]   = "Cliquez pour ouvrir le sélecteur d'émoticônes"
L["EMOJI_TAB_LAST"]         = "Derniers utilisés"
L["EMOJI_TAB_ASCII"]        = "Émoticônes"
L["EMOJI_LAST_EMPTY"]       = "Aucune sélection récente."

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "Rechercher dans l'historique..."

L["BTN_SAVE_SNIPPET"]           = "Sauvegarder"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "Utiliser le style par défaut"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "Si coché, la zone multiligne utilise le style par défaut quel que soit le style actif. Décocher pour utiliser l'apparence BCB actuelle."

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "Saisie multiligne"
L["CB_ENABLE_MULTILINE"]        = "Activer la saisie multiligne"
L["CB_ENABLE_MULTILINE_HELP"]   = "Ouvre une grande zone multiligne pour rédiger des messages. Chaque ligne est envoyée séparément."
L["KEYBIND_OPEN_MULTILINE"]     = "Ouvrir la saisie multiligne :"
L["MULTILINE_KEYBIND_HELP"]     = "Par défaut : Maj+Entrée. Ouvre une grande zone de saisie où Entrée ajoute une nouvelle ligne et Maj+Entrée envoie toutes les lignes."
L["BTN_OPEN_KEYBINDINGS"]       = "Ouvrir les raccourcis clavier"
L["MULTILINE_SEND_BTN"]         = "Envoyer"
L["MULTILINE_CHANNEL_LABEL"]    = "Canal : %s"
L["MULTILINE_BLOCKED_SECURE"]   = "La saisie multiligne n'est pas disponible en M+/Arène/Champ de bataille noté."
L["MULTILINE_HINT"]             = "Entrée = nouvelle ligne   |   Maj+Entrée = tout envoyer"
