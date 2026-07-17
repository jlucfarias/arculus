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
  String get homeScreen_optionsMenuAction_tooltipText => 'Mais opções';

  @override
  String get homeScreen_optionsMenuAction_settingsItemLabel => 'Configurações';

  @override
  String get homeScreen_floatActionButton_label => 'Adicionar';

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
  String get accountScreen_secretInput_label => 'Segredo';

  @override
  String get accountScreen_secretInput_showSecretTooltip => 'Mostrar segredo';

  @override
  String get accountScreen_secretInput_emptyErrorMessage => 'Segredo vazio';

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
  String get accountScreen_editAccount_confirmButton_label => 'Adicionar';

  @override
  String get accountScreen_addAccount_confirmButton_label =>
      'Salvar Alterações';

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
}
