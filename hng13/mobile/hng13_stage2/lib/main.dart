import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/theme_provider.dart';
import 'screens/add_edit_screen.dart';
import 'screens/home_screen.dart';
import 'themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: StoreKeeperApp()));
}

class StoreKeeperApp extends ConsumerWidget {
  const StoreKeeperApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Storekeeper',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => const HomeScreen(),
        '/add-edit': (_) => const AddEditScreen(),
      },
    );
  }
}
