import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'package:arculus/l10n/app_localizations.dart';
import 'package:arculus/providers/locale_provider.dart';
import 'package:arculus/providers/theme_provider.dart';
import 'package:arculus/repositories/account_repository.dart';
import 'package:arculus/screens/home_screen.dart';
import 'package:arculus/utils/app_constants.dart';
import 'package:arculus/utils/app_database.dart';
import 'package:arculus/utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(create: (_) => AccountRepository(database)),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: const Arculus(),
    ),
  );
}

class Arculus extends StatelessWidget {
  const Arculus({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.title,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme(isAmoled: themeProvider.useAmoled),
      themeMode: themeProvider.themeMode,
      localizationsDelegates: [
        ...AppLocalizations.localizationsDelegates,
        LocaleNamesLocalizationsDelegate(),
      ],
      locale: localeProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
