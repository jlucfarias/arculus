import 'package:flutter/material.dart';

import 'package:arculus/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Arculus());
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
