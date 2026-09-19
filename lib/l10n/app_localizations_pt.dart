// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get homeScreen_deleteAccountDialog_title => 'Excluir conta';

  @override
  String get homeScreen_deleteAccountDialog_content =>
      'Você têm certeza que deseja excluir essa conta?';

  @override
  String get homeScreen_deleteAccountDialog_cancelButton_label => 'Cancelar';

  @override
  String get homeScreen_deleteAccountDialog_confirmButton_label => 'Excluir';

  @override
  String get homeScreen_emptyAccountList_title => 'Nenhuma conta registrada';

  @override
  String get homeScreen_emptyAccountList_description =>
      'Toque no + para adicionar uma conta';

  @override
  String get homeScreen_editAction_tooltipText => 'Editar conta';

  @override
  String get homeScreen_deleteAction_tooltipText => 'Excluir conta';

  @override
  String get homeScreen_toggleVisibilityAction_tooltip_on => 'Esconder códigos';

  @override
  String get homeScreen_toggleVisibilityAction_tooltip_off => 'Mostrar códigos';

  @override
  String get homeScreen_optionsMenuAction_tooltipText => 'Mais opções';

  @override
  String get homeScreen_optionsMenuAction_settingsItemLabel => 'Configurações';

  @override
  String get homeScreen_floatActionButton_label => 'Adicionar';

  @override
  String get homeScreen_foldersBar_allAccountsFolder_label => 'Todas';

  @override
  String get homeScreen_foldersBar_addFolderButton_tooltipText =>
      'Adicionar pasta';

  @override
  String get homeScreen_addFolderDialog_title => 'Nova pasta';

  @override
  String get homeScreen_addFolderDialog_nameInput_hintText => 'Nome da pasta';

  @override
  String get homeScreen_addFolderDialog_action_cancel_label => 'Cancelar';

  @override
  String get homeScreen_addFolderDialog_action_save_label => 'Criar';

  @override
  String get homeScreen_deleteFolderDialog_title => 'Excluir pasta';

  @override
  String get homeScreen_deleteFolderDialog_content =>
      'Você têm certeza que deseja excluir essa pasta?';

  @override
  String get homeScreen_deleteFolderDialog_action_cancel_label => 'Cancelar';

  @override
  String get homeScreen_deleteFolderDialog_action_delete_label => 'Excluir';

  @override
  String get homeScreen_tokenCard_copyButton_tooltip => 'Copiar código';

  @override
  String get homeScreen_tokenCopiedSnackbar_content => 'Código copiado';

  @override
  String get homeScreen_tokenCard_visibilityButton_tooltip_on =>
      'Esconder código';

  @override
  String get homeScreen_tokenCard_visibilityButton_tooltip_off =>
      'Mostrar código';

  @override
  String get accountScreen_addAccount_title => 'Adicionar conta';

  @override
  String get accountScreen_editAccount_title => 'Editar conta';

  @override
  String get accountScreen_nameInput_label => 'Nome';

  @override
  String get accountScreen_nameInput_emptyErrorMessage => 'Nome da conta vazio';

  @override
  String get accountScreen_issuerInput_label => 'Emissor';

  @override
  String get accountScreen_foldersInput_label => 'Pasta';

  @override
  String get accountScreen_foldersInput_defaultText => 'Sem pasta';

  @override
  String get accountScreen_addFolderModal_title => 'Pastas';

  @override
  String get accountScreen_addFolderModal_addFolderButton_label => 'Nova pasta';

  @override
  String get accountScreen_addFolderModal_action_cleanUp_label => 'Limpar';

  @override
  String get accountScreen_addFolderModal_action_save_label => 'Salvar';

  @override
  String get accountScreen_addFolderDialog_title => 'Nova pasta';

  @override
  String get accountScreen_addFolderDialog_nameInput_hintText =>
      'Nome da pasta';

  @override
  String get accountScreen_addFolderDialog_action_cancel_label => 'Cancelar';

  @override
  String get accountScreen_addFolderDialog_action_save_label => 'Criar';

  @override
  String get accountScreen_secretInput_label => 'Segredo';

  @override
  String get accountScreen_secretInput_showSecretTooltip => 'Mostrar segredo';

  @override
  String get accountScreen_secretInput_emptyErrorMessage => 'Segredo vazio';

  @override
  String get accountScreen_secretInput_invalidErrorMessage =>
      'Segredo inválido (Base32)';

  @override
  String get accountScreen_advancedExpander_label => 'Avançado';

  @override
  String get accountScreen_tokeTypeSelector_label => 'Tipo';

  @override
  String get accountScreen_algorithmSelector_label => 'Função de hash';

  @override
  String get accountScreen_intervalInput_label => 'Intervalo (segundos)';

  @override
  String get accountScreen_intervalInput_emptyErrorMessage => 'Invervalo vazio';

  @override
  String get accountScreen_intervalInput_invalidErrorMessage =>
      'Intervalo inválido';

  @override
  String get accountScreen_digitsInput_label => 'Dígitos';

  @override
  String get accountScreen_digitsInput_emptyErrorMessage => 'Dígitos vazios';

  @override
  String get accountScreen_digitsInput_invalidErrorMessage =>
      'Dígitos inválidos';

  @override
  String get accountScreen_addAccount_confirmButton_label => 'Adicionar';

  @override
  String get accountScreen_editAccount_confirmButton_label =>
      'Salvar Alterações';

  @override
  String get accountScreen_saveAccount_saveErrorMessage => 'Falha ao salvar';

  @override
  String get settingsScreen_backButton_tooltip => 'Voltar';

  @override
  String get settingsScreen_title => 'Configurações';

  @override
  String get settingsScreen_themeRow_title => 'Tema';

  @override
  String get settingsScreen_themeRow_themeOptionSystem_label => 'Sistema';

  @override
  String get settingsScreen_themeRow_themeOptionLight_label => 'Claro';

  @override
  String get settingsScreen_themeRow_themeOptionDark_label => 'Escuro';

  @override
  String get settingsScreen_AmoledThemeSwitch_label =>
      'Modo noturno com preto absoluto (AMOLED)';

  @override
  String get settingsScreen_languageDialogTrigger_label => 'Idioma';

  @override
  String get settingsScreen_languageDialog_title => 'Escolha o idioma';

  @override
  String get settingsScreen_languageDialog_systemDefaultOption_label =>
      'Padrão do sistema';

  @override
  String get settingsScreen_languageDialog_cancelButton_label => 'Cancelar';

  @override
  String get settingsScreen_languageDialog_confirmButton_label => 'Confirmar';
}
