-- BigChatBox Localization - Brazilian Portuguese (ptBR)
-- Version: 5.6.1
local L = BigChatBox and BigChatBox.L
if not L then return end
if GetLocale() ~= "ptBR" and (BigChatBox and BigChatBox._forcedLocale) ~= "ptBR" then return end

-- !! Addon identity !!---------------------------------------------------------
-- L["ADDON_NAME"] = "BigChatBox"  -- do not translate
-- L["AUTHOR"]     = "by Dukul"    -- do not translate
L["VERSION"]      = "Versao"
L["LOADED_MSG"]   = "BigChatBox v%s carregado. Digite /bcb para abrir as opcoes."

-- !! Config window tabs !!------------------------------------------------------
L["TAB_GENERAL"]   = "Geral"
L["TAB_DESIGNER"]  = "Designer"
L["TAB_PLACEMENT"] = "Posicionamento"
L["TAB_FEATURES"]  = "Funcoes"
L["TAB_SNIPPETS"]  = "Trechos"
L["TAB_HISTORY"]   = "Historico"
L["TAB_ADVANCED"]  = "Avancado"
L["TAB_RESET"]     = "Redefinir"

-- !! Reset tab !!---------------------------------------------------------------
L["RESET_TAB_HEADER"]       = "Redefinir e restaurar"
L["RESET_TAB_DESC"]         = "Essas acoes sao permanentes e nao podem ser desfeitas."
L["RESET_ALL_HELP"]         = "Redefine tudo: posicao, aparencia, historico e trechos."
L["RESET_APPEARANCE_HELP"]  = "Redefine apenas fundo, borda, fonte e cores."
L["RESET_PLACEMENT_HELP"]   = "Redefine posicao e tamanho para os valores padrao."
L["RESET_HISTORY_HELP"]     = "Apaga todo o historico de chat e sussurros salvo."
L["RESET_SNIPPETS_HELP"]    = "Remove todos os trechos."
L["RESET_STYLES_HELP"]      = "Remove todos os estilos personalizados salvos."
L["RESTART_SETUP_HELP"]     = "Redefine todas as configuracoes e executa novamente o assistente de configuracao inicial."

-- !! Shared UI !!---------------------------------------------------------------
L["PREVIEW"]        = "Previa"
L["TYPE_SOMETHING"] = "Digite algo..."
L["CLOSE"]          = "Fechar"
L["ACTIONS"]        = "Acoes"
L["RESET"]          = "Redefinir"
L["OK"]             = "OK"
L["CANCEL"]         = "Cancelar"
L["YES"]            = "Sim"
L["NO"]             = "Nao"
L["SAVE"]           = "Salvar"
L["DELETE"]         = "Excluir"
L["EDIT"]           = "Editar"
L["IMPORT"]         = "Importar"
L["EXPORT"]         = "Exportar"
L["DUPLICATE"]      = "Duplicar"
L["SHARE"]          = "Compartilhar"
L["ENABLED"]        = "Ativado"
L["DISABLED"]       = "Desativado"

-- !! General tab !!-------------------------------------------------------------
L["BTN_VIEW_PATCH_NOTES"]     = "Ver notas do patch"
L["BTN_HELP_AND_TIPS"]        = "Ajuda e dicas"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "Info sobre bloqueio em combate"
L["BTN_SHIFT_CLICK_INFO"]     = "Info sobre Shift+clique"

L["CELL_SNIPPETS_HDR"]       = "|cff5599ffTrechos|r"
L["CELL_SNIPPETS_DESC"]      = "Atalhos de texto expandidos ao enviar.\nGerenciados na aba Trechos."
L["CELL_ANCHOR_HDR"]         = "|cff5599ffEditor de ancora|r"
L["CELL_ANCHOR_DESC"]        = "Clique e arraste para reposicionar.\nTeclas de direcao para precisao em pixels."
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ffAutocompletar|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "Completar com Tab para comandos,\nalvos de sussurro e trechos (!guild)."
L["CELL_HISTORY_HDR"]        = "|cff5599ffHistorico de chat|r"
L["CELL_HISTORY_DESC"]       = "Historico completo com marcas de tempo.\nRole com a roda do mouse."
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ffPersonalizacao|r"
L["CELL_CUSTOMIZATION_DESC"] = "Aba Designer para fundo, borda,\nfonte e cores. Salve e compartilhe estilos."
L["CELL_SECURE_HDR"]         = "|cffff9900Conteudo seguro|r"
L["CELL_SECURE_DESC"]        = "Pausado automaticamente em M+, arena\ne BG classificado para proteger o chat."
L["CELL_SHARING_HDR"]        = "|cff5599ffCompartilhamento|r"
L["CELL_SHARING_DESC"]       = "Exporte estilos e trechos como strings\ncurtas para compartilhar com amigos."
L["CELL_LONGMSG_HDR"]        = "|cff5599ffMensagens longas|r"
L["CELL_LONGMSG_DESC"]       = "Mensagens com mais de 255 caracteres\nsao divididas automaticamente."

-- !! Styles (Designer tab) !!---------------------------------------------------
L["STYLES"]              = "Estilos"
L["ACTIVE_STYLE"]        = "Estilo ativo"
L["BTN_SAVE_STYLE"]      = "Salvar estilo"
L["BTN_DELETE_STYLE"]    = "Excluir estilo"
L["BTN_EXPORT_STYLE"]    = "Exportar estilo"
L["BTN_IMPORT_STYLE"]    = "Importar estilo"

-- !! Designer tab sections !!---------------------------------------------------
L["SECTION_SIZE"]         = "Tamanho"
L["SECTION_BACKGROUND"]   = "Fundo"
L["SECTION_BORDER"]       = "Borda"
L["SECTION_FONTS"]        = "Fontes"
L["SECTION_TEXT_OPTIONS"] = "Opcoes de texto"

L["LABEL_WIDTH"]              = "Largura"
L["LABEL_HEIGHT"]             = "Altura"
L["LABEL_SCALE"]              = "Escala"
L["LABEL_BG_TEXTURE"]         = "Textura do fundo"
L["LABEL_BG_OPACITY"]         = "Opacidade do fundo"
L["LABEL_BG_BRIGHTNESS"]      = "Brilho do fundo"
L["LABEL_BG_SCALE"]           = "Escala do fundo"
L["LABEL_TINT_INTENSITY"]     = "Intensidade do matiz"
L["LABEL_BORDER_TEXTURE"]     = "Textura da borda"
L["LABEL_BORDER_OPACITY"]     = "Opacidade da borda"
L["LABEL_BORDER_BRIGHTNESS"]  = "Brilho da borda"
L["LABEL_BORDER_THICKNESS"]   = "Espessura da borda"
L["LABEL_CHANNEL_FONT"]       = "Fonte do canal"
L["LABEL_INPUT_FONT"]         = "Fonte de entrada"
L["LABEL_CHANNEL_FONT_SIZE"]  = "Tamanho da fonte do canal"
L["LABEL_INPUT_FONT_SIZE"]    = "Tamanho da fonte de entrada"
L["LABEL_TEXT_ALIGNMENT"]     = "Alinhamento do texto"
L["LABEL_FONT_OUTLINE"]       = "Contorno da fonte"

L["CB_DYNAMIC_HEIGHT"]   = "Altura dinamica"
L["CB_DYNAMIC_WIDTH"]    = "Largura dinamica"
L["CB_TINT_BG"]          = "Colorir fundo com a cor do canal"
L["CB_MATCH_TEXT_COLOR"] = "Igualar cor do texto ao canal"

-- !! Placement tab !!-----------------------------------------------------------
L["SECTION_LAYOUT_OPTIONS"]   = "Opcoes de layout"
L["SECTION_POSITION"]         = "Posicao"
L["LABEL_CHANNEL_NAME_POS"]   = "Posicao do nome do canal"
L["CB_SHOW_CHANNEL"]           = "Mostrar nome do canal"
L["LABEL_AUTOCOMPLETE_POS"]   = "Posicao do autocompletar"
L["LABEL_CHAR_COUNTER_POS"]   = "Posicao do contador de caracteres"
L["CB_AUTO_HIDE_CHANNEL"]     = "Ocultar nome do canal automaticamente (mostrar ao passar o cursor)"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "Abrir editor de ancora"

-- !! Features tab !!------------------------------------------------------------
L["SECTION_FEATURE_TOGGLES"]  = "Ativar/desativar funcoes"
L["FEATURE_TOGGLES_DESC"]     = "Ative ou desative as funcoes do BigChatBox."
L["SECTION_SNIPPET_SYSTEM"]   = "Sistema de trechos"
L["SECTION_AUTOCOMPLETE"]     = "Autocompletar"
L["SECTION_HISTORY"]          = "Historico"
L["SECTION_LINK_HOVER"]       = "Link ao passar o cursor"
L["SECTION_LONG_MESSAGES"]    = "Mensagens longas"
L["CB_ENABLE_SNIPPETS"]       = "Ativar sistema de trechos"
L["CB_AC_COMMANDS"]           = "Autocompletar comandos de barra (/dance, /guild, etc.)"
L["CB_AC_WHISPER"]            = "Autocompletar alvos de sussurro (/w <nome>)"
L["CB_AC_SNIPPETS"]           = "Autocompletar trechos (!guild, etc.)"
L["CB_AC_BNET"]               = "Mostrar amigos do Battle.net no autocompletar de sussurros"
L["CB_ENABLE_HISTORY"]        = "Ativar historico de chat"
L["CB_MOUSEWHEEL_HISTORY"]    = "Rolar historico com a roda do mouse"
L["CB_LINK_HOVER"]            = "Mostrar tooltip ao passar o cursor sobre links"
L["LABEL_MSG_EXCEEDS_255"]    = "Quando a mensagem ultrapassar 255 caracteres"

-- !! Snippets tab !!------------------------------------------------------------
L["SNIPPETS_DISABLED_MSG"]    = "O sistema de trechos esta desativado.\nAtive-o na aba Funcoes."
L["SNIPPETS_HEADER"]          = "Trechos"
L["SNIPPETS_DESC"]            = "Digite um gatilho de trecho no chat (ex.: !guild) e pressione Enter para expandi-lo."
L["SNIPPET_EDIT_HEADER"]      = "Editar"
L["SNIPPET_ACTIVE"]           = "Trecho ativo"
L["SNIPPET_TRIGGER_LBL"]      = "Gatilho:"
L["SNIPPET_TEXT_LBL"]         = "Texto:"
L["SNIPPET_CHANNEL_LBL"]      = "Canal:"
L["SNIPPET_GLOBAL"]           = "Disponivel para todos os personagens"
L["SNIPPET_EMPTY_LIST"]       = "Nenhum trecho ainda.\nClique em «Novo trecho» ou\n«Importar» para comecar."
L["BTN_NEW_SNIPPET"]          = "Novo trecho"
L["BTN_EXPORT_ALL"]           = "Exportar tudo"
L["BTN_SHARE_SNIPPET"]        = "Compartilhar"
L["BTN_DUPLICATE_SNIPPET"]    = "Duplicar"
L["BTN_DELETE_SNIPPET"]       = "Excluir"
L["BTN_IMPORT_SNIPPET"]       = "Importar"

-- !! History tab !!-------------------------------------------------------------
L["HISTORY_HEADER"]           = "Historico de chat"
L["HISTORY_HELP"]             = "Clique no texto para reutilizar. Passe o cursor para ver a marca de tempo. Clique em X para remover."
L["HISTORY_EMPTY"]            = "Sem historico ainda."
L["HISTORY_MORE"]             = "... mais %d"
L["WHISPERS_HEADER"]          = "Sussurros recentes"
L["WHISPERS_CLICK_HINT"]      = "(Clique para sussurrar)"
L["WHISPERS_EMPTY"]           = "Sem historico de sussurros."
L["BTN_WIPE_HISTORY"]         = "Limpar todo o historico"
L["BTN_WIPE_COMMANDS"]        = "Limpar todos os /comandos"
L["BTN_REMOVE_ENTRIES"]       = "Remover entradas selecionadas"

-- !! Advanced tab !!------------------------------------------------------------
L["SECTION_PROFILES"]         = "Perfis"
L["PROFILES_DESC"]            = "As configuracoes sao salvas por personagem. Ative para compartilhar entre todos."
L["CB_GLOBAL_PROFILE"]        = "Usar para todos os personagens"
L["BEHAVIOR"]                 = "Comportamento"
L["KEEP_OPEN"]                = "Manter a caixa de entrada aberta ate pressionar Escape"
L["KEEP_OPEN_HELP"]           = "Quando ativado, a caixa de entrada permanece visivel mesmo ao clicar em outro lugar. Pressione Escape para fechar."
L["SHOW_LOCKDOWN_WARNING"]    = "Mostrar aviso de conteudo seguro"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "Exibe uma mensagem no chat quando o BCB e pausado em M+, arena e BG classificado."
L["IGNORE_COMMANDS_HISTORY"]  = "Ignorar /comandos no historico"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "Comandos de barra como /target ou /cast nao sao salvos no historico."
L["SHOW_MINIMAP_BUTTON"]      = "Mostrar botao no minimapa"
L["SHOW_MINIMAP_BUTTON_HELP"] = "Clique esquerdo para abrir configuracoes, clique direito para configuracoes rapidas. O botao da barra de addons esta sempre disponivel."
L["HIDE_LOGIN_MSG"]           = "Ocultar mensagem de login"
L["HIDE_LOGIN_MSG_HELP"]      = "Oculta a mensagem «BigChatBox carregado» ao fazer login."
L["KEYBIND_OPEN_BLIZZARD"]    = "Abrir chat da Blizzard:"
L["KEYBIND_NOT_BOUND"]        = "Sem atribuicao"
L["KEYBIND_PRESS_KEY"]        = "Pressione uma tecla..."
L["KEYBIND_CONFLICT"]         = "%s ja esta atribuido a %s. Sobrescrever?"
L["KEYBIND_TOOLTIP_BOUND"]    = "Abrir chat da Blizzard (%s)"
L["KEYBIND_TOOLTIP_UNBIND"]   = "Clique direito para desatribuir"
L["KEYBIND_TOOLTIP_SET"]      = "Clique para atribuir tecla"
L["KEYBIND_HELP"]             = "Abre a caixa de chat nativa da Blizzard para Shift+clique em montarias, conquistas, brinquedos e talentos. Padrao: Ctrl+Enter."
L["RESET_ALL"]                = "Redefinir tudo"
L["RESET_APPEARANCE"]         = "Redefinir aparencia"
L["RESET_PLACEMENT"]          = "Redefinir posicionamento"
L["RESET_HISTORY_BTN"]        = "Redefinir historico"
L["RESET_SNIPPETS_BTN"]       = "Redefinir trechos"
L["RESET_STYLES_BTN"]         = "Redefinir estilos"
L["RESTART_SETUP"]            = "Executar assistente novamente"

-- !! Confirmations !!-----------------------------------------------------------
L["POPUP_RESET_ALL"]          = "Redefinir todas as configuracoes do BigChatBox?\nInclui posicao, tamanho, aparencia e fontes."
L["POPUP_RESET_APPEARANCE"]   = "Redefinir aparencia para os valores padrao?\nNao afeta posicao nem historico."
L["POPUP_RESET_PLACEMENT"]    = "Redefinir posicionamento para os valores padrao?\nIsso recarregara a interface."
L["POPUP_RESET_HISTORY"]      = "Redefinir todo o historico de chat e sussurros?\nO comprimento do historico sera definido como 100.\nIsso recarregara a interface."
L["POPUP_RESET_SNIPPETS"]     = "Excluir todos os trechos? Isso recarregara a interface."
L["POPUP_RESET_STYLES"]       = "Excluir todos os estilos criados pelo usuario?\nO estilo padrao permanecera e sera o atual.\nIsso recarregara a interface."
L["POPUP_WIPE_HISTORY"]       = "Limpar todo o historico de chat?\nIsso tambem recarregara a interface."
L["POPUP_WIPE_COMMANDS"]      = "Remover todos os /comandos do historico?\nAs mensagens normais serao mantidas.\nIsso tambem recarregara a interface."
L["POPUP_DELETE_STYLE"]       = "Excluir o estilo atual?"
L["POPUP_OVERWRITE_STYLE"]    = "Ja existe um estilo chamado «%s». Sobrescrever?"
L["POPUP_SAVE_STYLE_TEXT"]    = "Digite um nome para este estilo:"
L["POPUP_EXPORT_STYLE_TEXT"]  = "Copie a string de estilo abaixo:"
L["POPUP_IMPORT_STYLE_TEXT"]  = "Cole a string de estilo:"
L["POPUP_NAME_IMPORT_STYLE"]  = "Salvar o estilo importado como:"
L["POPUP_DELETE_SNIPPET"]     = "Excluir o trecho «%s»?"
L["POPUP_SHARE_SNIPPET_TEXT"] = "Copie a string do trecho (Ctrl+C):"
L["POPUP_IMPORT_SNIPPET_TEXT"] = "Cole a string do trecho (Ctrl+V):"
L["POPUP_RESTART_SETUP"]      = "Isso redefinira todas as configuracoes e reiniciara o assistente de boas-vindas.\nContinuar?"
L["POPUP_QUIT_SETUP"]         = "Sair da configuracao?\nAs configuracoes padrao serao usadas."
L["BTN_RESET_ALL_CONFIRM"]    = "Redefinir tudo"
L["BTN_WIPE_CONFIRM"]         = "Sim, limpar"
L["BTN_DELETE_CONFIRM"]       = "Excluir"
L["BTN_OVERWRITE_CONFIRM"]    = "Sobrescrever"
L["BTN_SKIP"]                 = "Pular"
L["BTN_RESTART_SETUP_CONFIRM"] = "Reiniciar assistente"
L["BTN_QUIT_SETUP_CONFIRM"]   = "Sair da configuracao"
L["BTN_SAVE_CLOSE"]           = "Fechar"

-- !! Slash / print messages !!--------------------------------------------------
L["SLASH_POSITION_RESET"]     = "Posicao redefinida para os valores padrao"
L["SLASH_ANCHOR_UNAVAILABLE"] = "O editor de ancora nao esta disponivel."
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox:|r Historico de chat limpo."
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox:|r Aparencia redefinida para os valores padrao"
L["RESET_DONE"]               = "Todas as configuracoes foram redefinidas para os valores padrao."
L["COMBAT_CLOSE"]             = "Combate iniciado -- configuracoes fechadas."
L["COMBAT_BLOCKED"]           = "Nao e possivel abrir configuracoes em combate."

-- !! Position / size labels (legacy) !!-----------------------------------------
L["POSITION"]        = "Posicao"
L["X_POSITION"]      = "Posicao X"
L["Y_POSITION"]      = "Posicao Y"
L["SIZE"]            = "Tamanho"
L["WIDTH"]           = "Largura"
L["HEIGHT"]          = "Altura"
L["SCALE"]           = "Escala"
L["FONT_SIZES"]      = "Tamanhos de fonte"
L["INPUT_FONT_SIZE"] = "Tamanho da fonte de entrada"
L["CHANNEL_FONT_SIZE"] = "Tamanho da fonte do canal"
L["FONTS"]           = "Fontes"
L["INPUT_FONT"]      = "Fonte de entrada"
L["CHANNEL_FONT"]    = "Fonte do canal"
L["BACKGROUND"]      = "Fundo"
L["BG_TEXTURE"]      = "Textura do fundo"
L["BG_TRANSPARENCY"] = "Opacidade do fundo"
L["BG_BRIGHTNESS"]   = "Brilho do fundo"
L["BG_SCALE"]        = "Escala do fundo"
L["BORDER"]          = "Borda"
L["BORDER_TEXTURE"]  = "Textura da borda"
L["BORDER_TRANSPARENCY"] = "Opacidade da borda"
L["BORDER_BRIGHTNESS"]   = "Brilho da borda"
L["BORDER_THICKNESS"]    = "Espessura da borda"
L["TEXT_OPTIONS"]    = "Opcoes de texto"
L["MATCH_TEXT_COLOR"] = "Igualar cor do texto ao canal"
L["SHOW_OUTLINE"]    = "Mostrar contorno de texto"
L["SHOW_SHADOW"]     = "Mostrar sombra de texto"
L["DROP_SHADOW"]     = "Sombra na caixa de entrada"
L["TEXT_ALIGN"]      = "Alinhamento do texto"
L["CHAT_HISTORY"]    = "Historico de chat"
L["HISTORY_LENGTH"]  = "Comprimento do historico"
L["WIPE_HISTORY"]    = "Limpar todo o historico"
L["RECENT_WHISPERS"] = "Sussurros recentes"
L["SNIPPETS"]        = "Trechos"
L["SNIPPET_TRIGGER"] = "Gatilho"
L["SNIPPET_TEXT"]    = "Texto"
L["SNIPPET_SAVE"]    = "Salvar"
L["SNIPPET_DELETE"]  = "Excluir"
L["SNIPPET_NEW"]     = "Novo trecho"
L["SNIPPET_SHARE"]   = "Compartilhar trecho"
L["SNIPPET_EXPORT"]  = "Exportar tudo"
L["SNIPPET_IMPORT"]  = "Importar"
L["SNIPPET_RESET"]   = "Redefinir trechos"
L["AUTOCOMPLETE"]    = "Autocompletar"
L["AUTOCOMPLETE_POS"] = "Posicao do autocompletar"
L["CHANNEL_POS"]     = "Posicao do nome do canal"
L["AUTO_HIDE_CHANNEL"] = "Ocultar nome do canal automaticamente (mostrar ao passar o cursor)"
L["LAYOUT_OPTIONS"]  = "Opcoes de layout"
L["ANCHOR_EDITOR"]   = "Editor de ancora"
L["OPEN_ANCHOR_EDITOR"] = "Abrir editor de ancora"
L["ABOUT"]           = "Sobre"
L["ABOUT_DESC"]      = "Uma grande caixa de entrada de chat personalizavel com exibicao de canal, editor de ancora e controle completo de aparencia."
L["PROFILES"]        = "Perfis"
L["SAVE_STYLE"]      = "Salvar estilo"
L["DELETE_STYLE"]    = "Excluir estilo"
L["DYNAMIC_HEIGHT"]  = "Altura dinamica"
L["DYNAMIC_WIDTH"]   = "Largura dinamica"
L["CHAR_COUNTER_POS"] = "Posicao do contador de caracteres"
L["LONG_MESSAGES"]   = "Mensagens longas"
L["LONG_MSG_OFF"]    = "Desativado"
L["LONG_MSG_SILENT"] = "Silencioso"
L["LONG_MSG_NOTICE"] = "Aviso"
L["LONG_MSG_CONFIRM"] = "Confirmar"
L["LONG_MSG_DESC_OFF"]     = "A mensagem e truncada em 255 caracteres (comportamento padrao do WoW)."
L["LONG_MSG_DESC_SILENT"]  = "Dividida automaticamente em varias mensagens."
L["LONG_MSG_DESC_NOTICE"]  = "Divide e informa quantas partes foram enviadas."
L["LONG_MSG_DESC_CONFIRM"] = "Solicita confirmacao antes de dividir."
L["IMPORT_STYLE_BTN"]  = "Importar string de estilo"
L["FINISH_CONFIG_BTN"] = "Concluir + Configurar"
L["BG_COLOR"]          = "Cor do fundo"
L["MSG_SPLIT_NOTICE"]  = "Mensagem dividida em %d partes (%d caracteres)."

-- !! v5.3.3 Keybinding strings !!-----------------------------------------------
L["HELP_KEYBINDINGS_TITLE"] = "-- Atalhos de teclado --"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+Enter alterna para o chat padrao da Blizzard (funciona em qualquer lugar).\nUtil para Shift+clique em montarias, conquistas, brinquedos, talentos e o\nlivro de feiticos que nao podem ser inseridos diretamente no BCB. Digite na\ncaixa da Blizzard e pressione Enter para enviar; o BCB retoma no proximo Enter.\n\nVoce pode alterar ou remover essa atribuicao na aba Avancado ou em\n«Esc > Atalhos de Teclado > Addons > BigChatBox»."

-- !! v5.5.0 Welcome Panel !!----------------------------------------------------
L["WELCOME_TITLE"]          = "Bem-vindo ao BigChatBox!"
L["WELCOME_SUBTITLE"]       = "Configuracao inicial"
L["WELCOME_TEXT"]           = "O BigChatBox substitui a pequena caixa de entrada de chat do WoW por uma grande e totalmente personalizavel.\n\nVoce pode alterar o tamanho, o fundo, a borda, a fonte e as cores, ou escolher um estilo pre-definido. Funcoes como historico de chat, trechos de texto e autocompletar inteligente estao integradas e podem ser ativadas ou desativadas a qualquer momento.\n\nEsta configuracao rapida vai deixar tudo pronto em menos de um minuto."
L["WELCOME_SETUP_BTN"]      = "Configurar BigChatBox"
L["WELCOME_LANG_LBL"]       = "Idioma:"
L["WELCOME_STYLE_TITLE"]    = "Escolha seu estilo!"
L["WELCOME_LAYOUT_TITLE"]   = "Escolha o layout"
L["WELCOME_FEATURES_TITLE"] = "Escolha suas funcoes!"
L["WELCOME_ADVANCED_TITLE"] = "Funcoes avancadas"
L["WELCOME_FINAL_TITLE"]    = "Quase la!"
L["WELCOME_FINISH_BTN"]     = "Concluir!"
L["WELCOME_QUIT_CONFIRM"]   = "Sair da configuracao? As configuracoes padrao serao usadas."
L["WELCOME_KEYBIND_INFO"]   = "A maioria dos Shift+cliques em links funciona diretamente no BigChatBox. Para os poucos que nao funcionam (montarias, brinquedos e talentos), esta tecla alterna para a caixa de chat da Blizzard."
L["WELCOME_LOCKOUT_INFO"]   = "O BigChatBox e pausado automaticamente em combate, M+, arena e BG classificado para proteger seu chat."
L["WELCOME_THANKS"]         = "Obrigado por usar o BigChatBox!"
L["WELCOME_SECURE_TITLE"]   = "Conteudo seguro"
L["WELCOME_KEYBIND_TITLE"]  = "Tecla de chat da Blizzard"
L["WELCOME_CONFIG_HINT"]    = "Digite /bcb a qualquer momento para abrir a janela de configuracoes completa."
L["FEATURE_HISTORY_DESC"]   = "Salva as mensagens enviadas com marca de tempo."
L["FEATURE_SNIPPETS_DESC"]  = "Atalhos de texto expandidos ao pressionar Enter."
L["FEATURE_AC_SNIPPETS_DESC"]  = "Autocompleta gatilhos de trechos iniciados com !."
L["FEATURE_AC_COMMANDS_DESC"]  = "Autocompleta comandos de barra como /dance ou /guild."
L["FEATURE_AC_WHISPERS_DESC"]  = "Autocompleta nomes de jogadores ao sussurrar."
L["FEATURE_MOUSEWHEEL_DESC"]   = "Use a roda do mouse para rolar por mensagens anteriores."
L["FEATURE_GLOBAL_PROFILE_DESC"] = "Compartilha configuracoes entre todos os personagens desta conta."
L["FEATURE_KEEP_OPEN_DESC"]    = "A caixa de entrada permanece visivel mesmo ao clicar em outro lugar."
L["RESTART_SETUP_CONFIRM"]  = "Isso redefinira todas as configuracoes e reiniciara o assistente de boas-vindas. Continuar?"

-- !! v5.6.0 Patch notes UI !!---------------------------------------------------
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox -- Novidades"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox -- Notas do patch"
L["PATCHNOTES_DONT_SHOW"]      = "Nao mostrar novamente"
L["PATCHNOTES_GOT_IT"]         = "Entendido!"
L["PATCHNOTES_PREVIOUS"]       = "-- Atualizacoes anteriores --"

-- !! Keys added during source wiring (v5.6.0 localization pass) !!--------------
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffffDesativado|r -- Truncado em 255 caracteres (comportamento padrao do WoW).\n|cffffffffSilencioso|r -- Dividido automaticamente em varias mensagens.\n|cffffffffAviso|r -- Divide e informa quantas partes foram enviadas.\n|cffffffffConfirmar|r -- Solicita confirmacao antes de dividir."

L["SNIPPET_NOTHING_TO_EXPORT"] = "Nenhum trecho para exportar."

L["HISTORY_LENGTH_LABEL"] = "Comprimento do historico"

L["PRINT_RESET_ALL"]         = "Todas as configuracoes foram redefinidas para o padrao. Recarregando..."
L["PRINT_RESET_APPEARANCE"]  = "Aparencia redefinida. Recarregando..."
L["PRINT_RESET_PLACEMENT"]   = "Posicionamento redefinido. Recarregando..."
L["PRINT_RESET_HISTORY"]     = "Historico redefinido. Recarregando..."
L["PRINT_SNIPPETS_REMOVED"]  = "Todos os trechos foram removidos."
L["PRINT_STYLES_REMOVED"]    = "Todos os estilos personalizados foram removidos."
L["PRINT_NO_STYLE_STRING"]   = "Nenhuma string de estilo fornecida."
L["PRINT_STYLE_DECODE_FAIL"] = "Falha ao decodificar a string de estilo; pode estar corrompida."
L["PRINT_STYLE_INVALID"]     = "String de estilo invalida. Prefixo !BCB1: ou BCB: esperado."
L["PRINT_STYLE_IMPORTED"]    = "Estilo importado com sucesso."
L["PRINT_STYLE_SAVED"]       = "Estilo «%s» salvo."
L["PRINT_STYLE_DELETED"]     = "Estilo «%s» excluido."
L["PRINT_SNIPPET_INVALID"]   = "String de trecho invalida."
L["PRINT_SNIPPET_REMOVED"]   = "Trecho «%s» removido."
L["PRINT_SNIPPETS_IMPORTED"] = "%d trechos importados."
L["PRINT_SNIPPETS_SKIPPED"]  = " %d ignorados (ja existem)."
L["PRINT_CANT_DELETE_DEFAULT"] = "Nao e possivel excluir o estilo padrao."
L["PRINT_SETUP_SKIPPED"]     = "Configuracao ignorada. Digite |cff55ccff/bcb|r para configurar a qualquer momento."
L["BTN_RESET_STYLES_CONFIRM"] = "Redefinir estilos"

L["POPUP_WIPE_WHISPERS"]     = "Limpar o historico de sussurros? Esta acao nao pode ser desfeita."

L["WELCOME_CHOOSE_STYLE"]      = "Escolha um estilo:"
L["WELCOME_STYLE_NOTE"]        = "Estilos com nome de addon requerem esse addon instalado.\nVoce pode personalizar tudo completamente na aba Designer."
L["WELCOME_LAYOUT_DESC"]       = "Escolha onde o nome do canal e o autocompletar aparecerao em relacao a caixa de entrada."
L["WELCOME_CHANNEL_POS_LBL"]   = "Posicao do nome do canal:"
L["WELCOME_AC_POS_LBL"]        = "Posicao do autocompletar:"
L["WELCOME_AUTOHIDE_HELP"]     = "O nome do canal fica oculto ate voce passar o cursor sobre a caixa de entrada."
L["WELCOME_CHARCOUNTER_LBL"]   = "Posicao do contador de caracteres:"
L["WELCOME_FEATURES_DESC"]     = "Ative as funcoes que deseja usar. Todas estao ativas por padrao.\nVoce pode altera-las a qualquer momento na aba Funcoes."
L["WELCOME_LONGMSG_LBL"]       = "Mensagens longas (mais de 255 caracteres):"
L["LONGMSG_DESC_OFF"]          = "Truncar em 255 caracteres"
L["LONGMSG_DESC_SILENT"]       = "Dividir automaticamente"
L["LONGMSG_DESC_NOTICE"]       = "Dividir com aviso"
L["LONGMSG_DESC_CONFIRM"]      = "Perguntar antes de dividir"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "Saiba mais sobre o bloqueio em combate"
L["WELCOME_WHY_KEYBIND"]       = "Por que preciso disso?"
L["WELCOME_CURRENT_KEYBIND"]   = "Tecla atual:"
L["WELCOME_KEYBIND_CLICK_HINT"] = "Clique para atribuir - Clique direito para remover"
L["WELCOME_OPEN_HELP"]         = "Abrir janela de ajuda e dicas"
L["WELCOME_HELP_DESC"]         = "Todos os comandos, atalhos de teclado e detalhes de funcoes estao disponiveis na janela de ajuda."
L["WELCOME_RELOAD_NOTE"]       = "Ambos os botoes recarregarao sua interface."
L["WELCOME_COMBAT_PAUSE"]      = "Configuracao pausada -- combate iniciado."
L["WELCOME_SHIFTCLICK_TITLE"]  = "Insercao de links com Shift+clique"
L["WELCOME_FEAT_HISTORY"]      = "Historico de chat"
L["WELCOME_FEAT_SNIPPETS"]     = "Sistema de trechos"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "Autocompletar: !trechos"
L["WELCOME_FEAT_AC_COMMANDS"]  = "Autocompletar: /comandos"
L["WELCOME_FEAT_AC_WHISPER"]   = "Autocompletar: sussurros"
L["WELCOME_FEAT_AC_BNET"]      = "Autocompletar: amigos Battle.net"
L["WELCOME_FEAT_KEEP_OPEN"]    = "Manter caixa de entrada aberta"

L["BTN_PREVIOUS"]  = "Anterior"
L["BTN_NEXT"]      = "Proximo"

-- !! Language selector !!-------------------------------------------------------
L["SECTION_LANGUAGE"]        = "Idioma"
L["LANGUAGE_DESC"]           = "Altera o idioma da interface. Requer recarregamento."
L["LANGUAGE_CLIENT"]         = "Idioma do cliente"
L["LANGUAGE_RELOAD_MSG"]     = "Idioma alterado. Recarregando a interface..."
L["POPUP_CHANGE_LANGUAGE"]   = "Alterar idioma e recarregar a interface?"
L["BTN_RELOAD_CONFIRM"]      = "Recarregar"
L["LANGUAGE_COMING_SOON"]    = "|cff888888(Em breve)|r"

-- !! Help popup body strings !!-------------------------------------------------
L["HELP_WINDOW_TITLE"] = "Ajuda do BigChatBox"

L["HELP_BODY_MAIN"] = [[|cffffd100-- Comandos --|r
|cffffd100/bcb|r ou |cffffd100/bcb config|r -- Abre a janela de configuracoes.
|cffffd100/bcb edit|r -- Abre o editor de ancora para mover a caixa.
|cffffd100/bcb reset|r -- Redefine a posicao para os valores padrao.

|cffffd100-- Basico de chat --|r
|cffffd100Clique esquerdo|r no nome do canal para alternar canais (Geral, Grupo, Guilda, etc.).
|cffffd100Clique direito|r no nome do canal para acessar configuracoes, historico e limpar.
|cffffd100Enter|r para enviar a mensagem. |cffffd100Escape|r para limpar e fechar.
|cffffd100Roda do mouse|r na caixa de entrada para ver o historico de chat.

|cffffd100-- Autocompletar --|r
Digite |cffffd100/|r para ver comandos de barra correspondentes (Tab para navegar, Enter para confirmar).
Digite |cffffd100!|r para autocompletar gatilhos de trechos (ex.: !guild, !inv).
Alvos de sussurro sao completados a partir de amigos, guilda, grupo e sussurros recentes.
|cffffd100Tab|r / |cffffd100Shift+Tab|r para navegar pelas sugestoes.

|cffffd100-- Trechos --|r
Defina atalhos de texto expandidos ao pressionar Enter.
Ex.: !guild expande para "LFM M+, sussurre para convite".
Cada trecho pode ser restrito a um canal especifico.
Gerencie, crie, importe e exporte trechos na aba |cff5599ffTrechos|r.

|cffffd100-- Insercao de links --|r
|cffffd100Shift+clique|r em itens, feiticos, conquistas, etc. para inserir um link.
Funciona em mochilas, livro de feiticos, painel de conquistas, profissoes e saida do chat.
|cffffd100Passe o cursor|r sobre um link na caixa de entrada para pre-visualizar o tooltip.
Para paineis que nao suportam insercao direta, consulte o botao |cff5599ffInfo sobre Shift+clique|r.

|cffffd100-- Personalizacao --|r
Use a aba |cff5599ffDesigner|r para personalizar fundo, borda, fonte e cores.
A aba |cff5599ffPosicionamento|r tem o editor de ancora para alinhamento preciso.
Salve a aparencia como um estilo nomeado. Exporte/importe strings de estilo para compartilhar.
Suporta texturas e fontes do LibSharedMedia se instalado.

|cffffd100-- Ferramentas e alternadores --|r
Ative ou desative cada funcao individualmente na aba |cff5599ffFuncoes|r:
autocompletar, trechos, tooltip de link ao passar o cursor, historico de chat e mais.
O modo |cffffd100Manter aberto|r faz a caixa de entrada permanecer visivel mesmo ao perder o foco.

|cffffd100-- Perfis e estilos --|r
As configuracoes sao salvas por personagem por padrao.
Ative |cffffd100Usar para todos os personagens|r em Avancado para compartilhar configuracoes globalmente.
Estilos salvam a aparencia visual (fundo, borda, fonte, cores).
Use Exportar/Importar para compartilhar estilos com amigos ou mover entre personagens.

|cffffd100-- Posicao e tamanho --|r
Clique e arraste a caixa de entrada no editor de ancora para mover para uma nova posicao.
Teclas de direcao a movem 1 pixel por vez para precisao.
Shift+arrastar redimensiona a caixa simetricamente.
|cffffd100Shift+Alt+clique|r na caixa de entrada redefine a posicao para o centro da tela.
Voce tambem pode definir valores exatos de posicao e tamanho no painel de info do editor de ancora.

|cffffd100-- Mensagens longas --|r
Mensagens com mais de 255 caracteres podem ser divididas automaticamente em varios envios.
Configure o comportamento na aba |cff5599ffFuncoes|r: desativado, silencioso, aviso ou confirmar.
O contador de caracteres mostra quanto falta ate o limite.

|cffffd100-- Tamanho dinamico --|r
Ative |cffffd100Altura dinamica|r e |cffffd100Largura dinamica|r na aba Designer.
A altura se ajusta ao tamanho da fonte; a largura cresce com o comprimento da mensagem.]]

L["HELP_BODY_SECURE"] = "|cffffd100-- Por que o BigChatBox pausa em combate/M+/etc. --|r\n\n" ..
    "Com a expansao Meia-Noite (12.0), a Blizzard fez mudancas significativas em como os addons interagem com o jogo em combate. Essa iniciativa e conhecida como |cff5599ffDesarmamento de Addons|r e restringe como os addons podem lidar com informacoes de combate.\n\n" ..
    "|cffffd100O que mudou?|r\n" ..
    "Os dados relacionados ao combate agora sao tratados como |cffff9900valores secretos|r. Os addons podem exibir essas informacoes, mas nao ler nem processar no codigo.\n\n" ..
    "Muitos frames de interface agora sao |cffff9900protegidos|r em combate. Em conteudo de instancia (M+, arena, BG classificado), as restricoes sao ainda mais rigorosas. Qualquer addon que modifique ou enganche esses frames protegidos arrisca propagar |cffff6666contaminacao|r, podendo quebrar completamente a funcionalidade do jogo -- nao apenas do addon, mas tambem funcoes basicas como selecionar alvo, lancar feiticos e usar habilidades.\n\n" ..
    "|cffffd100Como isso afeta o BigChatBox?|r\n" ..
    "A caixa de entrada de chat padrao do WoW (ChatFrame1EditBox) e um frame protegido pois processa comandos de barra seguros como /target, /cast e /focus. O BigChatBox enganha esse frame para interceptar a entrada de chat. Em combate e em conteudo competitivo de instancia, esses ganchos podem causar contaminacao, bloqueando todo o sistema de chat.\n\n" ..
    "Para protege-lo, o BigChatBox se |cff00ff00pausa automaticamente|r durante o combate e em M+, arena e BG classificado. A caixa de entrada de chat padrao da Blizzard assume o controle sem interrupcoes. Quando o combate termina ou o conteudo e concluido, o BigChatBox retoma automaticamente.\n\n" ..
    "|cffffd100Por que nao e simplesmente corrigido?|r\n" ..
    "Nao e um |cffff0000bug|r. E uma limitacao fundamental do modelo de seguranca do WoW. Todos os addons que modificam frames protegidos em combate enfrentam a mesma restricao. A Blizzard projetou essas limitacoes para evitar que os addons automatizem decisoes de combate, e a caixa de entrada de chat esta dentro do escopo protegido.\n\n" ..
    "|cffffd100Resumo|r\n" ..
    "O BigChatBox pausa durante o combate e em conteudo cronometrado (M+, arena, BG classificado). Durante esse tempo voce ainda pode conversar normalmente com a caixa de entrada padrao da Blizzard. Quando o combate terminar ou a atividade for concluida, o BigChatBox retomara automaticamente."

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100-- Por que nem todo Shift+clique funciona? --|r\n\n" ..
    "A maioria dos Shift+cliques para inserir links funciona diretamente no BigChatBox. No entanto, alguns paineis do jogo usam uma funcao interna da Blizzard que insere links apenas na caixa de entrada da Blizzard, ignorando a dos addons.\n\n" ..
    "|cff00ff00Funciona no BigChatBox:|r\n" ..
    "  - Itens das mochilas pessoais\n" ..
    "  - Mascotes do Diario de Mascotes\n" ..
    "  - Heirlooms do painel de Heirlooms\n" ..
    "  - Itens do vendedor\n" ..
    "  - Itens da caixa de correio\n" ..
    "  - Receitas e materiais do painel de Profissoes\n" ..
    "  - Links nas janelas de chat\n\n" ..
    "|cffff9900Requer o chat da Blizzard:|r\n" ..
    "  - Conquistas do painel de Conquistas\n" ..
    "  - Itens do Banco\n" ..
    "  - Itens do Banco da Guilda\n" ..
    "  - Montarias do Diario de Montarias\n" ..
    "  - Talentos do painel de Talentos\n" ..
    "  - Aparencias de Transmogrifificacao\n" ..
    "  - Alguns paineis especificos de expansao\n\n" ..
    "|cffffd100Por que?|r\n" ..
    "Esses paineis usam a funcao interna do WoW |cff5599ffChatEdit_InsertLink|r, que verifica uma caixa de entrada especifica da Blizzard. O BCB intercepta a maioria dessas chamadas, mas alguns paineis contornam completamente os ganchos padrao devido a como a Blizzard os implementa. E uma limitacao da API do WoW, nao um bug.\n\n" ..
    "|cffffd100Solucao|r\n" ..
    "Pressione a |cff5599ffTecla de chat da Blizzard|r (padrao: Ctrl+Enter) para alternar instantaneamente para a caixa de chat nativa. Digite ou faca Shift+clique la e pressione Enter para enviar; o BigChatBox retomara automaticamente na proxima mensagem.\n\n" ..
    "Para alterar ou remover essa tecla:\n" ..
    "  - |cffffd100/bcb|r > aba Avancado\n" ..
    "  - Esc > Atalhos de Teclado > Addons > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "Mudar para %s e reiniciar a configuracao?\nO BigChatBox sera recarregado para aplicar o novo idioma."

-- !! v5.6.1 Emoji & Emoticon picker !!-----------------------------------------
L["SECTION_EMOJI"]          = "Seletor de emojis"
L["CB_SHOW_EMOJI_PICKER"]   = "Mostrar botao do seletor de emojis"
L["EMOJI_PICKER_TITLE"]     = "Seletor de emojis"
L["EMOJI_PICKER_TOOLTIP"]   = "Clique para abrir o seletor de emojis"
L["EMOJI_TAB_LAST"]         = "Recentes"
L["EMOJI_TAB_ASCII"]        = "Emoticons"
L["EMOJI_LAST_EMPTY"]       = "Nenhuma selecao recente."

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "Pesquisar no histórico..."

L["BTN_SAVE_SNIPPET"]           = "Salvar"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "Usar estilo padrão"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "Quando marcado, a caixa multilinhas usa o estilo padrão independentemente do estilo ativo. Desmarque para usar a aparência BCB atual."

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "Entrada multilinhas"
L["CB_ENABLE_MULTILINE"]        = "Ativar entrada multilinhas"
L["CB_ENABLE_MULTILINE_HELP"]   = "Abre uma caixa multilinhas grande para redigir mensagens. Cada linha é enviada separadamente."
L["KEYBIND_OPEN_MULTILINE"]     = "Abrir entrada multilinhas:"
L["MULTILINE_KEYBIND_HELP"]     = "Padrão: Shift+Enter. Abre uma caixa de entrada grande onde Enter adiciona uma nova linha e Shift+Enter envia todas as linhas."
L["BTN_OPEN_KEYBINDINGS"]       = "Abrir teclas de atalho"
L["MULTILINE_SEND_BTN"]         = "Enviar"
L["MULTILINE_CHANNEL_LABEL"]    = "Canal: %s"
L["MULTILINE_BLOCKED_SECURE"]   = "A entrada multilinhas não está disponível durante M+/Arena/BG classificada."
L["MULTILINE_HINT"]             = "Enter = nova linha   |   Shift+Enter = enviar tudo"
