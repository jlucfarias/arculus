import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// Title of the delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get homeScreen_deleteAccountDialog_title;

  /// Content of the delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this account?'**
  String get homeScreen_deleteAccountDialog_content;

  /// Label of the cancel button on the delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get homeScreen_deleteAccountDialog_cancelButton_label;

  /// Label of the confirm button on the delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get homeScreen_deleteAccountDialog_confirmButton_label;

  /// Title of the empty account list on home screen
  ///
  /// In en, this message translates to:
  /// **'No accounts registered'**
  String get homeScreen_emptyAccountList_title;

  /// Description of the empty account list on home screen
  ///
  /// In en, this message translates to:
  /// **'Press on + to add an account'**
  String get homeScreen_emptyAccountList_description;

  /// Tooltip text for the edit account action on the home screen
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get homeScreen_editAction_tooltipText;

  /// Tooltip text for the delete account action on the home screen
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get homeScreen_deleteAction_tooltipText;

  /// Tooltip text for the toggle token visibility action on the home screen when state is on
  ///
  /// In en, this message translates to:
  /// **'Hide tokens'**
  String get homeScreen_toggleVisibilityAction_tooltip_on;

  /// Tooltip text for the toggle token visibility action on the home screen when state is off
  ///
  /// In en, this message translates to:
  /// **'Show tokens'**
  String get homeScreen_toggleVisibilityAction_tooltip_off;

  /// Tooltip text for the more options action on the home screen
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get homeScreen_optionsMenuAction_tooltipText;

  /// Label of the settings item in the options menu
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeScreen_optionsMenuAction_settingsItemLabel;

  /// Label for the floating action button on home screen
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get homeScreen_floatActionButton_label;

  /// Label of the all accounts folder in folders bar
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeScreen_foldersBar_allAccountsFolder_label;

  /// Tooltip text of the add folder button in folders bar
  ///
  /// In en, this message translates to:
  /// **'Add folder'**
  String get homeScreen_foldersBar_addFolderButton_tooltipText;

  /// Title of the dialog for folder addition
  ///
  /// In en, this message translates to:
  /// **'New folder'**
  String get homeScreen_addFolderDialog_title;

  /// Hint text of the folder name input on modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Folder name'**
  String get homeScreen_addFolderDialog_nameInput_hintText;

  /// Label of the cancel action on modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get homeScreen_addFolderDialog_action_cancel_label;

  /// Label of the create action on modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get homeScreen_addFolderDialog_action_save_label;

  /// Title of the dialog for folder deletion
  ///
  /// In en, this message translates to:
  /// **'Delete folder'**
  String get homeScreen_deleteFolderDialog_title;

  /// Content of the dialog for folder deletion
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this folder?'**
  String get homeScreen_deleteFolderDialog_content;

  /// Label of the cancel action on modal for folder deletion
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get homeScreen_deleteFolderDialog_action_cancel_label;

  /// Label of the delete action on modal for folder deletion
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get homeScreen_deleteFolderDialog_action_delete_label;

  /// Tooltip of the button for copy token on token card
  ///
  /// In en, this message translates to:
  /// **'Copy token'**
  String get homeScreen_tokenCard_copyButton_tooltip;

  /// Content of the snackbar for token copied
  ///
  /// In en, this message translates to:
  /// **'Token copied'**
  String get homeScreen_tokenCopiedSnackbar_content;

  /// Tooltip of the button for toggle token visibility on token card when state is on
  ///
  /// In en, this message translates to:
  /// **'Hide token'**
  String get homeScreen_tokenCard_visibilityButton_tooltip_on;

  /// Tooltip of the button for toggle token visibility on token card when state is off
  ///
  /// In en, this message translates to:
  /// **'Show token'**
  String get homeScreen_tokenCard_visibilityButton_tooltip_off;

  /// Title of the account screen when adding account
  ///
  /// In en, this message translates to:
  /// **'Add account'**
  String get accountScreen_addAccount_title;

  /// Title of the account screen when editing account
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get accountScreen_editAccount_title;

  /// Label of the name input on account screen
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get accountScreen_nameInput_label;

  /// Error message when name input is empty
  ///
  /// In en, this message translates to:
  /// **'Account name is empty'**
  String get accountScreen_nameInput_emptyErrorMessage;

  /// Label of the issuer input on account screen
  ///
  /// In en, this message translates to:
  /// **'Issuer'**
  String get accountScreen_issuerInput_label;

  /// Label of the folders input on account screen
  ///
  /// In en, this message translates to:
  /// **'Folder'**
  String get accountScreen_foldersInput_label;

  /// Default text for folders input
  ///
  /// In en, this message translates to:
  /// **'No folder'**
  String get accountScreen_foldersInput_defaultText;

  /// Title of the modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get accountScreen_addFolderModal_title;

  /// Label of the add folder button on modal folder addition
  ///
  /// In en, this message translates to:
  /// **'New folder'**
  String get accountScreen_addFolderModal_addFolderButton_label;

  /// Label of the clean up action on modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get accountScreen_addFolderModal_action_cleanUp_label;

  /// Label of the save action on modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get accountScreen_addFolderModal_action_save_label;

  /// Title of the dialog for folder addition
  ///
  /// In en, this message translates to:
  /// **'New folder'**
  String get accountScreen_addFolderDialog_title;

  /// Hint text of the folder name input on modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Folder name'**
  String get accountScreen_addFolderDialog_nameInput_hintText;

  /// Label of the cancel action on modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get accountScreen_addFolderDialog_action_cancel_label;

  /// Label of the create action on modal for folder addition
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get accountScreen_addFolderDialog_action_save_label;

  /// Label of the secret input on account screen
  ///
  /// In en, this message translates to:
  /// **'Secret'**
  String get accountScreen_secretInput_label;

  /// Tooltip for showing secret
  ///
  /// In en, this message translates to:
  /// **'Show secret'**
  String get accountScreen_secretInput_showSecretTooltip;

  /// Error message when secret input is empty
  ///
  /// In en, this message translates to:
  /// **'Secret is empty'**
  String get accountScreen_secretInput_emptyErrorMessage;

  /// Error message when secret input is invalid
  ///
  /// In en, this message translates to:
  /// **'Secret is invalid (Base32)'**
  String get accountScreen_secretInput_invalidErrorMessage;

  /// Label of the advanced expander on account screen
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get accountScreen_advancedExpander_label;

  /// Label of the token type selector on account screen
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get accountScreen_tokeTypeSelector_label;

  /// Label of the algorithm selector on account screen
  ///
  /// In en, this message translates to:
  /// **'Hash function'**
  String get accountScreen_algorithmSelector_label;

  /// Label of the interval input on account screen
  ///
  /// In en, this message translates to:
  /// **'Interval (seconds)'**
  String get accountScreen_intervalInput_label;

  /// Error message when interval input is empty
  ///
  /// In en, this message translates to:
  /// **'Interval is empty'**
  String get accountScreen_intervalInput_emptyErrorMessage;

  /// Error message when interval input is invalid
  ///
  /// In en, this message translates to:
  /// **'Interval is invalid'**
  String get accountScreen_intervalInput_invalidErrorMessage;

  /// Label of the digits input on account screen
  ///
  /// In en, this message translates to:
  /// **'Digits'**
  String get accountScreen_digitsInput_label;

  /// Error message when digits input is empty
  ///
  /// In en, this message translates to:
  /// **'Digits is empty'**
  String get accountScreen_digitsInput_emptyErrorMessage;

  /// Error message when digits input is invalid
  ///
  /// In en, this message translates to:
  /// **'Digits is invalid'**
  String get accountScreen_digitsInput_invalidErrorMessage;

  /// Label of the confirm button on account screen when adding account
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get accountScreen_addAccount_confirmButton_label;

  /// Label of the confirm button on account screen when editing account
  ///
  /// In en, this message translates to:
  /// **'Save updates'**
  String get accountScreen_editAccount_confirmButton_label;

  /// Error message when saving account fails
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get accountScreen_saveAccount_saveErrorMessage;

  /// Tooltip for back button on settings screen
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get settingsScreen_backButton_tooltip;

  /// Title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsScreen_title;

  /// Title of the theme row in settings screen
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsScreen_themeRow_title;

  /// Label of the system theme option in settings screen
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsScreen_themeRow_themeOptionSystem_label;

  /// Label of the light theme option in settings screen
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsScreen_themeRow_themeOptionLight_label;

  /// Label of the dark theme option in settings screen
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsScreen_themeRow_themeOptionDark_label;

  /// Label of the Amoled theme switch in settings screen
  ///
  /// In en, this message translates to:
  /// **'Dark mode with full black (AMOLED)'**
  String get settingsScreen_AmoledThemeSwitch_label;

  /// Label of the trigger that open language selection dialog in settings screen
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsScreen_languageDialogTrigger_label;

  /// Title of the language selection dialog in settings screen
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get settingsScreen_languageDialog_title;

  /// Label of the system default language option on language dialog in settings screen
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsScreen_languageDialog_systemDefaultOption_label;

  /// Label of the cancel button on language dialog in settings screen
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsScreen_languageDialog_cancelButton_label;

  /// Label of the confirm button on language dialog in settings screen
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get settingsScreen_languageDialog_confirmButton_label;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
