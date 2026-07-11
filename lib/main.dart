import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arculus/repositories/token_repository.dart';
import 'package:arculus/screens/home_screen.dart';
import 'package:arculus/utils/app_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  runApp(
    MultiProvider(
      providers: [
        Provider<TokenRepository>(create: (_) => TokenRepository(database)),
      ],
      child: const Arculus(),
    ),
  );
}

class Arculus extends StatelessWidget {
  const Arculus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
