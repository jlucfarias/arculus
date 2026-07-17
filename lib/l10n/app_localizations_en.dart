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
  String get homeScreen_optionsMenuAction_tooltipText => 'More options';

  @override
  String get homeScreen_optionsMenuAction_settingsItemLabel => 'Settings';

  @override
  String get homeScreen_floatActionButton_label => 'Add';

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
  String get accountScreen_secretInput_label => 'Secret';

  @override
  String get accountScreen_secretInput_showSecretTooltip => 'Show secret';

  @override
  String get accountScreen_secretInput_emptyErrorMessage => 'Secret is empty';

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
  String get accountScreen_editAccount_confirmButton_label => 'Add';

  @override
  String get accountScreen_addAccount_confirmButton_label => 'Save updates';

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
}
