// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeScreen_deleteAccountDialog_title => 'Delete account';

  @override
  String get homeScreen_deleteAccountDialog_content =>
      'Are you sure you want to delete this account?';

  @override
  String get homeScreen_deleteAccountDialog_cancelButton_label => 'Cancel';

  @override
  String get homeScreen_deleteAccountDialog_confirmButton_label => 'Delete';

  @override
  String get homeScreen_emptyAccountList_title => 'No accounts registered';

  @override
  String get homeScreen_emptyAccountList_description =>
      'Press on + to add an account';

  @override
  String get homeScreen_editAction_tooltipText => 'Edit account';

  @override
  String get homeScreen_deleteAction_tooltipText => 'Delete account';

  @override
  String get homeScreen_toggleVisibilityAction_tooltip_on => 'Hide tokens';

  @override
  String get homeScreen_toggleVisibilityAction_tooltip_off => 'Show tokens';

  @override
  String get homeScreen_optionsMenuAction_tooltipText => 'More options';

  @override
  String get homeScreen_optionsMenuAction_settingsItemLabel => 'Settings';

  @override
  String get homeScreen_floatActionButton_label => 'Add';

  @override
  String get homeScreen_foldersBar_allAccountsFolder_label => 'All';

  @override
  String get homeScreen_foldersBar_addFolderButton_tooltipText => 'Add folder';

  @override
  String get homeScreen_addFolderDialog_title => 'New folder';

  @override
  String get homeScreen_addFolderDialog_nameInput_hintText => 'Folder name';

  @override
  String get homeScreen_addFolderDialog_action_cancel_label => 'Cancel';

  @override
  String get homeScreen_addFolderDialog_action_save_label => 'Create';

  @override
  String get homeScreen_deleteFolderDialog_title => 'Delete folder';

  @override
  String get homeScreen_deleteFolderDialog_content =>
      'Are you sure you want to delete this folder?';

  @override
  String get homeScreen_deleteFolderDialog_action_cancel_label => 'Cancel';

  @override
  String get homeScreen_deleteFolderDialog_action_delete_label => 'Delete';

  @override
  String get homeScreen_tokenCard_copyButton_tooltip => 'Copy token';

  @override
  String get homeScreen_tokenCopiedSnackbar_content => 'Token copied';

  @override
  String get homeScreen_tokenCard_visibilityButton_tooltip_on => 'Hide token';

  @override
  String get homeScreen_tokenCard_visibilityButton_tooltip_off => 'Show token';

  @override
  String get accountScreen_addAccount_title => 'Add account';

  @override
  String get accountScreen_editAccount_title => 'Edit account';

  @override
  String get accountScreen_nameInput_label => 'Name';

  @override
  String get accountScreen_nameInput_emptyErrorMessage =>
      'Account name is empty';

  @override
  String get accountScreen_issuerInput_label => 'Issuer';

  @override
  String get accountScreen_foldersInput_label => 'Folder';

  @override
  String get accountScreen_foldersInput_defaultText => 'No folder';

  @override
  String get accountScreen_addFolderModal_title => 'Folders';

  @override
  String get accountScreen_addFolderModal_addFolderButton_label => 'New folder';

  @override
  String get accountScreen_addFolderModal_action_cleanUp_label => 'Clear';

  @override
  String get accountScreen_addFolderModal_action_save_label => 'Save';

  @override
  String get accountScreen_addFolderDialog_title => 'New folder';

  @override
  String get accountScreen_addFolderDialog_nameInput_hintText => 'Folder name';

  @override
  String get accountScreen_addFolderDialog_action_cancel_label => 'Cancel';

  @override
  String get accountScreen_addFolderDialog_action_save_label => 'Create';

  @override
  String get accountScreen_secretInput_label => 'Secret';

  @override
  String get accountScreen_secretInput_showSecretTooltip => 'Show secret';

  @override
  String get accountScreen_secretInput_emptyErrorMessage => 'Secret is empty';

  @override
  String get accountScreen_secretInput_invalidErrorMessage =>
      'Secret is invalid (Base32)';

  @override
  String get accountScreen_advancedExpander_label => 'Advanced';

  @override
  String get accountScreen_tokeTypeSelector_label => 'Type';

  @override
  String get accountScreen_algorithmSelector_label => 'Hash function';

  @override
  String get accountScreen_intervalInput_label => 'Interval (seconds)';

  @override
  String get accountScreen_intervalInput_emptyErrorMessage =>
      'Interval is empty';

  @override
  String get accountScreen_intervalInput_invalidErrorMessage =>
      'Interval is invalid';

  @override
  String get accountScreen_digitsInput_label => 'Digits';

  @override
  String get accountScreen_digitsInput_emptyErrorMessage => 'Digits is empty';

  @override
  String get accountScreen_digitsInput_invalidErrorMessage =>
      'Digits is invalid';

  @override
  String get accountScreen_addAccount_confirmButton_label => 'Add';

  @override
  String get accountScreen_editAccount_confirmButton_label => 'Save updates';

  @override
  String get accountScreen_saveAccount_saveErrorMessage => 'Save failed';

  @override
  String get settingsScreen_backButton_tooltip => 'Back';

  @override
  String get settingsScreen_title => 'Settings';

  @override
  String get settingsScreen_themeRow_title => 'Theme';

  @override
  String get settingsScreen_themeRow_themeOptionSystem_label => 'System';

  @override
  String get settingsScreen_themeRow_themeOptionLight_label => 'Light';

  @override
  String get settingsScreen_themeRow_themeOptionDark_label => 'Dark';

  @override
  String get settingsScreen_AmoledThemeSwitch_label =>
      'Dark mode with full black (AMOLED)';

  @override
  String get settingsScreen_languageDialogTrigger_label => 'Language';

  @override
  String get settingsScreen_languageDialog_title => 'Choose language';

  @override
  String get settingsScreen_languageDialog_systemDefaultOption_label =>
      'System default';

  @override
  String get settingsScreen_languageDialog_cancelButton_label => 'Cancel';

  @override
  String get settingsScreen_languageDialog_confirmButton_label => 'Confirm';
}
