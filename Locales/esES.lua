-- BigChatBox Localization - Spanish (esES / esMX)
-- Version: 5.6.1
local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "esES" and GetLocale() ~= "esMX" and (BigChatBox and BigChatBox._forcedLocale) ~= "esES" then return end

-- !! Addon identity !!---------------------------------------------------------
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "Version"
L["LOADED_MSG"]   = "BigChatBox v%s cargado. Escribe /bcb para abrir opciones."

-- !! Config window tabs !!------------------------------------------------------
L["TAB_GENERAL"]   = "General"
L["TAB_DESIGNER"]  = "Disenador"
L["TAB_PLACEMENT"] = "Posicion"
L["TAB_FEATURES"]  = "Funciones"
L["TAB_SNIPPETS"]  = "Fragmentos"
L["TAB_HISTORY"]   = "Historial"
L["TAB_ADVANCED"]  = "Avanzado"
L["TAB_RESET"]     = "Restablecer"

-- !! Reset tab !!---------------------------------------------------------------
L["RESET_TAB_HEADER"]       = "Restablecer y restaurar"
L["RESET_TAB_DESC"]         = "Estas acciones son permanentes y no se pueden deshacer."
L["RESET_ALL_HELP"]         = "Restablece todo: posicion, apariencia, historial y fragmentos."
L["RESET_APPEARANCE_HELP"]  = "Restablece solo el fondo, el borde, la fuente y los colores."
L["RESET_PLACEMENT_HELP"]   = "Restablece la posicion y el tamano a los valores predeterminados."
L["RESET_HISTORY_HELP"]     = "Borra todo el historial de chat y susurros guardado."
L["RESET_SNIPPETS_HELP"]    = "Elimina todos los fragmentos."
L["RESET_STYLES_HELP"]      = "Elimina todos los estilos personalizados guardados."
L["RESTART_SETUP_HELP"]     = "Restablece todos los ajustes y vuelve a ejecutar el asistente de configuracion inicial."

-- !! Shared UI !!---------------------------------------------------------------
L["PREVIEW"]        = "Vista previa"
L["TYPE_SOMETHING"] = "Escribe algo..."
L["CLOSE"]          = "Cerrar"
L["ACTIONS"]        = "Acciones"
L["RESET"]          = "Restablecer"
L["OK"]             = "Aceptar"
L["CANCEL"]         = "Cancelar"
L["YES"]            = "Si"
L["NO"]             = "No"
L["SAVE"]           = "Guardar"
L["DELETE"]         = "Eliminar"
L["EDIT"]           = "Editar"
L["IMPORT"]         = "Importar"
L["EXPORT"]         = "Exportar"
L["DUPLICATE"]      = "Duplicar"
L["SHARE"]          = "Compartir"
L["ENABLED"]        = "Activado"
L["DISABLED"]       = "Desactivado"

-- !! General tab !!-------------------------------------------------------------
L["BTN_VIEW_PATCH_NOTES"]     = "Ver notas del parche"
L["BTN_HELP_AND_TIPS"]        = "Ayuda y consejos"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "Info sobre bloqueo en combate"
L["BTN_SHIFT_CLICK_INFO"]     = "Info sobre Shift+clic"

L["CELL_SNIPPETS_HDR"]       = "|cff5599ffFragmentos|r"
L["CELL_SNIPPETS_DESC"]      = "Atajos de texto que se expanden al enviar.\nGestionados en la pestana Fragmentos."
L["CELL_ANCHOR_HDR"]         = "|cff5599ffEditor de anclaje|r"
L["CELL_ANCHOR_DESC"]        = "Haz clic y arrastra para reposicionar.\nTeclas de direccion para precision pixel."
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ffAutocompletar|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "Completado inteligente con Tab para comandos,\nsusurros y fragmentos (!guild)."
L["CELL_HISTORY_HDR"]        = "|cff5599ffHistorial de chat|r"
L["CELL_HISTORY_DESC"]       = "Historial completo con marcas de tiempo.\nDesplazate con la rueda del raton."
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ffPersonalizacion|r"
L["CELL_CUSTOMIZATION_DESC"] = "Pestana Disenador para fondo, borde,\nfuente y colores. Guarda y comparte estilos."
L["CELL_SECURE_HDR"]         = "|cffff9900Contenido seguro|r"
L["CELL_SECURE_DESC"]        = "Se pausa automaticamente en M+, arena\ny BG clasificado para proteger el chat."
L["CELL_SHARING_HDR"]        = "|cff5599ffCompartir|r"
L["CELL_SHARING_DESC"]       = "Exporta estilos y fragmentos como cadenas\ncortas para compartir con amigos."
L["CELL_LONGMSG_HDR"]        = "|cff5599ffMensajes largos|r"
L["CELL_LONGMSG_DESC"]       = "Los mensajes de mas de 255 caracteres\nse dividen automaticamente."

-- !! Styles (Designer tab) !!---------------------------------------------------
L["STYLES"]              = "Estilos"
L["ACTIVE_STYLE"]        = "Estilo activo"
L["BTN_SAVE_STYLE"]      = "Guardar estilo"
L["BTN_DELETE_STYLE"]    = "Eliminar estilo"
L["BTN_EXPORT_STYLE"]    = "Exportar estilo"
L["BTN_IMPORT_STYLE"]    = "Importar estilo"

-- !! Designer tab sections !!---------------------------------------------------
L["SECTION_SIZE"]         = "Tamano"
L["SECTION_BACKGROUND"]   = "Fondo"
L["SECTION_BORDER"]       = "Borde"
L["SECTION_FONTS"]        = "Fuentes"
L["SECTION_TEXT_OPTIONS"] = "Opciones de texto"

L["LABEL_WIDTH"]              = "Ancho"
L["LABEL_HEIGHT"]             = "Altura"
L["LABEL_SCALE"]              = "Escala"
L["LABEL_BG_TEXTURE"]         = "Textura de fondo"
L["LABEL_BG_OPACITY"]         = "Opacidad del fondo"
L["LABEL_BG_BRIGHTNESS"]      = "Brillo del fondo"
L["LABEL_BG_SCALE"]           = "Escala del fondo"
L["LABEL_TINT_INTENSITY"]     = "Intensidad del tinte"
L["LABEL_BORDER_TEXTURE"]     = "Textura del borde"
L["LABEL_BORDER_OPACITY"]     = "Opacidad del borde"
L["LABEL_BORDER_BRIGHTNESS"]  = "Brillo del borde"
L["LABEL_BORDER_THICKNESS"]   = "Grosor del borde"
L["LABEL_CHANNEL_FONT"]       = "Fuente del canal"
L["LABEL_INPUT_FONT"]         = "Fuente de entrada"
L["LABEL_CHANNEL_FONT_SIZE"]  = "Tamano de fuente del canal"
L["LABEL_INPUT_FONT_SIZE"]    = "Tamano de fuente de entrada"
L["LABEL_TEXT_ALIGNMENT"]     = "Alineacion del texto"
L["LABEL_FONT_OUTLINE"]       = "Contorno de fuente"

L["CB_DYNAMIC_HEIGHT"]   = "Altura dinamica"
L["CB_DYNAMIC_WIDTH"]    = "Ancho dinamico"
L["CB_TINT_BG"]          = "Tintear fondo con color del canal"
L["CB_MATCH_TEXT_COLOR"] = "Igualar color del texto al canal"

-- !! Placement tab !!-----------------------------------------------------------
L["SECTION_LAYOUT_OPTIONS"]   = "Opciones de diseno"
L["SECTION_POSITION"]         = "Posicion"
L["LABEL_CHANNEL_NAME_POS"]   = "Posicion del nombre de canal"
L["CB_SHOW_CHANNEL"]           = "Mostrar nombre del canal"
L["LABEL_AUTOCOMPLETE_POS"]   = "Posicion del autocompletar"
L["LABEL_CHAR_COUNTER_POS"]   = "Posicion del contador de caracteres"
L["CB_AUTO_HIDE_CHANNEL"]     = "Ocultar nombre de canal automaticamente (mostrar al pasar el cursor)"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "Abrir editor de anclaje"

-- !! Features tab !!------------------------------------------------------------
L["SECTION_FEATURE_TOGGLES"]  = "Activar/desactivar funciones"
L["FEATURE_TOGGLES_DESC"]     = "Activa o desactiva las funciones de BigChatBox."
L["SECTION_SNIPPET_SYSTEM"]   = "Sistema de fragmentos"
L["SECTION_AUTOCOMPLETE"]     = "Autocompletar"
L["SECTION_HISTORY"]          = "Historial"
L["SECTION_LINK_HOVER"]       = "Enlace al pasar el cursor"
L["SECTION_LONG_MESSAGES"]    = "Mensajes largos"
L["CB_ENABLE_SNIPPETS"]       = "Activar sistema de fragmentos"
L["CB_AC_COMMANDS"]           = "Autocompletar comandos de barra (/dance, /guild, etc.)"
L["CB_AC_WHISPER"]            = "Autocompletar destinatarios de susurro (/w <nombre>)"
L["CB_AC_SNIPPETS"]           = "Autocompletar fragmentos (!guild, etc.)"
L["CB_AC_BNET"]               = "Mostrar amigos de Battle.net en autocompletar susurros"
L["CB_ENABLE_HISTORY"]        = "Activar historial de chat"
L["CB_MOUSEWHEEL_HISTORY"]    = "Desplazar historial con la rueda del raton"
L["CB_LINK_HOVER"]            = "Mostrar informacion al pasar el cursor sobre enlaces"
L["LABEL_MSG_EXCEEDS_255"]    = "Cuando el mensaje supera 255 caracteres"

-- !! Snippets tab !!------------------------------------------------------------
L["SNIPPETS_DISABLED_MSG"]    = "El sistema de fragmentos esta desactivado.\nActivalo en la pestana Funciones."
L["SNIPPETS_HEADER"]          = "Fragmentos"
L["SNIPPETS_DESC"]            = "Escribe un activador de fragmento en el chat (p. ej. !guild) y pulsa Enter para expandirlo."
L["SNIPPET_EDIT_HEADER"]      = "Editar"
L["SNIPPET_ACTIVE"]           = "Fragmento activo"
L["SNIPPET_TRIGGER_LBL"]      = "Activador:"
L["SNIPPET_TEXT_LBL"]         = "Texto:"
L["SNIPPET_CHANNEL_LBL"]      = "Canal:"
L["SNIPPET_GLOBAL"]           = "Disponible para todos los personajes"
L["SNIPPET_EMPTY_LIST"]       = "Aun no hay fragmentos.\nHaz clic en «Nuevo fragmento» o\n«Importar» para empezar."
L["BTN_NEW_SNIPPET"]          = "Nuevo fragmento"
L["BTN_EXPORT_ALL"]           = "Exportar todo"
L["BTN_SHARE_SNIPPET"]        = "Compartir"
L["BTN_DUPLICATE_SNIPPET"]    = "Duplicar"
L["BTN_DELETE_SNIPPET"]       = "Eliminar"
L["BTN_IMPORT_SNIPPET"]       = "Importar"

-- !! History tab !!-------------------------------------------------------------
L["HISTORY_HEADER"]           = "Historial de chat"
L["HISTORY_HELP"]             = "Haz clic en el texto para reutilizarlo. Pasa el cursor para ver la marca de tiempo. Haz clic en X para eliminar."
L["HISTORY_EMPTY"]            = "Sin historial aun."
L["HISTORY_MORE"]             = "... %d mas"
L["WHISPERS_HEADER"]          = "Susurros recientes"
L["WHISPERS_CLICK_HINT"]      = "(Haz clic para susurrar)"
L["WHISPERS_EMPTY"]           = "Sin historial de susurros."
L["BTN_WIPE_HISTORY"]         = "Borrar todo el historial"
L["BTN_WIPE_COMMANDS"]        = "Borrar todos los /comandos"
L["BTN_REMOVE_ENTRIES"]       = "Eliminar entradas seleccionadas"

-- !! Advanced tab !!------------------------------------------------------------
L["SECTION_PROFILES"]         = "Perfiles"
L["PROFILES_DESC"]            = "Los ajustes se guardan por personaje. Activalo para compartirlos entre todos."
L["CB_GLOBAL_PROFILE"]        = "Usar para todos los personajes"
L["BEHAVIOR"]                 = "Comportamiento"
L["KEEP_OPEN"]                = "Mantener la caja de entrada abierta hasta pulsar Escape"
L["KEEP_OPEN_HELP"]           = "Cuando esta activado, la caja de entrada permanece visible aunque hagas clic en otro lugar. Pulsa Escape para cerrarla."
L["SHOW_LOCKDOWN_WARNING"]    = "Mostrar aviso de contenido seguro"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "Muestra un mensaje en el chat cuando BCB se pausa en M+, arena y BG clasificado."
L["IGNORE_COMMANDS_HISTORY"]  = "Ignorar /comandos en el historial"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "Los comandos de barra como /target o /cast no se guardan en el historial."
L["SHOW_MINIMAP_BUTTON"]      = "Mostrar boton en el minimapa"
L["SHOW_MINIMAP_BUTTON_HELP"] = "Clic izquierdo para abrir ajustes, clic derecho para ajustes rapidos. El boton de la barra de complementos siempre esta disponible."
L["HIDE_LOGIN_MSG"]           = "Ocultar mensaje de inicio de sesion"
L["HIDE_LOGIN_MSG_HELP"]      = "Oculta el mensaje «BigChatBox cargado» al iniciar sesion."
L["KEYBIND_OPEN_BLIZZARD"]    = "Abrir chat de Blizzard:"
L["KEYBIND_NOT_BOUND"]        = "Sin asignar"
L["KEYBIND_PRESS_KEY"]        = "Pulsa una tecla..."
L["KEYBIND_CONFLICT"]         = "%s ya esta asignado a %s. ¿Sobreescribir?"
L["KEYBIND_TOOLTIP_BOUND"]    = "Abrir chat de Blizzard (%s)"
L["KEYBIND_TOOLTIP_UNBIND"]   = "Clic derecho para desasignar"
L["KEYBIND_TOOLTIP_SET"]      = "Haz clic para asignar tecla"
L["KEYBIND_HELP"]             = "Abre la caja de chat nativa de Blizzard para Shift+clic en monturas, logros, juguetes y talentos. Predeterminado: Ctrl+Enter."
L["RESET_ALL"]                = "Restablecer todo"
L["RESET_APPEARANCE"]         = "Restablecer apariencia"
L["RESET_PLACEMENT"]          = "Restablecer posicion"
L["RESET_HISTORY_BTN"]        = "Restablecer historial"
L["RESET_SNIPPETS_BTN"]       = "Restablecer fragmentos"
L["RESET_STYLES_BTN"]         = "Restablecer estilos"
L["RESTART_SETUP"]            = "Volver a ejecutar el asistente"

-- !! Confirmations !!-----------------------------------------------------------
L["POPUP_RESET_ALL"]          = "¿Restablecer todos los ajustes de BigChatBox?\nIncluye posicion, tamano, apariencia y fuentes."
L["POPUP_RESET_APPEARANCE"]   = "¿Restablecer la apariencia a los valores predeterminados?\nNo afecta a la posicion ni al historial."
L["POPUP_RESET_PLACEMENT"]    = "¿Restablecer la posicion a los valores predeterminados?\nEsto recargara la interfaz."
L["POPUP_RESET_HISTORY"]      = "¿Restablecer todo el historial de chat y susurros?\nLa longitud del historial se fijara en 100.\nEsto recargara la interfaz."
L["POPUP_RESET_SNIPPETS"]     = "¿Eliminar todos los fragmentos? Esto recargara la interfaz."
L["POPUP_RESET_STYLES"]       = "¿Eliminar todos los estilos creados por el usuario?\nEl estilo predeterminado permanecera y sera el actual.\nEsto recargara la interfaz."
L["POPUP_WIPE_HISTORY"]       = "¿Borrar todo el historial de chat?\nEsto tambien recargara la interfaz."
L["POPUP_WIPE_COMMANDS"]      = "¿Eliminar todos los /comandos del historial?\nLos mensajes normales se conservaran.\nEsto tambien recargara la interfaz."
L["POPUP_DELETE_STYLE"]       = "¿Eliminar el estilo actual?"
L["POPUP_OVERWRITE_STYLE"]    = "Ya existe un estilo llamado «%s». ¿Sobreescribir?"
L["POPUP_SAVE_STYLE_TEXT"]    = "Introduce un nombre para este estilo:"
L["POPUP_EXPORT_STYLE_TEXT"]  = "Copia la cadena de estilo de abajo:"
L["POPUP_IMPORT_STYLE_TEXT"]  = "Pega la cadena de estilo:"
L["POPUP_NAME_IMPORT_STYLE"]  = "Guardar el estilo importado como:"
L["POPUP_DELETE_SNIPPET"]     = "¿Eliminar el fragmento «%s»?"
L["POPUP_SHARE_SNIPPET_TEXT"] = "Copia la cadena del fragmento (Ctrl+C):"
L["POPUP_IMPORT_SNIPPET_TEXT"] = "Pega la cadena del fragmento (Ctrl+V):"
L["POPUP_RESTART_SETUP"]      = "Esto restablecera todos los ajustes y reiniciara el asistente de bienvenida.\n¿Continuar?"
L["POPUP_QUIT_SETUP"]         = "¿Salir de la configuracion?\nSe usaran los ajustes predeterminados."
L["BTN_RESET_ALL_CONFIRM"]    = "Restablecer todo"
L["BTN_WIPE_CONFIRM"]         = "Si, borrar"
L["BTN_DELETE_CONFIRM"]       = "Eliminar"
L["BTN_OVERWRITE_CONFIRM"]    = "Sobreescribir"
L["BTN_SKIP"]                 = "Omitir"
L["BTN_RESTART_SETUP_CONFIRM"] = "Reiniciar asistente"
L["BTN_QUIT_SETUP_CONFIRM"]   = "Salir de la configuracion"
L["BTN_SAVE_CLOSE"]           = "Cerrar"

-- !! Slash / print messages !!--------------------------------------------------
L["SLASH_POSITION_RESET"]     = "Posicion restablecida a los valores predeterminados"
L["SLASH_ANCHOR_UNAVAILABLE"] = "El editor de anclaje no esta disponible."
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox:|r Historial de chat borrado."
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox:|r Apariencia restablecida a los valores predeterminados"
L["RESET_DONE"]               = "Todos los ajustes han sido restablecidos a los valores predeterminados."
L["COMBAT_CLOSE"]             = "Combate iniciado -- configuracion cerrada."
L["COMBAT_BLOCKED"]           = "No se puede abrir la configuracion en combate."

-- !! Position / size labels (legacy) !!-----------------------------------------
L["POSITION"]        = "Posicion"
L["X_POSITION"]      = "Posicion X"
L["Y_POSITION"]      = "Posicion Y"
L["SIZE"]            = "Tamano"
L["WIDTH"]           = "Ancho"
L["HEIGHT"]          = "Altura"
L["SCALE"]           = "Escala"
L["FONT_SIZES"]      = "Tamanos de fuente"
L["INPUT_FONT_SIZE"] = "Tamano de fuente de entrada"
L["CHANNEL_FONT_SIZE"] = "Tamano de fuente del canal"
L["FONTS"]           = "Fuentes"
L["INPUT_FONT"]      = "Fuente de entrada"
L["CHANNEL_FONT"]    = "Fuente del canal"
L["BACKGROUND"]      = "Fondo"
L["BG_TEXTURE"]      = "Textura de fondo"
L["BG_TRANSPARENCY"] = "Opacidad del fondo"
L["BG_BRIGHTNESS"]   = "Brillo del fondo"
L["BG_SCALE"]        = "Escala del fondo"
L["BORDER"]          = "Borde"
L["BORDER_TEXTURE"]  = "Textura del borde"
L["BORDER_TRANSPARENCY"] = "Opacidad del borde"
L["BORDER_BRIGHTNESS"]   = "Brillo del borde"
L["BORDER_THICKNESS"]    = "Grosor del borde"
L["TEXT_OPTIONS"]    = "Opciones de texto"
L["MATCH_TEXT_COLOR"] = "Igualar color del texto al canal"
L["SHOW_OUTLINE"]    = "Mostrar contorno de texto"
L["SHOW_SHADOW"]     = "Mostrar sombra de texto"
L["DROP_SHADOW"]     = "Sombra en la caja de entrada"
L["TEXT_ALIGN"]      = "Alineacion del texto"
L["CHAT_HISTORY"]    = "Historial de chat"
L["HISTORY_LENGTH"]  = "Longitud del historial"
L["WIPE_HISTORY"]    = "Borrar todo el historial"
L["RECENT_WHISPERS"] = "Susurros recientes"
L["SNIPPETS"]        = "Fragmentos"
L["SNIPPET_TRIGGER"] = "Activador"
L["SNIPPET_TEXT"]    = "Texto"
L["SNIPPET_SAVE"]    = "Guardar"
L["SNIPPET_DELETE"]  = "Eliminar"
L["SNIPPET_NEW"]     = "Nuevo fragmento"
L["SNIPPET_SHARE"]   = "Compartir fragmento"
L["SNIPPET_EXPORT"]  = "Exportar todo"
L["SNIPPET_IMPORT"]  = "Importar"
L["SNIPPET_RESET"]   = "Restablecer fragmentos"
L["AUTOCOMPLETE"]    = "Autocompletar"
L["AUTOCOMPLETE_POS"] = "Posicion del autocompletar"
L["CHANNEL_POS"]     = "Posicion del nombre de canal"
L["AUTO_HIDE_CHANNEL"] = "Ocultar nombre de canal automaticamente (mostrar al pasar el cursor)"
L["LAYOUT_OPTIONS"]  = "Opciones de diseno"
L["ANCHOR_EDITOR"]   = "Editor de anclaje"
L["OPEN_ANCHOR_EDITOR"] = "Abrir editor de anclaje"
L["ABOUT"]           = "Acerca de"
L["ABOUT_DESC"]      = "Una gran caja de entrada de chat personalizable con visualizacion de canal, editor de anclaje y control completo de apariencia."
L["PROFILES"]        = "Perfiles"
L["SAVE_STYLE"]      = "Guardar estilo"
L["DELETE_STYLE"]    = "Eliminar estilo"
L["DYNAMIC_HEIGHT"]  = "Altura dinamica"
L["DYNAMIC_WIDTH"]   = "Ancho dinamico"
L["CHAR_COUNTER_POS"] = "Posicion del contador de caracteres"
L["LONG_MESSAGES"]   = "Mensajes largos"
L["LONG_MSG_OFF"]    = "Desactivado"
L["LONG_MSG_SILENT"] = "Silencioso"
L["LONG_MSG_NOTICE"] = "Aviso"
L["LONG_MSG_CONFIRM"] = "Confirmar"
L["LONG_MSG_DESC_OFF"]     = "El mensaje se trunca a 255 caracteres (comportamiento predeterminado de WoW)."
L["LONG_MSG_DESC_SILENT"]  = "Se divide automaticamente en varios mensajes."
L["LONG_MSG_DESC_NOTICE"]  = "Divide e indica cuantas partes se enviaron."
L["LONG_MSG_DESC_CONFIRM"] = "Pide confirmacion antes de dividir."
L["IMPORT_STYLE_BTN"]  = "Importar cadena de estilo"
L["FINISH_CONFIG_BTN"] = "Finalizar + Configurar"
L["BG_COLOR"]          = "Color de fondo"
L["MSG_SPLIT_NOTICE"]  = "Mensaje dividido en %d partes (%d caracteres)."

-- !! v5.3.3 Keybinding strings !!-----------------------------------------------
L["HELP_KEYBINDINGS_TITLE"] = "-- Teclas de acceso rapido --"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+Enter cambia al chat predeterminado de Blizzard (funciona en cualquier lugar).\nUtil para Shift+clic en monturas, logros, juguetes, talentos y el libro de\nhechizos, que no se pueden insertar directamente en BCB. Escribe en la caja\nde Blizzard y pulsa Enter para enviar; BCB se reactiva en el siguiente Enter.\n\nPuedes cambiar o eliminar esta asignacion en la pestana Avanzado o en\n«Esc > Asignacion de teclas > Complementos > BigChatBox»."

-- !! v5.5.0 Welcome Panel !!----------------------------------------------------
L["WELCOME_TITLE"]          = "Bienvenido a BigChatBox!"
L["WELCOME_SUBTITLE"]       = "Configuracion inicial"
L["WELCOME_TEXT"]           = "BigChatBox sustituye la pequena caja de entrada de chat de WoW por una grande y totalmente personalizable.\n\nPuedes cambiar el tamano, el fondo, el borde, la fuente y los colores, o elegir un estilo predefinido. Funciones como el historial de chat, fragmentos de texto y autocompletar inteligente estan integradas y se pueden activar o desactivar en cualquier momento.\n\nEsta configuracion rapida te pondra en marcha en menos de un minuto."
L["WELCOME_SETUP_BTN"]      = "Configurar BigChatBox"
L["WELCOME_LANG_LBL"]       = "Idioma:"
L["WELCOME_STYLE_TITLE"]    = "Elige tu estilo!"
L["WELCOME_LAYOUT_TITLE"]   = "Elige el diseno"
L["WELCOME_FEATURES_TITLE"] = "Elige tus funciones!"
L["WELCOME_ADVANCED_TITLE"] = "Funciones avanzadas"
L["WELCOME_FINAL_TITLE"]    = "Ya casi esta!"
L["WELCOME_FINISH_BTN"]     = "Finalizar!"
L["WELCOME_QUIT_CONFIRM"]   = "¿Salir de la configuracion? Se usaran los ajustes predeterminados."
L["WELCOME_KEYBIND_INFO"]   = "La mayoria de los Shift+clic en enlaces funcionan directamente en BigChatBox. Para los pocos que no lo hacen (monturas, juguetes y talentos), esta tecla cambia a la caja de chat de Blizzard."
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBox se pausa automaticamente en combate, M+, arena y BG clasificado para proteger tu chat."
L["WELCOME_THANKS"]         = "Gracias por usar BigChatBox!"
L["WELCOME_SECURE_TITLE"]   = "Contenido seguro"
L["WELCOME_KEYBIND_TITLE"]  = "Tecla de chat de Blizzard"
L["WELCOME_CONFIG_HINT"]    = "Escribe /bcb en cualquier momento para abrir la ventana de configuracion completa."
L["FEATURE_HISTORY_DESC"]   = "Guarda los mensajes enviados con marca de tiempo."
L["FEATURE_SNIPPETS_DESC"]  = "Atajos de texto que se expanden al pulsar Enter."
L["FEATURE_AC_SNIPPETS_DESC"]  = "Autocompleta activadores de fragmentos que empiezan por !."
L["FEATURE_AC_COMMANDS_DESC"]  = "Autocompleta comandos de barra como /dance o /guild."
L["FEATURE_AC_WHISPERS_DESC"]  = "Autocompleta nombres de jugadores al susurrar."
L["FEATURE_MOUSEWHEEL_DESC"]   = "Usa la rueda del raton para desplazarte por mensajes anteriores."
L["FEATURE_GLOBAL_PROFILE_DESC"] = "Comparte los ajustes entre todos los personajes de esta cuenta."
L["FEATURE_KEEP_OPEN_DESC"]    = "La caja de entrada permanece visible aunque hagas clic en otro lugar."
L["RESTART_SETUP_CONFIRM"]  = "Esto restablecera todos los ajustes y reiniciara el asistente de bienvenida. ¿Continuar?"

-- !! v5.6.0 Patch notes UI !!---------------------------------------------------
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox -- Novedades"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox -- Notas del parche"
L["PATCHNOTES_DONT_SHOW"]      = "No volver a mostrar"
L["PATCHNOTES_GOT_IT"]         = "Entendido!"
L["PATCHNOTES_PREVIOUS"]       = "-- Actualizaciones anteriores --"

-- !! Keys added during source wiring (v5.6.0 localization pass) !!--------------
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffffDesactivado|r -- El mensaje se trunca a 255 caracteres (comportamiento predeterminado de WoW).\n|cffffffffSilencioso|r -- Se divide automaticamente en varios mensajes.\n|cffffffffAviso|r -- Divide e indica cuantas partes se enviaron.\n|cffffffffConfirmar|r -- Pide confirmacion antes de dividir."

L["SNIPPET_NOTHING_TO_EXPORT"] = "No hay fragmentos para exportar."

L["HISTORY_LENGTH_LABEL"] = "Longitud del historial"

L["PRINT_RESET_ALL"]         = "Todos los ajustes han sido restablecidos. Recargando..."
L["PRINT_RESET_APPEARANCE"]  = "Apariencia restablecida. Recargando..."
L["PRINT_RESET_PLACEMENT"]   = "Posicion restablecida. Recargando..."
L["PRINT_RESET_HISTORY"]     = "Historial restablecido. Recargando..."
L["PRINT_SNIPPETS_REMOVED"]  = "Todos los fragmentos han sido eliminados."
L["PRINT_STYLES_REMOVED"]    = "Todos los estilos personalizados han sido eliminados."
L["PRINT_NO_STYLE_STRING"]   = "No se ha proporcionado ninguna cadena de estilo."
L["PRINT_STYLE_DECODE_FAIL"] = "No se pudo decodificar la cadena de estilo; puede estar corrompida."
L["PRINT_STYLE_INVALID"]     = "Cadena de estilo no valida. Se esperaba el prefijo !BCB1: o BCB:."
L["PRINT_STYLE_IMPORTED"]    = "Estilo importado correctamente."
L["PRINT_STYLE_SAVED"]       = "Estilo «%s» guardado."
L["PRINT_STYLE_DELETED"]     = "Estilo «%s» eliminado."
L["PRINT_SNIPPET_INVALID"]   = "Cadena de fragmento no valida."
L["PRINT_SNIPPET_REMOVED"]   = "Fragmento «%s» eliminado."
L["PRINT_SNIPPETS_IMPORTED"] = "%d fragmentos importados."
L["PRINT_SNIPPETS_SKIPPED"]  = " %d omitidos (ya existen)."
L["PRINT_CANT_DELETE_DEFAULT"] = "No se puede eliminar el estilo predeterminado."
L["PRINT_SETUP_SKIPPED"]     = "Configuracion omitida. Escribe |cff55ccff/bcb|r para configurar en cualquier momento."
L["BTN_RESET_STYLES_CONFIRM"] = "Restablecer estilos"

L["POPUP_WIPE_WHISPERS"]     = "¿Borrar el historial de susurros? Esta accion no se puede deshacer."

L["WELCOME_CHOOSE_STYLE"]      = "Elige un estilo:"
L["WELCOME_STYLE_NOTE"]        = "Los estilos con nombre de complemento requieren ese complemento instalado.\nPuedes personalizar todo completamente en la pestana Disenador."
L["WELCOME_LAYOUT_DESC"]       = "Elige donde apareceran el nombre del canal y el autocompletar respecto a la caja de entrada."
L["WELCOME_CHANNEL_POS_LBL"]   = "Posicion del nombre de canal:"
L["WELCOME_AC_POS_LBL"]        = "Posicion del autocompletar:"
L["WELCOME_AUTOHIDE_HELP"]     = "El nombre del canal desaparece hasta que pasas el cursor sobre la caja de entrada."
L["WELCOME_CHARCOUNTER_LBL"]   = "Posicion del contador de caracteres:"
L["WELCOME_FEATURES_DESC"]     = "Activa las funciones que desees. Todas estan activadas de forma predeterminada.\nPuedes cambiarlas en cualquier momento en la pestana Funciones."
L["WELCOME_LONGMSG_LBL"]       = "Mensajes largos (mas de 255 caracteres):"
L["LONGMSG_DESC_OFF"]          = "Truncar a 255 caracteres"
L["LONGMSG_DESC_SILENT"]       = "Dividir automaticamente"
L["LONGMSG_DESC_NOTICE"]       = "Dividir con aviso"
L["LONGMSG_DESC_CONFIRM"]      = "Preguntar antes de dividir"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "Saber mas sobre el bloqueo en combate"
L["WELCOME_WHY_KEYBIND"]       = "¿Por que necesito esto?"
L["WELCOME_CURRENT_KEYBIND"]   = "Tecla actual:"
L["WELCOME_KEYBIND_CLICK_HINT"] = "Haz clic para asignar - Clic derecho para desasignar"
L["WELCOME_OPEN_HELP"]         = "Abrir ventana de ayuda y consejos"
L["WELCOME_HELP_DESC"]         = "Todos los comandos, teclas de acceso rapido y detalles de funciones estan disponibles en la ventana de ayuda."
L["WELCOME_RELOAD_NOTE"]       = "Ambos botones recargaran tu interfaz."
L["WELCOME_COMBAT_PAUSE"]      = "Configuracion pausada -- combate iniciado."
L["WELCOME_SHIFTCLICK_TITLE"]  = "Insercion de enlaces con Shift+clic"
L["WELCOME_FEAT_HISTORY"]      = "Historial de chat"
L["WELCOME_FEAT_SNIPPETS"]     = "Sistema de fragmentos"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "Autocompletar: !fragmentos"
L["WELCOME_FEAT_AC_COMMANDS"]  = "Autocompletar: /comandos"
L["WELCOME_FEAT_AC_WHISPER"]   = "Autocompletar: susurros"
L["WELCOME_FEAT_AC_BNET"]      = "Autocompletar: amigos Battle.net"
L["WELCOME_FEAT_KEEP_OPEN"]    = "Mantener caja de entrada abierta"

L["BTN_PREVIOUS"]  = "Anterior"
L["BTN_NEXT"]      = "Siguiente"

-- !! Language selector !!-------------------------------------------------------
L["SECTION_LANGUAGE"]        = "Idioma"
L["LANGUAGE_DESC"]           = "Cambia el idioma de la interfaz. Requiere recargar la interfaz."
L["LANGUAGE_CLIENT"]         = "Idioma del cliente"
L["LANGUAGE_RELOAD_MSG"]     = "Idioma cambiado. Recargando la interfaz..."
L["POPUP_CHANGE_LANGUAGE"]   = "¿Cambiar el idioma y recargar la interfaz?"
L["BTN_RELOAD_CONFIRM"]      = "Recargar"
L["LANGUAGE_COMING_SOON"]    = "|cff888888(Proximamente)|r"

-- !! Help popup body strings !!-------------------------------------------------
L["HELP_WINDOW_TITLE"] = "Ayuda de BigChatBox"

L["HELP_BODY_MAIN"] = [[|cffffd100-- Comandos --|r
|cffffd100/bcb|r o |cffffd100/bcb config|r -- Abre la ventana de configuracion.
|cffffd100/bcb edit|r -- Abre el editor de anclaje para mover la caja.
|cffffd100/bcb reset|r -- Restablece la posicion a los valores predeterminados.

|cffffd100-- Basico de chat --|r
|cffffd100Clic izquierdo|r en el nombre del canal para cambiar de canal (General, Grupo, Hermandad, etc.).
|cffffd100Clic derecho|r en el nombre del canal para acceder a configuracion, historial y limpiar.
|cffffd100Enter|r para enviar el mensaje. |cffffd100Escape|r para borrar y cerrar.
|cffffd100Rueda del raton|r en la caja de entrada para ver el historial de chat.

|cffffd100-- Autocompletar --|r
Escribe |cffffd100/|r para ver comandos de barra coincidentes (Tab para recorrer, Enter para confirmar).
Escribe |cffffd100!|r para autocompletar activadores de fragmentos (p. ej. !guild, !inv).
Los destinatarios de susurro se completan desde amigos, hermandad, grupo y susurros recientes.
|cffffd100Tab|r / |cffffd100Shift+Tab|r para recorrer las sugerencias.

|cffffd100-- Fragmentos --|r
Define atajos de texto que se expanden al pulsar Enter.
Ej.: !guild se expande a "LFM M+, susurra para invitacion".
Cada fragmento puede restringirse a un canal especifico.
Gestiona, crea, importa y exporta fragmentos en la pestana |cff5599ffFragmentos|r.

|cffffd100-- Insercion de enlaces --|r
|cffffd100Shift+clic|r en objetos, hechizos, logros, etc. para insertar un enlace.
Funciona en bolsas, libro de hechizos, panel de logros, profesiones y salida de chat.
|cffffd100Pasa el cursor|r sobre un enlace en la caja de entrada para previsualizar el tooltip.
Para los paneles que no admiten insercion directa, consulta el boton |cff5599ffInfo sobre Shift+clic|r.

|cffffd100-- Personalizacion --|r
Usa la pestana |cff5599ffDisenador|r para personalizar el fondo, el borde, la fuente y los colores.
La pestana |cff5599ffPosicion|r incluye el editor de anclaje para alineacion precisa.
Guarda la apariencia como un estilo con nombre. Exporta/importa cadenas de estilo para compartir.
Compatible con texturas y fuentes de LibSharedMedia si esta instalado.

|cffffd100-- Herramientas y activadores --|r
Activa o desactiva cada funcion individualmente en la pestana |cff5599ffFunciones|r:
autocompletar, fragmentos, tooltip de enlace al pasar el cursor, historial de chat y mas.
El modo |cffffd100Mantener abierto|r hace que la caja de entrada permanezca visible aunque pierda el foco.

|cffffd100-- Perfiles y estilos --|r
Los ajustes se guardan por personaje de forma predeterminada.
Activa |cffffd100Usar para todos los personajes|r en Avanzado para compartir ajustes globalmente.
Los estilos guardan la apariencia visual (fondo, borde, fuente, colores).
Usa Exportar/Importar para compartir estilos con amigos o moverlos entre personajes.

|cffffd100-- Posicion y tamano --|r
Haz clic y arrastra la caja de entrada en el editor de anclaje para moverla.
Las teclas de direccion la desplazan 1 pixel a la vez para precision.
Shift+arrastrar redimensiona la caja simetricamente.
|cffffd100Shift+Alt+clic|r en la caja de entrada restablece la posicion al centro de la pantalla.
Tambien puedes introducir valores exactos de posicion y tamano en el panel de info del editor de anclaje.

|cffffd100-- Mensajes largos --|r
Los mensajes de mas de 255 caracteres se pueden dividir automaticamente en varios envios.
Configura el comportamiento en la pestana |cff5599ffFunciones|r: desactivado, silencioso, aviso o confirmar.
El contador de caracteres muestra cuanto queda hasta el limite.

|cffffd100-- Tamano dinamico --|r
Activa |cffffd100Altura dinamica|r y |cffffd100Ancho dinamico|r en la pestana Disenador.
La altura se ajusta al tamano de la fuente; el ancho crece con la longitud del mensaje.]]

L["HELP_BODY_SECURE"] = "|cffffd100-- Por que BigChatBox se pausa en combate/M+/etc. --|r\n\n" ..
    "Con la expansion Medianoche (12.0), Blizzard realizo cambios importantes en como los complementos interactuan con el juego en combate. Esta iniciativa se conoce como |cff5599ffDesarme de complementos|r y restringe como los complementos pueden manejar informacion de combate.\n\n" ..
    "|cffffd100Que ha cambiado?|r\n" ..
    "Los datos relacionados con el combate ahora se tratan como |cffff9900valores secretos|r. Los complementos pueden mostrar esta informacion, pero no leerla ni procesarla en el codigo.\n\n" ..
    "Muchos marcos de la interfaz ahora estan |cffff9900protegidos|r en combate. En contenido de instancia (M+, arena, BG clasificado), las restricciones son aun mas estrictas. Cualquier complemento que modifique o enganche estos marcos protegidos corre el riesgo de propagar |cffff6666contaminacion|r, lo que puede romper completamente la funcionalidad del juego -- no solo del complemento, sino tambien funciones basicas como seleccionar objetivo, lanzar hechizos y usar habilidades.\n\n" ..
    "|cffffd100Como afecta esto a BigChatBox?|r\n" ..
    "La caja de entrada de chat predeterminada de WoW (ChatFrame1EditBox) es un marco protegido porque gestiona comandos de barra seguros como /target, /cast y /focus. BigChatBox engancha este marco para interceptar la entrada de chat. En combate y en contenido competitivo de instancia, estos ganchos pueden provocar contaminacion, bloqueando todo el sistema de chat.\n\n" ..
    "Para protegerte, BigChatBox se |cff00ff00pausa automaticamente|r durante el combate y en M+, arena y BG clasificado. La caja de entrada de chat predeterminada de Blizzard toma el relevo sin interrupciones. Cuando termina el combate o el contenido, BigChatBox se reanuda automaticamente.\n\n" ..
    "|cffffd100Por que no se corrige simplemente?|r\n" ..
    "No es un |cffff0000bug|r. Es una limitacion fundamental del modelo de seguridad de WoW. Todos los complementos que modifican marcos protegidos en combate se enfrentan a la misma restriccion. Blizzard diseno estas limitaciones para evitar que los complementos automaticen decisiones de combate, y la caja de entrada de chat esta dentro del ambito protegido.\n\n" ..
    "|cffffd100Resumen|r\n" ..
    "BigChatBox se pausa durante el combate y en contenido cronometrado (M+, arena, BG clasificado). Durante ese tiempo puedes seguir chateando normalmente con la caja de entrada predeterminada de Blizzard. Cuando termine el combate o la actividad, BigChatBox se reanudara automaticamente."

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100-- Por que no funciona todo el Shift+clic? --|r\n\n" ..
    "La mayoria de los Shift+clic para insertar enlaces funcionan directamente en BigChatBox. Sin embargo, algunos paneles del juego utilizan una funcion interna de Blizzard que solo inserta enlaces en la caja de entrada de Blizzard, sin pasar por la de los complementos.\n\n" ..
    "|cff00ff00Funciona en BigChatBox:|r\n" ..
    "  - Objetos de las bolsas personales\n" ..
    "  - Mascotas del Diario de mascotas\n" ..
    "  - Heredados del panel de heredados\n" ..
    "  - Objetos del mercader\n" ..
    "  - Objetos del buzon\n" ..
    "  - Recetas y materiales del panel de profesiones\n" ..
    "  - Enlaces en las ventanas de chat\n\n" ..
    "|cffff9900Requiere el chat de Blizzard:|r\n" ..
    "  - Logros del panel de logros\n" ..
    "  - Objetos del banco\n" ..
    "  - Objetos del banco de hermandad\n" ..
    "  - Monturas del Diario de monturas\n" ..
    "  - Talentos del panel de talentos\n" ..
    "  - Apariencias de transmogrificacion\n" ..
    "  - Algunos paneles especificos de expansion\n\n" ..
    "|cffffd100Por que?|r\n" ..
    "Estos paneles utilizan la funcion interna de WoW |cff5599ffChatEdit_InsertLink|r, que comprueba una caja de entrada especifica de Blizzard. BCB intercepta la mayoria de estas llamadas, pero algunos paneles esquivan completamente los ganchos estandar debido a como los implementa Blizzard. Es una limitacion de la API de WoW, no un error.\n\n" ..
    "|cffffd100Solucion|r\n" ..
    "Pulsa la |cff5599ffTecla de chat de Blizzard|r (predeterminado: Ctrl+Enter) para cambiar instantaneamente a la caja de chat nativa. Escribe o haz Shift+clic ahi y pulsa Enter para enviar; BigChatBox se reanudara automaticamente en el siguiente mensaje.\n\n" ..
    "Para cambiar o eliminar esta tecla:\n" ..
    "  - |cffffd100/bcb|r > pestana Avanzado\n" ..
    "  - Esc > Asignacion de teclas > Complementos > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "¿Cambiar a %s y reiniciar la configuracion?\nBigChatBox se recargara para aplicar el nuevo idioma."

-- !! v5.6.1 Emoji & Emoticon picker !!-----------------------------------------
L["SECTION_EMOJI"]          = "Selector de emoticonos"
L["CB_SHOW_EMOJI_PICKER"]   = "Mostrar boton del selector de emoticonos"
L["EMOJI_PICKER_TITLE"]     = "Selector de emoticonos"
L["EMOJI_PICKER_TOOLTIP"]   = "Haz clic para abrir el selector de emoticonos"
L["EMOJI_TAB_LAST"]         = "Recientes"
L["EMOJI_TAB_ASCII"]        = "Emoticonos"
L["EMOJI_LAST_EMPTY"]       = "Sin selecciones recientes."

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "Buscar en el historial..."

L["BTN_SAVE_SNIPPET"]           = "Guardar"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "Usar estilo predeterminado"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "Si está marcado, el cuadro multilínea usa el estilo predeterminado independientemente del estilo activo. Desmarcar para usar la apariencia BCB actual."

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "Entrada multilínea"
L["CB_ENABLE_MULTILINE"]        = "Activar entrada multilínea"
L["CB_ENABLE_MULTILINE_HELP"]   = "Abre un cuadro multilínea grande para redactar mensajes. Cada línea se envía por separado."
L["KEYBIND_OPEN_MULTILINE"]     = "Abrir entrada multilínea:"
L["MULTILINE_KEYBIND_HELP"]     = "Predeterminado: Mayús+Intro. Abre un cuadro de entrada grande donde Intro añade una nueva línea y Mayús+Intro envía todas las líneas."
L["BTN_OPEN_KEYBINDINGS"]       = "Abrir atajos de teclado"
L["MULTILINE_SEND_BTN"]         = "Enviar"
L["MULTILINE_CHANNEL_LABEL"]    = "Canal: %s"
L["MULTILINE_BLOCKED_SECURE"]   = "La entrada multilínea no está disponible en M+/Arena/BG puntuada."
L["MULTILINE_HINT"]             = "Intro = nueva línea   |   Mayús+Intro = enviar todo"
