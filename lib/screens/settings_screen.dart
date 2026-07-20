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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n.settingsScreen_backButton_tooltip,
          onPressed: () => _goBack(context),
        ),
        title: Text(l10n.settingsScreen_title, style: textTheme.titleMedium),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ThemeSpacing.medium, vertical: ThemeSpacing.halfMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.settingsScreen_themeRow_title),
              SizedBox(height: ThemeSpacing.medium),
              SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }
}
