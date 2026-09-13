import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';

import 'package:arculus/l10n/app_localizations.dart';
import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/providers/locale_provider.dart';
import 'package:arculus/providers/theme_provider.dart';
import 'package:arculus/utils/app_constants.dart';
import 'package:arculus/utils/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _goBack() {
    Navigator.pop(context);
  }

  void _showLanguageDialog() {
    final l10n = context.l10n;
    List<SelectOption<String>> options = [
      SelectOption(
        value: 'sys',
        label: l10n.settingsScreen_languageDialog_systemDefaultOption_label,
      ),
    ];

    final supportedLocales = AppLocalizations.supportedLocales;
    final localeProvider = context.read<LocaleProvider>();

    for (var locale in supportedLocales) {
      final localeKey = locale.toString();
      String nativeName =
          LocaleNamesLocalizationsDelegate.nativeLocaleNames[localeKey] ??
          locale.languageCode;

      if (nativeName.isNotEmpty) {
        nativeName = nativeName[0].toUpperCase() + nativeName.substring(1);
      }

      options.add(
        SelectOption(value: locale.languageCode, label: nativeName),
      );
    }

    String selectedValue = options
        .firstWhere(
          (option) => option.value == localeProvider.locale?.languageCode,
          orElse: () => options.first,
        )
        .value;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.settingsScreen_languageDialog_title),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return RadioGroup<String>(
                groupValue: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.map((option) {
                    return RadioListTile<String>(
                      title: Text(option.label),
                      value: option.value,
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.settingsScreen_languageDialog_cancelButton_label,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedValue);
              },
              child: Text(
                l10n.settingsScreen_languageDialog_confirmButton_label,
              ),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        localeProvider.setLocale(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeProvider = context.watch<ThemeProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n.settingsScreen_backButton_tooltip,
          onPressed: () => _goBack(),
        ),
        title: Text(l10n.settingsScreen_title),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ThemeSpacing.halfMedium),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ThemeSpacing.medium),
              child: Text(
                l10n.settingsScreen_themeRow_title,
                style: ThemeTypography.bodyBold(colorScheme.primary),
              ),
            ),
            SizedBox(height: ThemeSpacing.medium),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ThemeSpacing.medium),
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text(
                        l10n.settingsScreen_themeRow_themeOptionSystem_label,
                      ),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text(
                        l10n.settingsScreen_themeRow_themeOptionLight_label,
                      ),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text(
                        l10n.settingsScreen_themeRow_themeOptionDark_label,
                      ),
                    ),
                  ],
                  selected: {themeProvider.themeMode},
                  onSelectionChanged: (Set<ThemeMode> themeMode) {
                    themeProvider.setThemeMode(themeMode.first);
                  },
                ),
              ),
            ),
            SizedBox(height: ThemeSpacing.halfMedium),
            SizedBox(
              width: double.infinity,
              child: SwitchListTile(
                title: Text(l10n.settingsScreen_AmoledThemeSwitch_label),
                value: themeProvider.useAmoled,
                onChanged: (_) {
                  themeProvider.toggleAmoledUse();
                },
                //controlAffinity: ListTileControlAffinity.leading,
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => _showLanguageDialog(),
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(
                    colorScheme.onSurface,
                  ),
                  overlayColor: WidgetStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return themeProvider.themeMode.isLight
                          ? ThemeColors.grey3
                          : themeProvider.useAmoled
                          ? ThemeColors.grey7.withValues(alpha: 0.8)
                          : ThemeColors.grey6.withValues(alpha: 0.6);
                    }

                    return null;
                  }),
                  alignment: Alignment.centerLeft,
                  shape: const WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                child: Text(l10n.settingsScreen_languageDialogTrigger_label),
              ),
            ),

            SizedBox(height: ThemeSpacing.large),
          ],
        ),
      ),
    );
  }
}
