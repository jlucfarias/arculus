import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const String themeModeSettingKey = 'theme_mode';
  Set<String> _themeMode = {'system'};

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _loadSettings() async {
    final settings = await SharedPreferences.getInstance();
    final themeMode = settings.getString(themeModeSettingKey);

    if (themeMode != null) {
      setState(() {
        _themeMode = {themeMode};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goBack(context),
        ),
        title: Text(l10n.settingsScreen_title),
        backgroundColor: themeProvider.currentTheme.colors.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: themeProvider.currentTheme.colors.background,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.settingsScreen_themeRow_title),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton(
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.standard,
                    ),
                    segments: [
                      ButtonSegment(
                        value: 'system',
                        label: Text(
                          l10n.settingsScreen_themeRow_themeOptionSystem_label,
                        ),
                      ),
                      ButtonSegment(
                        value: 'light',
                        label: Text(
                          l10n.settingsScreen_themeRow_themeOptionLight_label,
                        ),
                      ),
                      ButtonSegment(
                        value: 'dark',
                        label: Text(
                          l10n.settingsScreen_themeRow_themeOptionDark_label,
                        ),
                      ),
                    ],
                    selected: _themeMode,
                    onSelectionChanged: (Set<String> themeMode) {
                      context.read<ThemeProvider>().setTheme(themeMode.first);
                      setState(() {
                        _themeMode = themeMode;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
