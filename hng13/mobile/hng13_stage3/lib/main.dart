import 'package:flutter/material.dart';

import 'presentations/screens/browse_screen.dart';
import 'presentations/screens/favorite_screen.dart';
import 'presentations/screens/home_screen.dart';
import 'presentations/screens/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Studio',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/browse': (context) => const BrowseScreen(),
        '/favorite': (context) => const FavoriteScreen(),
        '/setting': (context) => const SettingScreen(),
      },
    );
  }
}
