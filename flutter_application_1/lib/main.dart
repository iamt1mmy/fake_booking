import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

/// Punctul de intrare al aplicației.
/// Rulează widget-ul principal `MyApp`.
void main() {
  runApp(const MyApp());
}

/// Widget-ul principal al aplicației care gestionează tema globală.
/// `MyApp` este un `StatefulWidget` deoarece păstrează starea curentă a temei (light/dark) și o transmite către ecranul principal (`HomeScreen`).
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// Starea internă a `MyApp`.
/// Păstrează `ThemeMode` curent și oferă o metodă pentru comutarea temei.
class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  /// Comută tema în funcție de `isDark`.
  /// Folosit ca callback pentru `HomeScreen` pentru a schimba tema globală.
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  /// Construiește `MaterialApp` și furnizează tema curentă.
  /// `theme` și `darkTheme` sunt configurate; `themeMode` controlează care dintre ele este activă.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: HomeScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );        
  }
}