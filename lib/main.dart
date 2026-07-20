import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arculus/l10n/app_localizations.dart';
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.title,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
