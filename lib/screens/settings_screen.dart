import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/providers/theme_provider.dart';
import 'package:arculus/utils/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _goBack(BuildContext context) {
    Navigator.pop(context);
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
          onPressed: () => _goBack(context),
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
              child: Text(l10n.settingsScreen_themeRow_title, style: ThemeTypography.bodyBold(colorScheme.primary)),
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
                title: Text('Modo noturno com preto absoluto (AMOLED)'),
                value: themeProvider.useAmoled,
                onChanged: (_) {
                  themeProvider.toggleAmoledUse();
                },
                //controlAffinity: ListTileControlAffinity.leading,
              ),
          ),
        ),
      ),
    );
  }
}
